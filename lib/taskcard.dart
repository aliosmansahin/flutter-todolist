/*

Card Widget of each task

Created by Ali Osman ŞAHİN on 09/03/2025

*/

part of 'main.dart';

class TaskCard extends StatefulWidget {
  final Task task;
  const TaskCard({super.key, required this.task});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TaskDetail(task: widget.task),
          ),
        );
      },
      child: Card(
        surfaceTintColor: Theme.of(context).cardTheme.surfaceTintColor,
        child: SizedBox(
          width: double.infinity,
          height: 75,
          child: Padding(
            padding: EdgeInsetsGeometry.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.task.title),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(widget.task.dateAndTime.toLocal().toString()),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
                      child: IconButton(
                        icon: Icon(Icons.done),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 0,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
