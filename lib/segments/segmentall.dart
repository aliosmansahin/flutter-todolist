/*

Segment all

Created by Ali Osman ŞAHİN on 09/06/2025

*/

part of '../main.dart';

GlobalKey<_SegmentAllState> _segmentAllState = GlobalKey();

class SegmentAll extends StatefulWidget {
  final Map<DateTime, List<Task>> data;
  const SegmentAll({super.key, required this.data});

  @override
  State<SegmentAll> createState() => _SegmentAllState();
}

class _SegmentAllState extends State<SegmentAll> {
  Map<DateTime, List<Task>> tasks = {};

  //Filters
  bool important = false;
  String done = "alldone";
  String date = "alldate";
  String type = "All";

  //Search
  String searchValue = "";

  /*
    Resets all filters to default
  */
  void resetFilters() {
    setState(() {
      important = false;
      done = "alldone";
      date = "alldate";
      type = "All";
    });
  }

  void filterTasks() {
    //Clear old tasks
    tasks.clear();

    //Use all the data
    //TODO: Add a filtering ui
    //Call this funciton in build
    Map<DateTime, List<Task>> allTasks = Map.fromEntries(widget.data.entries);

    for (var element in allTasks.entries) {
      //Get completed tasks

      List<Task> tasksList = element.value.toList();

      //Search
      if (searchValue != "") {
        tasksList = tasksList
            .where((task) => task.title.contains(searchValue))
            .toList();
      }

      //Importancy
      if (important) {
        tasksList = tasksList.where((task) => task.important).toList();
      }

      //Status
      if (done == "done") {
        tasksList = tasksList.where((task) => task.completed).toList();
      } else if (done == "undone") {
        tasksList = tasksList.where((task) => !task.completed).toList();
      }

      //Date and time
      if (date == "past") {
        tasksList = tasksList
            .where((task) => task.dateAndTime.isBefore(DateTime.now()))
            .toList();
      } else if (date == "future") {
        tasksList = tasksList
            .where((task) => task.dateAndTime.isAfter(DateTime.now()))
            .toList();
      }

      //Type
      if (type != "All") {
        tasksList = tasksList.where((task) => task.type == type).toList();
      }

      //Pass them to tasksMap
      if (tasksList.isNotEmpty) {
        tasks[element.key] = tasksList;
      }
    }

    print(tasks);
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
