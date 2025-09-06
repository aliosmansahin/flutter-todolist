/*

Segment all

Created by Ali Osman ŞAHİN on 09/06/2025

*/

part of '../main.dart';

class SegmentAll extends StatefulWidget {
  final Map<DateTime, List<Task>> data;
  const SegmentAll({super.key, required this.data});

  @override
  State<SegmentAll> createState() => _SegmentSllState();
}

class _SegmentSllState extends State<SegmentAll> {
  @override
  Widget build(BuildContext context) {
    return widget.data.isEmpty
        ? SliverPadding(
            padding: const EdgeInsets.only(top: 200),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: Column(
                  children: [
                    Text("There is no task.", style: TextStyle(fontSize: 30)),
                    Text("Add a new one!", style: TextStyle(fontSize: 30)),
                  ],
                ),
              ),
            ),
          )
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
