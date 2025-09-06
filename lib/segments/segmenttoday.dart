/*

Segment today

Created by Ali Osman ŞAHİN on 09/06/2025

*/

part of '../main.dart';

class SegmentToday extends StatefulWidget {
  List<Task> data;
  SegmentToday({super.key, required this.data});

  @override
  State<SegmentToday> createState() => _SegmentTodayState();
}

class _SegmentTodayState extends State<SegmentToday> {
  Future<void> getTasks() async {
    final query = db.select(db.tasks);
    query.orderBy([(t) => drift.OrderingTerm.asc(t.dateAndTime)]);
    query.where((tbl) {
      var today = DateTime.now().toLocal();
      return tbl.dateAndTime.year.equals(today.year) &
          tbl.dateAndTime.month.equals(today.month) &
          tbl.dateAndTime.day.equals(today.day);
    });

    await query.get().then((element) {
      setState(() {
        widget.data = element;
      });
    });
  }

  @override
  void initState() {
    //getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.data.isEmpty
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
                  itemCount: widget.data.length,
                  itemBuilder: (context, taskIndex) {
                    return TaskCard(task: widget.data[taskIndex]);
                  },
                  padding: EdgeInsets.all(0),
                ),
              ],
            ),
          );
  }
}
