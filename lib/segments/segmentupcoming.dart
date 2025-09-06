/*

Segment upcoming

Created by Ali Osman ŞAHİN on 09/06/2025

*/

part of '../main.dart';

class SegmentUpcoming extends StatefulWidget {
  final Map<DateTime, List<Task>> data;
  const SegmentUpcoming({super.key, required this.data});

  @override
  State<SegmentUpcoming> createState() => _SegmentUpcomingState();
}

class _SegmentUpcomingState extends State<SegmentUpcoming> {
  Map<DateTime, List<Task>> tasks = {};

  void filterTasks() {
    //Get all upcoming tasks
    var date = DateTime.now();
    Iterable<MapEntry<DateTime, List<Task>>> tasksIter = widget.data.entries
        .where((element) {
          return element.key.isAfter(date);
        });

    if (tasksIter.isNotEmpty) {
      Map<DateTime, List<Task>> allTasks = Map.fromEntries(tasksIter);

      //Pass them to tasks
      for (var element in allTasks.entries) {
        List<Task> tasksList = element.value.toList();
        if (tasksList.isNotEmpty) {
          tasks[element.key] = tasksList;
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
