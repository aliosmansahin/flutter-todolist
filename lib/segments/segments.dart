/*

Shows selected segment

Created by Ali Osman ŞAHİN on 09/06/2025

*/

part of '../main.dart';

class Segments extends StatefulWidget {
  final Map<DateTime, List<Task>> data;
  final TaskSegments currentSegment;
  const Segments({super.key, required this.data, required this.currentSegment});

  @override
  State<Segments> createState() => _SegmentsState();
}

class _SegmentsState extends State<Segments> {
  @override
  Widget build(BuildContext context) {
    switch (widget.currentSegment) {
      case TaskSegments.all:
        //Use all the data
        return SegmentAll(data: widget.data);

      case TaskSegments.today:
        //Get tasks of today
        var date = DateTime.now();
        MapEntry<DateTime, List<Task>>? tasksIter = widget.data.entries
            .whereIndexed((index, element) {
              return element.key == DateTime(date.year, date.month, date.day);
            })
            .firstOrNull;

        //Pass them to tasks
        List<Task> tasks = [];

        if (tasksIter != null) {
          tasks = tasksIter.value;
        }

        return SegmentToday(data: tasks);

      case TaskSegments.upcoming:
        //Get all upcoming tasks
        var date = DateTime.now();
        Iterable<MapEntry<DateTime, List<Task>>> tasksIter = widget.data.entries
            .where((element) {
              return element.key.isAfter(date);
            });

        Map<DateTime, List<Task>> tasksMap = {};
        if (tasksIter.isNotEmpty) {
          Map<DateTime, List<Task>> allTasks = Map.fromEntries(tasksIter);

          //Pass them to tasksMap
          for (var element in allTasks.entries) {
            List<Task> tasks = element.value.toList();
            if (tasks.isNotEmpty) {
              tasksMap[element.key] = tasks;
            }
          }
        }

        return SegmentUpcoming(data: tasksMap);
      case TaskSegments.todo:
        Map<DateTime, List<Task>> allTasks = Map.fromEntries(
          widget.data.entries,
        );

        Map<DateTime, List<Task>> tasksMap = {};

        for (var element in allTasks.entries) {
          //Get incomplete tasks
          List<Task> tasks = element.value
              .where((task) => !task.completed)
              .toList();

          //Pass them to tasksMap
          if (tasks.isNotEmpty) {
            tasksMap[element.key] = tasks;
          }
        }

        return SegmentTodo(data: tasksMap);
      case TaskSegments.completed:
        Map<DateTime, List<Task>> allTasks = Map.fromEntries(
          widget.data.entries,
        );

        Map<DateTime, List<Task>> tasksMap = {};

        for (var element in allTasks.entries) {
          //Get completed tasks
          List<Task> tasks = element.value
              .where((task) => task.completed)
              .toList();

          //Pass them to tasksMap
          if (tasks.isNotEmpty) {
            tasksMap[element.key] = tasks;
          }
        }

        return SegmentCompleted(data: tasksMap);
      case TaskSegments.overdue:
        var date = DateTime.now();

        // Filter passed tasks
        Iterable<MapEntry<DateTime, List<Task>>> tasksIter = widget.data.entries
            .where((element) => element.key.isBefore(date));

        Map<DateTime, List<Task>> incompleteTasksMap = {};

        if (tasksIter.isNotEmpty) {
          for (var entry in tasksIter) {
            // Only undone tasks
            List<Task> incompleteTasks = entry.value
                .where((task) => !task.completed)
                .toList();

            // Add them to map
            if (incompleteTasks.isNotEmpty) {
              incompleteTasksMap[entry.key] = incompleteTasks;
            }
          }
        }

        return SegmentOverdue(data: incompleteTasksMap);
    }
  }
}
