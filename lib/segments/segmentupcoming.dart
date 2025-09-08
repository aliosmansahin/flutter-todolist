/*

Segment upcoming

Created by Ali Osman ŞAHİN on 09/06/2025

*/

part of '../main.dart';

class SegmentUpcoming extends StatefulWidget {
  final Map<DateTime, List<Task>> data;
  const SegmentUpcoming({super.key, required this.data});

  @override
  State<SegmentUpcoming> createState() => _SegmentUpcomingState();
}

class _SegmentUpcomingState extends State<SegmentUpcoming> {
  Map<DateTime, List<Task>> tasks = {};

  void filterTasks() {
    //Get all upcoming tasks
    var now = DateTime.now();
    var yesterday = now.subtract(Duration(days: 1));
    Iterable<MapEntry<DateTime, List<Task>>> tasksIter = widget.data.entries
        .where((element) {
          return element.key.isAfter(yesterday);
        });

    if (tasksIter.isNotEmpty) {
      Map<DateTime, List<Task>> allTasks = Map.fromEntries(tasksIter);

      //Pass them to tasks
      for (var element in allTasks.entries) {
        List<Task> tasksList = element.value
            .where((element) => !element.completed)
            .where((element) => element.dateAndTime.isAfter(now))
            .toList();
        if (tasksList.isNotEmpty) {
          tasks[element.key] = tasksList;
        }
      }
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
        : SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final date = tasks.entries.elementAt(index).key;
              final tasksOfDate = tasks.entries.elementAt(index).value;

              return TasksColumn(date: date, tasks: tasksOfDate);
            }, childCount: tasks.entries.length),
          );
  }
}
