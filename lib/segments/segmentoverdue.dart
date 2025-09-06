/*

Segment overdue

Created by Ali Osman ŞAHİN on 09/06/2025

*/

part of '../main.dart';

class SegmentOverdue extends StatefulWidget {
  Map<DateTime, List<Task>> data;
  SegmentOverdue({super.key, required this.data});

  @override
  State<SegmentOverdue> createState() => _SegmentOverdueState();
}

class _SegmentOverdueState extends State<SegmentOverdue> {
  Future<void> getTasks() async {
    final query = db.select(db.tasks);
    query.orderBy([(t) => drift.OrderingTerm.asc(t.dateAndTime)]);
    query.where((tbl) {
      return tbl.dateAndTime.isBiggerThanValue(DateTime.now()).equals(false) &
          tbl.completed.equals(false);
    });

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
    print("ayrı");
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
