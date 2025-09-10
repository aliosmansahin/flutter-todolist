/*

Status widget of a task

Created by Ali Osman ŞAHİN on 09/09/2025

*/

part of '../main.dart';

class TaskStatus extends StatefulWidget {
  final Task task;
  final Function completeTaskFunc;
  const TaskStatus({
    super.key,
    required this.task,
    required this.completeTaskFunc,
  });

  @override
  State<TaskStatus> createState() => _TaskStatusState();
}

class _TaskStatusState extends State<TaskStatus> {
  @override
  Widget build(BuildContext context) {
    return //Done button
    Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
      child: widget.task.completed
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                Icons.check_circle,
                color: Color(0xFF2E7D32),
                size: 40,
              ),
            )
          : (widget.task.dateAndTime.isAfter(DateTime.now())
                ? IconButton(
                    icon: Icon(
                      Icons.circle_outlined,
                      size: 40,
                      color: Color.fromARGB(200, 0, 0, 0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    onPressed: () async {
                      if (widget.task.dateAndTime.isAfter(DateTime.now())) {
                        await widget.completeTaskFunc();
                      }
                    },
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(
                      Icons.close,
                      color: Color(0xFFD32F2F),
                      size: 40,
                    ),
                  )),
    );
  }
}
