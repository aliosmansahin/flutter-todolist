/*

The function that sorts tasks and groups them by dates

Created by Ali Osman ŞAHİN on 09/09/2025

*/

import 'package:collection/collection.dart';
import 'package:todolist/database/database.dart';

Map<DateTime, List<Task>> sortData(List<Task> element) {
  DateTime now = DateTime.now();
  final upcomingTasks =
      element.where((task) => task.dateAndTime.isAfter(now)).toList()
        ..sort((a, b) => a.dateAndTime.compareTo(b.dateAndTime));
  final pastTasks =
      element.where((task) => !task.dateAndTime.isAfter(now)).toList()
        ..sort((a, b) => a.dateAndTime.compareTo(b.dateAndTime));

  final sortedTasks = [...upcomingTasks, ...pastTasks];

  return groupBy(
    sortedTasks,
    (Task task) => DateTime(
      task.dateAndTime.year,
      task.dateAndTime.month,
      task.dateAndTime.day,
    ),
  );
}
