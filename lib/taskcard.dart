/*

Card Widget of each task

Created by Ali Osman ŞAHİN on 09/03/2025

*/

part of 'main.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({super.key});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Theme.of(context).cardTheme.surfaceTintColor,
      child: SizedBox(
        width: double.infinity,
        height: 75,
        child: Padding(
          padding: EdgeInsetsGeometry.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("data"),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("date"),
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
    );
  }
}
