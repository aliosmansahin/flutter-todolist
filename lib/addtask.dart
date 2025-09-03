/*

Widget for adding a new task

Created by Ali Osman ŞAHİN on 09/03/2025

*/

part of 'main.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
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
            /*SliverList.builder(
              itemCount: 25,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(title: Text('Item $index'));
              },
            ),*/
            SliverAppBar.medium(
              title: Text("New Task"),
              backgroundColor: Colors.transparent,
            ),
            SliverPadding(
              padding: const EdgeInsets.all(8.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  //Task name
                  Text("Task name"),
                  TextField(autofocus: true),
                  //Task description
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text("Task description"),
                  ),
                  TextField(autofocus: true, minLines: 5, maxLines: 5),
                  //Deadline date
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text("Deadline date"),
                  ),
                  Text("No deadline date selected"),
                  OutlinedButton(
                    onPressed: () {},
                    child: Text("Select a deadline date"),
                  ),
                  //Deadline time
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text("Deadline time"),
                  ),
                  Text("No deadline time selected"),
                  OutlinedButton(
                    onPressed: () {},
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
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Add Task"),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        );
      },
    );
  }
}
