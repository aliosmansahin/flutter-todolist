/*

No task widget

Created by Ali Osman ŞAHİN on 09/06/2025

*/

part of '../main.dart';

class NoTask extends StatefulWidget {
  const NoTask({super.key});

  @override
  State<NoTask> createState() => _NoTaskState();
}

class _NoTaskState extends State<NoTask> {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
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
    );
  }
}
