/*

Segment today

Created by Ali Osman ŞAHİN on 09/06/2025

*/

part of '../main.dart';

class SegmentToday extends StatefulWidget {
  final Map<DateTime, List<Task>> data;
  const SegmentToday({super.key, required this.data});

  @override
  State<SegmentToday> createState() => _SegmentTodayState();
}

class _SegmentTodayState extends State<SegmentToday> {
  List<Task> tasks = [];

  void filterTasks() {
    //Get tasks of today
    var date = DateTime.now();
    MapEntry<DateTime, List<Task>>? tasksIter = widget.data.entries
        .whereIndexed((index, element) {
          return element.key == DateTime(date.year, date.month, date.day);
        })
        .firstOrNull;

    //Pass them to tasks
    if (tasksIter != null) {
      tasks = tasksIter.value;
    }
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
        : SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Date
                Padding(
                  padding: const EdgeInsets.only(top: 18, left: 10),
                  child: Text(
                    "Today",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                //Tasks of the date
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(), // important
                  shrinkWrap: true, // important
                  itemCount: tasks.length,
                  itemBuilder: (context, taskIndex) {
                    return TaskCard(task: tasks[taskIndex]);
                  },
                  padding: EdgeInsets.all(0),
                ),
              ],
            ),
          );
  }
}
