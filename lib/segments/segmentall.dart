/*

Segment all

Created by Ali Osman ŞAHİN on 09/06/2025

*/

part of '../main.dart';

class SegmentAll extends StatefulWidget {
  Map<DateTime, List<Task>> data;
  SegmentAll({super.key, required this.data});

  @override
  State<SegmentAll> createState() => _SegmentAllState();
}

class _SegmentAllState extends State<SegmentAll> {
  Future<void> getTasks() async {
    final query = db.select(db.tasks);
    query.orderBy([(t) => drift.OrderingTerm.asc(t.dateAndTime)]);

    await query.get().then((element) {
      setState(() {
        widget.data = groupBy(
          element,
          (Task task) => DateTime(
            task.dateAndTime.year,
            task.dateAndTime.month,
            task.dateAndTime.day,
          ),
        );
      });
    });
  }

  @override
  void initState() {
    getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.data.isEmpty
        ? NoTask()
        : SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final date = widget.data.entries.elementAt(index).key;
              final tasksOfDate = widget.data.entries.elementAt(index).value;

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
            }, childCount: widget.data.entries.length),
          );
  }
}
