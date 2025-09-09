/*

Segment buttons widget

Created by Ali Osman ŞAHİN on 09/08/2025

*/

part of '../main.dart';

class SegmentButtons extends StatefulWidget {
  const SegmentButtons({super.key});

  @override
  State<SegmentButtons> createState() => _SegmentButtonsState();
}

class _SegmentButtonsState extends State<SegmentButtons> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 40,
      left: 0,
      right: 0,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 10),
        physics: BouncingScrollPhysics(),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.5),
                spreadRadius: 4,
                blurRadius: 2,
              ),
            ],
          ),
          width: 800,
          height: 50,
          child: SegmentedButton<TaskSegments>(
            style: SegmentedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColorLight,
            ),
            segments: [
              ButtonSegment(value: TaskSegments.all, label: Text("All")),
              ButtonSegment(value: TaskSegments.today, label: Text("Today")),
              ButtonSegment(
                value: TaskSegments.upcoming,
                label: Text("Upcoming"),
              ),
              ButtonSegment(value: TaskSegments.todo, label: Text("To Do")),
              ButtonSegment(
                value: TaskSegments.completed,
                label: Text("Completed"),
              ),
              ButtonSegment(
                value: TaskSegments.overdue,
                label: Text("Overdue"),
              ),
            ],
            selected: <TaskSegments>{globalNotifier.selectedSegment},
            onSelectionChanged: (p0) {
              globalNotifier.setSelectedSegment(p0.first);
            },
            multiSelectionEnabled: false,
          ),
        ),
      ),
    );
  }
}
