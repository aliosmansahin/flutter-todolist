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
        return SegmentAll(data: widget.data, key: _segmentAllState);

      case TaskSegments.today:
        return SegmentToday(data: widget.data);

      case TaskSegments.upcoming:
        return SegmentUpcoming(data: widget.data);

      case TaskSegments.todo:
        return SegmentTodo(data: widget.data);

      case TaskSegments.completed:
        return SegmentCompleted(data: widget.data);

      case TaskSegments.overdue:
        return SegmentOverdue(data: widget.data);
    }
  }
}
