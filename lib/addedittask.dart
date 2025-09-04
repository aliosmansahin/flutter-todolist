/*

Widget for adding a new task

Created by Ali Osman ŞAHİN on 09/03/2025

*/

part of 'main.dart';

class AddEditTask extends StatefulWidget {
  final bool willEdit;
  const AddEditTask({super.key, this.willEdit = false});

  @override
  State<AddEditTask> createState() => _AddEditTaskState();
}

class _AddEditTaskState extends State<AddEditTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String selectedType = "none";

  //Checks TextEditingControllers if one or some of them is empty
  //TRUE : No empty item
  //FALSE : Empty item(s)
  bool checkForEmptiness() {
    if (titleController.text.isEmpty) return false;
    if (descriptionController.text.isEmpty) return false;
    return true;
  }

  Future<void> addTask() async {
    //Insert task
    db
        .into(db.tasks)
        .insert(
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
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75,
      maxChildSize: 1,
      minChildSize: 0.1,
      builder: (BuildContext context, ScrollController scrollController) {
        return CustomScrollView(
          controller: scrollController,
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar.medium(
              title: Text(widget.willEdit ? "Edit Task" : "New Task"),
              backgroundColor: Colors.transparent,
            ),
            SliverPadding(
              padding: const EdgeInsets.all(8.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  //Task name
                  Text("Task name"),
                  TextField(autofocus: true, controller: titleController),
                  //Task description
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text("Task description"),
                  ),
                  TextField(
                    autofocus: true,
                    minLines: 5,
                    maxLines: 5,
                    controller: descriptionController,
                  ),
                  //Deadline date
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text("Deadline date"),
                  ),
                  Text(
                    "${selectedDate.year}/${selectedDate.month}/${selectedDate.day}",
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
                  //Deadline time
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text("Deadline time"),
                  ),
                  Text("${selectedTime.hour}:${selectedTime.minute}"),
                  OutlinedButton(
                    onPressed: () async {
                      final TimeOfDay? timeOfDay = await showTimePicker(
                        context: context,
                        initialTime: selectedTime,
                        initialEntryMode: TimePickerEntryMode.dial,
                      );
                      if (timeOfDay != null) {
                        setState(() {
                          selectedTime = timeOfDay;
                        });
                      }
                    },
                    child: Text("Select a deadline time"),
                  ),
                  //Task type
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text("Task type"),
                  ),
                  DropdownMenu(
                    width: double.infinity,
                    hintText: "Select a type",
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
                  //Add task button
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: OutlinedButton(
                      onPressed: () async {
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
                          } else {
                            //Add
                            await addTask();
                          }
                          if (mounted) {
                            Navigator.pop(context);
                          }
                        }
                      },
                      child: Text(widget.willEdit ? "Edit Task" : "Add Task"),
                    ),
                  ),
                  Padding(padding: EdgeInsetsGeometry.only(top: 20)),
                ]),
              ),
            ),
          ],
        );
      },
    );
  }
}
