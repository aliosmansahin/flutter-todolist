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
  late Task task;

  Future<void> completeTask() async {
    var newData =
        await (db.update(db.tasks)..where((i) => i.id.equals(widget.task.id)))
            .writeReturning(TasksCompanion(completed: drift.Value(true)));
    setState(() {
      task = newData.first;
    });

    //Cancel unnecessary notification
    if (task.shouldNotify) {
      cancelTaskNotification(task.id);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    task = widget.task;
    return GestureDetector(
      onTap: () {
        MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
          "/details-page",
          (route) => (route.settings.name != "/details-page") || route.isFirst,
          arguments: {
            "id": task.id,
            "completeTaskFunc": () async {
              completeTask();
            },
          },
        );
      },
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).secondaryHeaderColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.5),
              spreadRadius: 4,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 75,
          child: Padding(
            padding: EdgeInsetsGeometry.only(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Title
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Text(
                      task.title,
                      style: TextStyle(fontSize: 18),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //Date and time
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat(
                            "yyyy/MM/dd",
                          ).format(task.dateAndTime).toString(),
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          DateFormat(
                            "HH:mm",
                          ).format(task.dateAndTime).toString(),
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),

                    TaskStatus(task: task, completeTaskFunc: completeTask),
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
