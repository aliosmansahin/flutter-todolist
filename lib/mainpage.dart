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
  TaskSegments selectedSegment = TaskSegments.all;

  /*
    Listener function to handle events for tasks
  */
  Future<void> listenForUpdates() async {
    final query = db.select(db.tasks);
    //query.orderBy([(t) => drift.OrderingTerm.asc(t.dateAndTime)]);

    query.watch().listen((element) {
      setState(() {
        DateTime now = DateTime.now();
        final upcomingTasks =
            element.where((task) => task.dateAndTime.isAfter(now)).toList()
              ..sort((a, b) => a.dateAndTime.compareTo(b.dateAndTime));
        final pastTasks =
            element.where((task) => !task.dateAndTime.isAfter(now)).toList()
              ..sort((a, b) => a.dateAndTime.compareTo(b.dateAndTime));

        final sortedTasks = [...upcomingTasks, ...pastTasks];

        data = groupBy(
          sortedTasks,
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
      body: Stack(
        children: [
          CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              /*
          AppBar
          */
              SliverAppBar.medium(
                pinned: false,
                floating: false,
                expandedHeight: 400,
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
              Segments
              */
              Segments(data: data, currentSegment: selectedSegment),

              /*
              Last item will have bottom-margin, to prevent overlap with floating action button
              */
              SliverToBoxAdapter(
                child: SizedBox(height: 180, width: double.infinity),
              ),
            ],
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 10),
              physics: BouncingScrollPhysics(),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.5),
                      spreadRadius: 4,
                      blurRadius: 2,
                    ),
                  ],
                ),
                width: 800,
                height: 50,
                child: SegmentedButton<TaskSegments>(
                  style: SegmentedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColorLight,
                  ),
                  segments: [
                    ButtonSegment(value: TaskSegments.all, label: Text("All")),
                    ButtonSegment(
                      value: TaskSegments.today,
                      label: Text("Today"),
                    ),
                    ButtonSegment(
                      value: TaskSegments.upcoming,
                      label: Text("Upcoming"),
                    ),
                    ButtonSegment(
                      value: TaskSegments.todo,
                      label: Text("To Do"),
                    ),
                    ButtonSegment(
                      value: TaskSegments.completed,
                      label: Text("Completed"),
                    ),
                    ButtonSegment(
                      value: TaskSegments.overdue,
                      label: Text("Overdue"),
                    ),
                  ],
                  selected: <TaskSegments>{selectedSegment},
                  onSelectionChanged: (p0) {
                    setState(() {
                      // By default there is only a single segment that can be
                      // selected at one time, so its value is always the first
                      // item in the selected set.
                      selectedSegment = p0.first;
                    });
                  },
                  multiSelectionEnabled: false,
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 75),
        child: FloatingActionButton.extended(
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
      ),
    );
  }
}
