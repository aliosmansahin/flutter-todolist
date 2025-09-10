/*

Stores functions to controll notifications

Created by Ali Osman ŞAHİN on 09/09/2025

*/

import 'dart:isolate';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:todolist/database/database.dart';
import 'package:todolist/main.dart';

class NotificationController {
  static ReceivedAction? initialAction;

  ///  *********************************************
  ///     INITIALIZATIONS
  ///  *********************************************
  ///
  static Future<void> initializeLocalNotifications() async {
    await AwesomeNotifications().initialize(null, [
      NotificationChannel(
        channelKey: "todolist_notification_channel",
        channelName: "To Do List Tasks",
        channelDescription: "Channel for the task notifications",
        importance: NotificationImportance.Max,
        criticalAlerts: true,
        playSound: true,
        enableVibration: true,
      ),
    ], debug: true);

    initialAction = await AwesomeNotifications().getInitialNotificationAction(
      removeFromActionEvents: false,
    );
  }

  static ReceivePort? receivePort;
  static Future<void> initializeIsolateReceivePort() async {
    receivePort = ReceivePort(
      "Todolist notification action port in main isolate",
    )..listen((silentData) => onActionReceivedImplementationMethod(silentData));

    IsolateNameServer.registerPortWithName(
      receivePort!.sendPort,
      "todolist_notification_action_part",
    );
  }

  ///  *********************************************
  ///     NOTIFICATION EVENTS LISTENER
  ///  *********************************************
  ///  Notifications events are only delivered after call this method
  static Future<void> startListeningNotificationEvents() async {
    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
    );
  }

  ///  *********************************************
  ///     NOTIFICATION EVENTS
  ///  *********************************************
  ///
  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    if (receivedAction.actionType == ActionType.SilentAction ||
        receivedAction.actionType == ActionType.SilentBackgroundAction) {
      // For background actions, you must hold the execution until the end
    } else {
      // this process is only necessary when you need to redirect the user
      // to a new page or use a valid context, since parallel isolates do not
      // have valid context, so you need redirect the execution to main isolate

      if (receivePort == null) {
        print(
          'onActionReceivedMethod was called inside a parallel dart isolate.',
        );
        SendPort? sendPort = IsolateNameServer.lookupPortByName(
          "todolist_notification_action_part",
        );

        if (sendPort != null) {
          print('Redirecting the execution to main isolate process.');
          sendPort.send(receivedAction);
          return;
        }
      }
      return await onActionReceivedImplementationMethod(receivedAction);
    }
  }

  static Future<void> onActionReceivedImplementationMethod(
    ReceivedAction receivedAction,
  ) async {
    //Redirect to another page
    int taskId = int.parse(receivedAction.payload!["taskid"]!);
    MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
      "/details-page",
      (route) => (route.settings.name != "/details-page") || route.isFirst,
      arguments: {"id": taskId, "completeTaskFunc": () async {}},
    );
  }

  ///  *********************************************
  ///     REQUESTING NOTIFICATION PERMISSIONS
  ///  *********************************************
  ///
  static Future<bool> requestPermissionToSendNotificaions() async {
    return await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  ///  *********************************************
  ///     NOTIFICATION CREATION METHODS
  ///  *********************************************
  ///
  static Future<void> scheduleNewNotification(Task task) async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) isAllowed = await requestPermissionToSendNotificaions();
    if (!isAllowed) return;

    await scheduleNotificationImpl(task);
  }

  static Future<void> cancelNotification(int id) async {
    await AwesomeNotifications().cancel(id);
  }

  static Future<void> scheduleNotificationImpl(Task task) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: task.id,
        body: "${task.title} - Task date reached!",
        channelKey: "todolist_notification_channel",
        title: "To Do List",
        category: NotificationCategory.Alarm,
        notificationLayout: NotificationLayout.Default,
        displayOnBackground: true,
        displayOnForeground: true,
        wakeUpScreen: true,
        fullScreenIntent: true,
        criticalAlert: true,
        payload: {"taskid": task.id.toString()},
      ),
      schedule: NotificationCalendar.fromDate(
        date: task.dateAndTime,
        allowWhileIdle: true,
        preciseAlarm: true,
        repeats: false,
      ),
    );
  }
}
