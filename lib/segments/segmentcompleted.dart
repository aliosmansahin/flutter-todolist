/*

Segment completed

Created by Ali Osman ŞAHİN on 09/06/2025

*/

part of '../main.dart';

class SegmentCompleted extends StatefulWidget {
  const SegmentCompleted({super.key});

  @override
  State<SegmentCompleted> createState() => _SegmentCompletedState();
}

class _SegmentCompletedState extends State<SegmentCompleted> {
  Map<DateTime, List<Task>> tasks = {};

  void filterTasks() {
    //Clear old tasks
    tasks.clear();

    Map<DateTime, List<Task>> allTasks = Map.fromEntries(
      globalNotifier.taskData.entries,
    );

    for (var element in allTasks.entries) {
      //Get completed tasks
      List<Task> tasksList = element.value
          .where((task) => task.completed)
          .toList();

      //Pass them to tasksMap
      if (tasksList.isNotEmpty) {
        tasks[element.key] = tasksList;
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
