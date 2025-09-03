/*

Detail page of a task

Created by Ali Osman ŞAHİN on 09/03/2025

*/

part of 'main.dart';

class TaskDetail extends StatefulWidget {
  const TaskDetail({super.key});

  @override
  State<TaskDetail> createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {},
                  icon: Icon(Icons.edit),
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
                Text(
                  "sasdkhajkdhaskjdhdjshdjahdjsakhdkj",
                  style: TextStyle(fontSize: 16),
                ),
                Divider(),
                //Task description
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    "Task description",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Text(
                  "saşdlksaidlsaşdlsaşdlsaşidlsaşidlasşidlsaişdlsişdlsaşidlsaişdalsdşisaldişasdlaşisldşisaldişa",
                  style: TextStyle(fontSize: 16),
                ),
                Divider(),
                //Deadline date
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text("Deadline date", style: TextStyle(fontSize: 20)),
                ),
                Text(
                  "No deadline date selected",
                  style: TextStyle(fontSize: 16),
                ),
                Divider(),
                //Deadline time
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text("Deadline time", style: TextStyle(fontSize: 20)),
                ),
                Text(
                  "No deadline time selected",
                  style: TextStyle(fontSize: 16),
                ),
                Divider(),
                //Task type
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text("Task type", style: TextStyle(fontSize: 20)),
                ),
                Text("None", style: TextStyle(fontSize: 16)),
                Divider(),
                //Notifications
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Send notification", style: TextStyle(fontSize: 20)),
                      Switch(value: false, onChanged: null),
                    ],
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
