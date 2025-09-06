/*

Date text widget

Created by Ali Osman ŞAHİN on 09/06/2025

*/

part of '../main.dart';

class TasksColumn extends StatefulWidget {
  final DateTime date;
  final List<Task> tasks;
  const TasksColumn({super.key, required this.date, required this.tasks});

  @override
  State<TasksColumn> createState() => _TasksColumnState();
}

class _TasksColumnState extends State<TasksColumn> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Date
        DateHeader(date: widget.date),
        //Tasks of the date
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(), // important
          shrinkWrap: true, // important
          itemCount: widget.tasks.length,
          itemBuilder: (context, taskIndex) {
            return TaskCard(task: widget.tasks[taskIndex]);
          },
          padding: EdgeInsets.all(0),
        ),
      ],
    );
  }
}
