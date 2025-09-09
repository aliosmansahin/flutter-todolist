/*

Segment all

Created by Ali Osman ŞAHİN on 09/06/2025

*/

part of '../main.dart';

class SegmentAll extends StatefulWidget {
  const SegmentAll({super.key});

  @override
  State<SegmentAll> createState() => _SegmentAllState();
}

class _SegmentAllState extends State<SegmentAll> {
  Map<DateTime, List<Task>> tasks = {};

  void filterTasks() {
    //Clear old tasks
    tasks.clear();

    //Use all the data
    //Call this funciton in build
    Map<DateTime, List<Task>> allTasks = Map.fromEntries(
      globalNotifier.taskData.entries,
    );

    for (var element in allTasks.entries) {
      //Get completed tasks

      List<Task> tasksList = element.value.toList();

      //Search
      if (globalNotifier.searchValue != "") {
        tasksList = tasksList
            .where((task) => task.title.contains(globalNotifier.searchValue))
            .toList();
      }

      //Importancy
      if (globalNotifier.important) {
        tasksList = tasksList.where((task) => task.important).toList();
      }

      //Status
      if (globalNotifier.done == "done") {
        tasksList = tasksList.where((task) => task.completed).toList();
      } else if (globalNotifier.done == "undone") {
        tasksList = tasksList.where((task) => !task.completed).toList();
      }

      //Date and time
      if (globalNotifier.date == "past") {
        tasksList = tasksList
            .where((task) => task.dateAndTime.isBefore(DateTime.now()))
            .toList();
      } else if (globalNotifier.date == "future") {
        tasksList = tasksList
            .where((task) => task.dateAndTime.isAfter(DateTime.now()))
            .toList();
      }

      //Type
      if (globalNotifier.type != "All") {
        tasksList = tasksList
            .where((task) => task.type == globalNotifier.type)
            .toList();
      }

      //Pass them to tasksMap
      if (tasksList.isNotEmpty) {
        tasks[element.key] = tasksList;
      }
    }

    //print(tasks);
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
