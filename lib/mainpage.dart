/*

The home page of the application

Created by Ali Osman ŞAHİN on 09/03/2025

*/

part of 'main.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Map<DateTime, List<Task>> data = {};

  /*
    Listener function to handle events for tasks
  */
  Future<void> listenForUpdates() async {
    final query = db.select(db.tasks);
    query.orderBy([(t) => drift.OrderingTerm.asc(t.dateAndTime)]);

    query.watch().listen((element) {
      setState(() {
        data = groupBy(
          element,
          (Task task) => DateTime(
            task.dateAndTime.year,
            task.dateAndTime.month,
            task.dateAndTime.day,
          ),
        );
      });
    });
  }

  /*
    InitState function
  */
  @override
  void initState() {
    listenForUpdates();
    super.initState();
  }

  /*
    Build function
  */
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
                "To Do List",
                style: TextStyle(color: Theme.of(context).primaryColorDark),
              ),
              centerTitle: true,
            ),
          ),
          /*
          Items
          */
          data.isEmpty
              ? SliverPadding(
                  padding: const EdgeInsets.only(top: 200),
                  sliver: SliverToBoxAdapter(
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "There is no task.",
                            style: TextStyle(fontSize: 30),
                          ),
                          Text(
                            "Add a new one!",
                            style: TextStyle(fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final date = data.entries.elementAt(index).key;
                    final tasksOfDate = data.entries.elementAt(index).value;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Date
                        Padding(
                          padding: const EdgeInsets.only(top: 18, left: 10),
                          child: Text(
                            DateFormat("yyyy/MM/dd").format(date).toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        //Tasks of the date
                        ListView.builder(
                          physics:
                              const NeverScrollableScrollPhysics(), // important
                          shrinkWrap: true, // important
                          itemCount: tasksOfDate.length,
                          itemBuilder: (context, taskIndex) {
                            return TaskCard(task: tasksOfDate[taskIndex]);
                          },
                          padding: EdgeInsets.all(0),
                        ),
                      ],
                    );
                  }, childCount: data.entries.length),
                ),

          /*
          Last item will have bottom-margin, to prevent overlap with floating action button
          */
          SliverToBoxAdapter(
            child: SizedBox(height: 100, width: double.infinity),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (bottomSheetContext) {
              return AddEditTask();
            },
          );
        },
        backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
        icon: Icon(Icons.add),
        label: Text("New task"),
      ),
    );
  }
}
