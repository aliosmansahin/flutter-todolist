/*

Segment overdue

Created by Ali Osman ŞAHİN on 09/06/2025

*/

part of '../main.dart';

class SegmentOverdue extends StatefulWidget {
  final Map<DateTime, List<Task>> data;
  const SegmentOverdue({super.key, required this.data});

  @override
  State<SegmentOverdue> createState() => _SegmentOverdueState();
}

class _SegmentOverdueState extends State<SegmentOverdue> {
  Map<DateTime, List<Task>> tasks = {};

  void filterTasks() {
    var date = DateTime.now();

    // Filter passed tasks
    Iterable<MapEntry<DateTime, List<Task>>> tasksIter = widget.data.entries
        .where((element) => element.key.isBefore(date));

    if (tasksIter.isNotEmpty) {
      for (var entry in tasksIter) {
        // Only undone tasks
        List<Task> incompleteTasks = entry.value
            .where((task) => !task.completed)
            .toList();

        // Add them to tasks
        if (incompleteTasks.isNotEmpty) {
          tasks[entry.key] = incompleteTasks;
        }
      }
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
        : SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final date = tasks.entries.elementAt(index).key;
              final tasksOfDate = tasks.entries.elementAt(index).value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Date
                  Padding(
                    padding: const EdgeInsets.only(top: 18, left: 10),
                    child: Text(
                      DateFormat("yyyy/MM/dd").format(date).toString(),
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
                    itemCount: tasksOfDate.length,
                    itemBuilder: (context, taskIndex) {
                      return TaskCard(task: tasksOfDate[taskIndex]);
                    },
                    padding: EdgeInsets.all(0),
                  ),
                ],
              );
            }, childCount: tasks.entries.length),
          );
  }
}
