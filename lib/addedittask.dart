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
  //Fields
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String selectedType = "none";
  bool important = false;

  //Design
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

  //Checks Date and time if user selects date and time before now
  //TRUE: Date and time is appropriate
  //FALSE: Date and time are before now
  bool checkForDateAndTime() {
    DateTime selectedDateAndTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );
    DateTime now = DateTime.now();

    if (selectedDateAndTime.isBefore(now)) {
      return false;
    } else {
      return true;
    }
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
            important: important,
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
            important: drift.Value(important),
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
      important = widget.task!.important;
    }
  }

  //Shows an alert dialog
  void showAlertDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: Text(content, style: TextStyle(fontSize: 16)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: Text("OK", style: TextStyle(fontSize: 16)),
            ),
          ],
        );
      },
    );
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
          color: Theme.of(context).secondaryHeaderColor,
          child: CustomScrollView(
            controller: scrollController,
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverAppBar.medium(
                title: Text(widget.willEdit ? "Edit Task" : "New Task"),
                backgroundColor: Theme.of(context).secondaryHeaderColor,
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
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Theme.of(
                                    context,
                                  ).canvasColor,
                                ),
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
                                child: Text(
                                  "Select a deadline date",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedTime.format(context).toString(),
                                style: TextStyle(fontSize: 17),
                              ),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Theme.of(
                                    context,
                                  ).canvasColor,
                                ),
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
                                child: Text(
                                  "Select a deadline time",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    //Task type
                    ShadowedField(
                      title: "Task type",
                      margin: EdgeInsets.only(bottom: 20),
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
                          DropdownMenuEntry(value: "Food", label: "Food"),
                          DropdownMenuEntry(value: "Sport", label: "Sport"),
                          DropdownMenuEntry(value: "Work", label: "Work"),
                          DropdownMenuEntry(value: "School", label: "School"),
                        ],
                      ),
                    ),

                    //Importancy
                    ShadowedField(
                      title: "Importancy",
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Is this task important for you?",
                            style: TextStyle(fontSize: 17),
                          ),
                          Switch(
                            value: important,
                            onChanged: (value) => setState(() {
                              important = value;
                            }),
                          ),
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
                              color: Colors.grey.withValues(alpha: 0.5),
                              spreadRadius: 4,
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
                              showAlertDialog(
                                context,
                                "Couln't ${widget.willEdit ? "Edit" : "Add"}",
                                "Can't ${widget.willEdit ? "edit the" : "add an"} item without one or some of parameters",
                              );
                            } else if (!checkForDateAndTime()) {
                              showAlertDialog(
                                context,
                                "Couln't ${widget.willEdit ? "Edit" : "Add"}",
                                "Can't ${widget.willEdit ? "edit the" : "add an"} item before now",
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
                            _mainPageState.currentState!.setState(() {});
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
                    Padding(padding: EdgeInsetsGeometry.only(top: 40)),
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
