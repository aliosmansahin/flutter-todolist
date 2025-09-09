/*

Segment overdue

Created by Ali Osman ŞAHİN on 09/06/2025

*/

part of '../main.dart';

class SegmentOverdue extends StatefulWidget {
  const SegmentOverdue({super.key});

  @override
  State<SegmentOverdue> createState() => _SegmentOverdueState();
}

class _SegmentOverdueState extends State<SegmentOverdue> {
  Map<DateTime, List<Task>> tasks = {};

  void filterTasks() {
    //Clear old tasks
    tasks.clear();

    var date = DateTime.now();
    var tommorrow = date.add(Duration(days: 1));

    // Filter passed tasks
    Iterable<MapEntry<DateTime, List<Task>>> tasksIter = globalNotifier
        .taskData
        .entries
        .where((element) => element.key.isBefore(tommorrow));

    if (tasksIter.isNotEmpty) {
      for (var entry in tasksIter) {
        // Only undone tasks
        List<Task> incompleteTasks = entry.value
            .where((task) => !task.completed)
            .where((task) => task.dateAndTime.isBefore(date))
            .toList();

        // Add them to tasks
        if (incompleteTasks.isNotEmpty) {
          tasks[entry.key] = incompleteTasks;
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
