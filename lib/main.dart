/*

Main entrypoint, runs "MyApp"

*/

/*
Imports
*/
import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:collection/collection.dart';
import 'package:todolist/utils/tasksegments.dart';

import 'database/database.dart';

/*
Other Widget files
*/
part 'mainpage.dart';
part 'taskcard.dart';
part 'addedittask.dart';
part 'taskdetail.dart';
part 'utils/shadowedfield.dart';
part 'utils/notask.dart';
part 'utils/dateheader.dart';
part 'utils/taskscolumn.dart';
part 'segments/segmentall.dart';
part 'segments/segmenttoday.dart';
part 'segments/segmentupcoming.dart';
part 'segments/segmenttodo.dart';
part 'segments/segmentcompleted.dart';
part 'segments/segmentoverdue.dart';
part 'segments/segments.dart';

//Instance for database
late Database db;

//Instance for notificationsPlugin
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/*

Initializer for notifications

*/
Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

/*

Scheduler for notifications

*/
Future<void> scheduleTaskNotification(Task task) async {
  print(task.shouldNotify);
  print(task.notificationSent);
  if (!task.shouldNotify || task.notificationSent) return;

  //Not send notification if it passed
  if (task.dateAndTime.isBefore(DateTime.now())) return;

  await flutterLocalNotificationsPlugin.zonedSchedule(
    task.id,
    "Task Reminder",
    task.title,
    tz.TZDateTime.from(task.dateAndTime, tz.local),
    const NotificationDetails(
      android: AndroidNotificationDetails(
        "task_channel",
        "Task Notifications",
        channelDescription: "Task notification channel",
        importance: Importance.max,
        priority: Priority.high,
      ),
    ),

    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: null,
  );

  /*flutterLocalNotificationsPlugin.show(
    task.id,
    "Task Reminder",
    task.title,
    const NotificationDetails(
      android: AndroidNotificationDetails(
        "task_channel",
        "Task Notifications",
        channelDescription: "Task notification channel",
        importance: Importance.max,
        priority: Priority.high,
      ),
    ),
  );*/

  print(":::::::notification scheduled");
  print(task.dateAndTime);
  print(tz.TZDateTime.from(task.dateAndTime, tz.local));

  await (db.update(db.tasks)..where((t) => t.id.equals(task.id))).write(
    TasksCompanion(notificationSent: drift.Value(true)),
  );
}

/*

Cancels task notification

*/
Future<void> cancelTaskNotification(int taskId) async {
  await flutterLocalNotificationsPlugin.cancel(taskId);

  print(":::::::notification canceled");
}

/*

Checks for the time and calls schedule function of notifications

*/
Future<void> checkAndSchedulePendingNotifications() async {
  final now = DateTime.now();

  final tasksToNotify =
      await (db.select(db.tasks)..where(
            (tbl) =>
                tbl.shouldNotify.equals(true) &
                tbl.notificationSent.equals(false) &
                tbl.dateAndTime.isBiggerOrEqualValue(now),
          ))
          .get();

  for (final task in tasksToNotify) {
    await scheduleTaskNotification(task);
  }
}

/*

Checks for if the application can schedule exact alarms

*/
Future<bool> canScheduleExactAlarms() async {
  const platform = MethodChannel("alarm_permission");
  try {
    final result = await platform.invokeMethod<bool>("canScheduleExactAlarms");
    return result ?? false;
  } catch (e) {
    print("Coun't check for the exact alarm $e");
    return false;
  }
}

/*

Requests exact alarm permission

*/
Future<void> checkAndRequestExactAlarmPermission() async {
  if (Platform.isAndroid) {
    final canSchedule = await canScheduleExactAlarms();
    if (!canSchedule) {
      //Needs to route settings
      final intent = AndroidIntent(
        action: 'android.settings.REQUEST_SCHEDULE_EXACT_ALARM',
      );
      await intent.launch();
    }
  }
}

/*

Main Function

*/
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();
  final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(currentTimeZone));

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    "task_channel",
    "Task Notifications",
    description: "Task notification channel",
    importance: Importance.max,
  );

  //Permission request for notifications
  final androidImplementation = flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >();

  await androidImplementation?.createNotificationChannel(channel);

  await androidImplementation?.requestExactAlarmsPermission();

  await androidImplementation?.requestNotificationsPermission();

  //await checkAndRequestExactAlarmPermission();

  await initNotifications();

  db = Database(NativeDatabase.memory());

  await checkAndSchedulePendingNotifications();
  runApp(const MyApp());
}

/*

Material App, home will show "mainpage.dart"

*/
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do List',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
