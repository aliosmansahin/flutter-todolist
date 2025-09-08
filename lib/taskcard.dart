/*

Card Widget of each task

Created by Ali Osman ŞAHİN on 09/03/2025

*/

part of 'main.dart';

class TaskCard extends StatefulWidget {
  Task task;
  TaskCard({super.key, required this.task});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  Future<void> completeTask() async {
    var newData =
        await (db.update(db.tasks)..where((i) => i.id.equals(widget.task.id)))
            .writeReturning(TasksCompanion(completed: drift.Value(true)));
    widget.task = newData.first;

    //Cancel unnecessary notification
    if (widget.task.shouldNotify) {
      cancelTaskNotification(widget.task.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TaskDetail(id: widget.task.id),
          ),
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
                      widget.task.title,
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
                          ).format(widget.task.dateAndTime).toString(),
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          DateFormat(
                            "HH:mm",
                          ).format(widget.task.dateAndTime).toString(),
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),

                    //Done button
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
                      child: widget.task.completed
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Icon(
                                Icons.check_circle,
                                color: Color(0xFF2E7D32),
                                size: 40,
                              ),
                            )
                          : (widget.task.dateAndTime.isAfter(DateTime.now())
                                ? IconButton(
                                    icon: Icon(
                                      Icons.circle_outlined,
                                      size: 40,
                                      color: Color.fromARGB(200, 0, 0, 0),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 0,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (widget.task.dateAndTime.isAfter(
                                          DateTime.now(),
                                        )) {
                                          completeTask();
                                        }
                                      });
                                    },
                                  )
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      color: Color(0xFFD32F2F),
                                      size: 40,
                                    ),
                                  )),
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
