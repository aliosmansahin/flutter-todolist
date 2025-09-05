/*

Widget for adding a new task

Created by Ali Osman ŞAHİN on 09/03/2025

*/

part of 'main.dart';

class AddEditTask extends StatefulWidget {
  final bool willEdit;
  final Task? task;
  const AddEditTask({super.key, this.willEdit = false, this.task});

  @override
  State<AddEditTask> createState() => _AddEditTaskState();
}

class _AddEditTaskState extends State<AddEditTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String selectedType = "none";
  Color buttonColor = Colors.white;
  bool firstBuild = true;

  //Checks TextEditingControllers if one or some of them is empty
  //TRUE : No empty item
  //FALSE : Empty item(s)
  bool checkForEmptiness() {
    if (titleController.text.isEmpty) return false;
    if (descriptionController.text.isEmpty) return false;
    return true;
  }

  Future<void> addTask() async {
    //Insert task and get the task object
    final Task task = await db
        .into(db.tasks)
        .insertReturning(
          TasksCompanion.insert(
            title: titleController.text,
            description: descriptionController.text,
            dateAndTime: DateTime(
              selectedDate.year,
              selectedDate.month,
              selectedDate.day,
              selectedTime.hour,
              selectedTime.minute,
            ),
            type: selectedType,
            shouldNotify: drift.Value(true),
          ),
        );

    await scheduleTaskNotification(task);
  }

  Future<void> editTask(int id) async {
    //Update task, returning is a list but we will have to use first index
    var newData = await (db.update(db.tasks)..where((i) => i.id.equals(id)))
        .writeReturning(
          TasksCompanion(
            title: drift.Value(titleController.text),
            description: drift.Value(descriptionController.text),
            dateAndTime: drift.Value(
              DateTime(
                selectedDate.year,
                selectedDate.month,
                selectedDate.day,
                selectedTime.hour,
                selectedTime.minute,
              ),
            ),
            type: drift.Value(selectedType),
            notificationSent: drift.Value(false),
          ),
        );

    //Cancel old notification and schedule new one
    await cancelTaskNotification(id);
    await scheduleTaskNotification(newData.first);
  }

  /*
    Setup empty fields to current values
  */
  void setupFields() {
    if (widget.task != null) {
      titleController.text = widget.task!.title;
      descriptionController.text = widget.task!.description;
      selectedDate = widget.task!.dateAndTime;
      selectedTime = TimeOfDay.fromDateTime(widget.task!.dateAndTime);
      selectedType = widget.task!.type;
    }
  }

  @override
  void initState() {
    setupFields();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (firstBuild) {
      buttonColor = Theme.of(context).canvasColor;
      firstBuild = false;
    }
    return DraggableScrollableSheet(
      expand: false,
      shouldCloseOnMinExtent: false,
      initialChildSize: 0.75,
      maxChildSize: 1,
      minChildSize: 0.1,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          color: Theme.of(context).cardTheme.surfaceTintColor,
          child: CustomScrollView(
            controller: scrollController,
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverAppBar.medium(
                title: Text(widget.willEdit ? "Edit Task" : "New Task"),
                backgroundColor: Theme.of(context).cardTheme.surfaceTintColor,
                pinned: true,
              ),
              SliverPadding(
                padding: const EdgeInsets.all(8.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    //Task name
                    ShadowedField(
                      title: "Task name",
                      margin: EdgeInsets.only(bottom: 20, top: 10),
                      child: TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                          hintText: "Type a name",
                          border: OutlineInputBorder(),
                        ),
                        scrollPhysics: BouncingScrollPhysics(),
                        style: TextStyle(fontSize: 17),
                      ),
                    ),

                    //Task description
                    ShadowedField(
                      title: "Task description",
                      margin: EdgeInsets.only(bottom: 20),
                      child: TextField(
                        minLines: 5,
                        maxLines: 5,
                        controller: descriptionController,
                        decoration: InputDecoration(
                          hintText: "Type a description",
                          border: OutlineInputBorder(),
                        ),
                        scrollPhysics: BouncingScrollPhysics(),
                        style: TextStyle(fontSize: 17),
                      ),
                    ),

                    //Deadline date and time
                    ShadowedField(
                      title: "Deadline date and time",
                      margin: EdgeInsets.only(bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat(
                                  "yyyy/MM/dd",
                                ).format(selectedDate).toString(),
                                style: TextStyle(fontSize: 17),
                              ),
                              OutlinedButton(
                                onPressed: () async {
                                  final DateTime? date = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(3000),
                                  );
                                  if (date != null) {
                                    setState(() {
                                      selectedDate = date;
                                    });
                                  }
                                },
                                child: Text("Select a deadline date"),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat(
                                  "HH:mm",
                                ).format(selectedDate).toString(),
                                style: TextStyle(fontSize: 17),
                              ),
                              OutlinedButton(
                                onPressed: () async {
                                  final TimeOfDay? timeOfDay =
                                      await showTimePicker(
                                        context: context,
                                        initialTime: selectedTime,
                                        initialEntryMode:
                                            TimePickerEntryMode.dial,
                                      );
                                  if (timeOfDay != null) {
                                    setState(() {
                                      selectedTime = timeOfDay;
                                    });
                                  }
                                },
                                child: Text("Select a deadline time"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    //Task type
                    ShadowedField(
                      title: "Task type",
                      child: DropdownMenu(
                        width: double.infinity,
                        hintText: "Select a type",
                        initialSelection: widget.willEdit
                            ? widget.task!.type
                            : null,
                        onSelected: (value) {
                          if (value != null) {
                            selectedType = value;
                          }
                        },
                        dropdownMenuEntries: [
                          DropdownMenuEntry(value: "food", label: "Food"),
                          DropdownMenuEntry(value: "sport", label: "Sport"),
                          DropdownMenuEntry(value: "work", label: "Work"),
                          DropdownMenuEntry(value: "school", label: "School"),
                        ],
                      ),
                    ),

                    //Add task button
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: 1),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: GestureDetector(
                          onTapCancel: () {
                            setState(() {
                              buttonColor = Theme.of(context).canvasColor;
                            });
                          },
                          onTapUp: (details) {
                            setState(() {
                              buttonColor = Theme.of(context).canvasColor;
                            });
                          },
                          onTapDown: (details) {
                            buttonColor = Theme.of(context).primaryColor;
                            setState(() {});
                          },
                          onTap: () async {
                            if (!checkForEmptiness()) {
                              showDialog(
                                context: context,
                                builder: (dialogContext) {
                                  return AlertDialog(
                                    title: Text(
                                      "Couln't ${widget.willEdit ? "Edit" : "Add"}",
                                    ),
                                    content: Text(
                                      "Can't ${widget.willEdit ? "edit the" : "add an"} item without one or some of parameters",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(dialogContext);
                                        },
                                        child: Text(
                                          "OK",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              if (widget.willEdit) {
                                //Edit
                                if (widget.task != null) {
                                  await editTask(widget.task!.id);
                                }
                              } else {
                                //Add
                                await addTask();
                              }
                              if (mounted) {
                                Navigator.pop(context);
                              }
                            }
                          },
                          child: Text(
                            widget.willEdit ? "Edit Task" : "Add Task",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsetsGeometry.only(top: 20)),
                  ]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
