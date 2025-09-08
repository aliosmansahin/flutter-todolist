/*

Segment to do

Created by Ali Osman ŞAHİN on 09/06/2025

*/

part of '../main.dart';

class SegmentTodo extends StatefulWidget {
  final Map<DateTime, List<Task>> data;
  const SegmentTodo({super.key, required this.data});

  @override
  State<SegmentTodo> createState() => _SegmentTodoState();
}

class _SegmentTodoState extends State<SegmentTodo> {
  Map<DateTime, List<Task>> tasks = {};

  void filterTasks() {
    //Clear old tasks
    tasks.clear();

    Map<DateTime, List<Task>> allTasks = Map.fromEntries(widget.data.entries);

    for (var element in allTasks.entries) {
      //Get incomplete tasks
      List<Task> tasksList = element.value
          .where((task) => !task.completed)
          .toList();

      //Pass them to tasks
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
