/*

Segment today

Created by Ali Osman ŞAHİN on 09/06/2025

*/

part of '../main.dart';

class SegmentToday extends StatefulWidget {
  final Map<DateTime, List<Task>> data;
  const SegmentToday({super.key, required this.data});

  @override
  State<SegmentToday> createState() => _SegmentTodayState();
}

class _SegmentTodayState extends State<SegmentToday> {
  List<Task> tasks = [];
  DateTime date = DateTime.now();

  void filterTasks() {
    //Get tasks of today
    var date = DateTime.now();
    MapEntry<DateTime, List<Task>>? tasksIter = widget.data.entries
        .whereIndexed((index, element) {
          return element.key == DateTime(date.year, date.month, date.day);
        })
        .firstOrNull;

    //Pass them to tasks
    if (tasksIter != null) {
      tasks = tasksIter.value;
      date = tasksIter.key;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    filterTasks();

    return tasks.isEmpty
        ? NoTask()
        : SliverToBoxAdapter(
            child: TasksColumn(date: date, tasks: tasks),
          );
  }
}
