/*

Detail page of a task

Created by Ali Osman ŞAHİN on 09/03/2025

*/

part of 'main.dart';

class TaskDetail extends StatefulWidget {
  final int id;
  const TaskDetail({super.key, required this.id});

  @override
  State<TaskDetail> createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  late Task data;
  bool isLoading = true;

  late StreamSubscription<List<Task>> _subscription;
  /*
    Listener function to handle events for task
    Also handles the first loading
  */
  Future<void> listenForUpdates() async {
    _subscription =
        (db.select(db.tasks)..where((tbl) {
              return tbl.id.equals(widget.id);
            }))
            .watch()
            .listen((element) {
              if (!mounted) return;

              if (element.isNotEmpty) {
                setState(() {
                  data = element.first;
                  isLoading = false;
                });
              } else {
                isLoading = false;

                if (mounted) Navigator.of(context).pop();
              }
            });
  }

  /*
    Deleter function
  */
  Future<void> deleteTask() async {
    await (db.delete(db.tasks)..where((tbl) {
          return tbl.id.equals(data.id);
        }))
        .go();
    if (data.shouldNotify && !data.notificationSent) {
      await cancelTaskNotification(data.id);
    }
  }

  Future<void> changeNotifyStatus(bool newValue) async {
    //Store new data as a list and pass first item into data variable
    var newData =
        await (db.update(db.tasks)..where((tbl) {
              return tbl.id.equals(data.id);
            }))
            .writeReturning(
              TasksCompanion(
                shouldNotify: drift.Value(newValue),
                notificationSent: drift.Value(false),
              ),
            );
    data = newData.first;

    if (newValue) {
      await scheduleTaskNotification(data);
    } else {
      await cancelTaskNotification(data.id);
    }
  }

  /*
    InitState function
  */
  @override
  void initState() {
    super.initState();
    listenForUpdates();
  }

  @override
  void dispose() {
    _subscription.cancel(); //Cancel listening
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('Loading...')),
        body: Center(child: CircularProgressIndicator()),
      );
    } else {
      return Scaffold(
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            /*
          AppBar
          */
            SliverAppBar.medium(
              pinned: false,
              floating: false,
              expandedHeight: 150,
              stretch: true,
              backgroundColor: Theme.of(context).secondaryHeaderColor,
              foregroundColor: Theme.of(context).primaryColor,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "Task Detail",
                  style: TextStyle(color: Theme.of(context).primaryColorDark),
                ),
                centerTitle: true,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    padding: EdgeInsets.all(10),
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (bottomSheetContext) {
                          return AddEditTask(willEdit: true, task: data);
                        },
                      );
                    },
                    icon: Icon(Icons.edit),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    padding: EdgeInsets.all(10),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (dialogContext) {
                          return AlertDialog(
                            title: Text("Delete Task"),
                            content: Text(
                              "Would you like to delete this task?",
                              style: TextStyle(fontSize: 16),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(dialogContext);
                                },
                                child: Text(
                                  "No",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.pop(dialogContext);
                                  await deleteTask();
                                },
                                child: Text(
                                  "Yes",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.delete),
                  ),
                ),
              ],
            ),
            SliverPadding(
              padding: const EdgeInsets.all(10),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  //Task name
                  Text("Task name", style: TextStyle(fontSize: 20)),
                  Text(data.title, style: TextStyle(fontSize: 16)),
                  Divider(),
                  //Task description
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "Task description",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Text(data.description, style: TextStyle(fontSize: 16)),
                  Divider(),
                  //Deadline date
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "Deadline date",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Text(
                    DateFormat(
                      "yyyy/MM/dd",
                    ).format(data.dateAndTime).toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                  Divider(),
                  //Deadline time
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "Deadline time",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Text(
                    DateFormat("HH:mm").format(data.dateAndTime).toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                  Divider(),
                  //Task type
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text("Task type", style: TextStyle(fontSize: 20)),
                  ),
                  Text(data.type, style: TextStyle(fontSize: 16)),
                  Divider(),
                  //Notifications
                  data.dateAndTime.isAfter(DateTime.now())
                      ? Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Send notification",
                                style: TextStyle(fontSize: 20),
                              ),
                              Switch(
                                value: data.shouldNotify,
                                onChanged: (value) async {
                                  await changeNotifyStatus(value);
                                },
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            "This is a passed task",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                ]),
              ),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).secondaryHeaderColor,
      );
    }
  }
}
