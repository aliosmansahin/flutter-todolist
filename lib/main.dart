/*

Main entrypoint, runs "MyApp"

*/

/*
Imports
*/
import 'dart:async';
import 'dart:ui';

import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:collection/collection.dart';
import 'package:todolist/notifications/notificationcontroller.dart';
import 'package:todolist/provider/globalnotifier.dart';
import 'package:todolist/utils/sortdata.dart';
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
part 'utils/blur.dart';
part 'utils/floatingbutton.dart';
part 'utils/taskstatus.dart';
part 'segments/segmentall.dart';
part 'segments/segmenttoday.dart';
part 'segments/segmentupcoming.dart';
part 'segments/segmenttodo.dart';
part 'segments/segmentcompleted.dart';
part 'segments/segmentoverdue.dart';
part 'segments/segments.dart';
part 'segments/segmentbuttons.dart';
part 'filter/filterui.dart';
part 'filter/filteropened.dart';
part 'filter/filterfloatingbutton.dart';
part 'filter/filterfields/filterimportant.dart';
part 'filter/filterfields/filterstatus.dart';
part 'filter/filterfields/filterdate.dart';
part 'filter/filterformbuttons.dart';
part 'filter/filterfields/filtertype.dart';
part 'search/searchbutton.dart';
part 'search/searchinput.dart';

//Instance for database
late Database db;

//Instace for provider
late GlobalNotifier globalNotifier;

/*

Scheduler for notifications

*/
Future<void> scheduleTaskNotification(Task task) async {
  //print(task.shouldNotify);
  //print(task.notificationSent);
  if (!task.shouldNotify || task.notificationSent) return;

  //Not send notification if it passed
  if (task.dateAndTime.isBefore(DateTime.now())) return;

  NotificationController.scheduleNewNotification(task);

  await (db.update(db.tasks)..where((t) => t.id.equals(task.id))).write(
    TasksCompanion(notificationSent: drift.Value(true)),
  );
}

/*

Cancels task notification

*/
Future<void> cancelTaskNotification(int taskId) async {
  NotificationController.cancelNotification(taskId);
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

  //Time zone
  tz.initializeTimeZones();
  final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(currentTimeZone));

  //Database
  db = Database();

  //Notifications
  await NotificationController.initializeLocalNotifications();
  await NotificationController.initializeIsolateReceivePort();
  await NotificationController.startListeningNotificationEvents();

  await checkAndSchedulePendingNotifications();

  runApp(
    ChangeNotifierProvider(
      create: (context) => GlobalNotifier(),
      child: const MyApp(),
    ),
  );
}

/*

Material App, home will show "mainpage.dart"

*/
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // The navigator key is necessary to navigate using static methods
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  static const String routeHome = "/", routeDetails = "/details-page";

  @override
  void initState() {
    super.initState();
  }

  List<Route<dynamic>> onGenerateInitialRoutes(String initialRouteName) {
    List<Route<dynamic>> pageStack = [];
    pageStack.add(MaterialPageRoute(builder: (context) => MainPage()));

    if (NotificationController.initialAction != null) {
      final payload = NotificationController.initialAction!.payload;
      int? taskId;

      if (payload != null && payload.containsKey("taskid")) {
        taskId = int.tryParse(payload["taskid"]!);
      } else {
        taskId = NotificationController.initialAction!.id;
      }
      pageStack.add(
        MaterialPageRoute(
          builder: (context) => TaskDetail(
            id: taskId!,
            completeTaskFunc: () async {},
          ), //Notified tasks can't be done, so no completeTask function here
        ),
      );
    }
    return pageStack;
  }

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeHome:
        return MaterialPageRoute(builder: (context) => MainPage());
      case routeDetails:
        final args = settings.arguments as Map<String, dynamic>;
        int taskId = args["id"];
        Future<void> Function() completeTaskFunc = args["completeTaskFunc"];
        return MaterialPageRoute(
          builder: (context) =>
              TaskDetail(id: taskId, completeTaskFunc: completeTaskFunc),
        );
    }
    return null;
  }

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
        secondaryHeaderColor: Color.fromARGB(255, 192, 232, 255),
        primaryColor: const Color.fromARGB(255, 0, 51, 161),
        primaryColorDark: const Color.fromARGB(255, 25, 0, 134),
        canvasColor: const Color.fromARGB(255, 255, 255, 255),
        segmentedButtonTheme: SegmentedButtonThemeData(
          style: SegmentedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 192, 232, 255),
            foregroundColor: Colors.black,
            selectedBackgroundColor: const Color.fromARGB(255, 25, 0, 134),
            selectedForegroundColor: Colors.white,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      navigatorKey: MyApp.navigatorKey,
      onGenerateInitialRoutes: onGenerateInitialRoutes,
      onGenerateRoute: onGenerateRoute,
    );
  }
}
