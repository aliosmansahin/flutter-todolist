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
        return SegmentAll(data: widget.data);

      case TaskSegments.today:
        var date = DateTime.now();
        MapEntry<DateTime, List<Task>>? tasksIter = widget.data.entries
            .whereIndexed((index, element) {
              return element.key == DateTime(date.year, date.month, date.day);
            })
            .firstOrNull;

        List<Task> tasks = [];

        if (tasksIter != null) {
          tasks = tasksIter.value;
        }

        return SegmentToday(data: tasks);

      case TaskSegments.upcoming:
        var date = DateTime.now();
        Iterable<MapEntry<DateTime, List<Task>>> tasksIter = widget.data.entries
            .where((element) {
              return element.key.isAfter(date);
            });

        Map<DateTime, List<Task>> completedTasks = {};
        if (tasksIter.isNotEmpty) {
          Map<DateTime, List<Task>> allTasks = Map.fromEntries(tasksIter);

          for (var element in allTasks.entries) {
            for (var task in element.value) {
              if (!task.completed) {
                completedTasks.addEntries([element]);
              }
            }
          }
        }

        return SegmentUpcoming(data: completedTasks);
      case TaskSegments.todo:
        Map<DateTime, List<Task>> allTasks = Map.fromEntries(
          widget.data.entries,
        );

        Map<DateTime, List<Task>> tasks = {};

        for (var element in allTasks.entries) {
          for (var task in element.value) {
            if (!task.completed) {
              tasks.addEntries([element]);
            }
          }
        }

        return SegmentTodo(data: tasks);
      case TaskSegments.completed:
        Map<DateTime, List<Task>> allTasks = Map.fromEntries(
          widget.data.entries,
        );

        Map<DateTime, List<Task>> tasks = {};

        for (var element in allTasks.entries) {
          for (var task in element.value) {
            if (task.completed) {
              tasks.addEntries([element]);
            }
          }
        }

        return SegmentCompleted(data: tasks);
      case TaskSegments.overdue:
        return SliverPadding(padding: EdgeInsetsGeometry.all(10));
    }
  }
}
