/*

Shows selected segment

Created by Ali Osman ŞAHİN on 09/06/2025

*/

part of '../main.dart';

class Segments extends StatefulWidget {
  const Segments({super.key});

  @override
  State<Segments> createState() => _SegmentsState();
}

class _SegmentsState extends State<Segments> {
  late ConnectionState connectionState;

  TaskSegments lastTaskSegment = TaskSegments.overdue;

  /*
    Getter for all data
  */
  void getAllData() async {
    final query = db.select(db.tasks);

    await query.get().then((value) {
      Map<DateTime, List<Task>> sorted = sortData(value);

      globalNotifier.updateTaskData(sorted);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (lastTaskSegment != globalNotifier.selectedSegment) {
      lastTaskSegment = globalNotifier.selectedSegment;
      getAllData();
    }
    switch (globalNotifier.selectedSegment) {
      case TaskSegments.all:
        return SegmentAll();

      case TaskSegments.today:
        return SegmentToday();

      case TaskSegments.upcoming:
        return SegmentUpcoming();

      case TaskSegments.todo:
        return SegmentTodo();

      case TaskSegments.completed:
        return SegmentCompleted();

      case TaskSegments.overdue:
        return SegmentOverdue();
    }
  }
}
