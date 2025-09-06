/*

Segment all

Created by Ali Osman ŞAHİN on 09/06/2025

*/

part of '../main.dart';

class SegmentAll extends StatefulWidget {
  final Map<DateTime, List<Task>> data;
  const SegmentAll({super.key, required this.data});

  @override
  State<SegmentAll> createState() => _SegmentAllState();
}

class _SegmentAllState extends State<SegmentAll> {
  Map<DateTime, List<Task>> tasks = {};

  void filterTasks() {
    //Use all the data
    //TODO: Add a filtering ui
    //Call this function in build
    tasks = widget.data;
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
