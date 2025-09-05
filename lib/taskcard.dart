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
            builder: (context) => TaskDetail(id: widget.task.id),
          ),
        );
      },
      child: Card(
        surfaceTintColor: Theme.of(context).cardTheme.surfaceTintColor,
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
