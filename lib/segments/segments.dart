/*

Shows selected segment

Created by Ali Osman ŞAHİN on 09/06(2025

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
      case TaskSegments.completed:
      case TaskSegments.overdue:
      case TaskSegments.today:
      case TaskSegments.todo:
      case TaskSegments.upcoming:
        return SliverPadding(padding: EdgeInsetsGeometry.all(10));
    }
  }
}
