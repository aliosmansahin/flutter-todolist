/*

Main entrypoint, runs "MyApp"

*/

/*
Imports
*/
import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:drift/native.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'database/database.dart';

/*
Other Widget files
*/
part 'mainpage.dart';
part 'taskcard.dart';
part 'addedittask.dart';
part 'taskdetail.dart';

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

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

/*

Scheduler for notifications

*/
Future<void> scheduleTaskNotification(Task task) async {
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
        channelDescription: "For task notifications",
        importance: Importance.high,
        priority: Priority.high,
      ),
    ),
    androidScheduleMode: AndroidScheduleMode.alarmClock,
  );

  await (db.update(db.tasks)..where((t) => t.id.equals(task.id))).write(
    TasksCompanion(notificationSent: Value(true)),
  );
}

/*

Cancels task notification

*/
Future<void> cancelTaskNotification(int taskId) async {
  await flutterLocalNotificationsPlugin.cancel(taskId);
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

Main Function

*/
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();

  //Permission request for notifications
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.requestNotificationsPermission();

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
