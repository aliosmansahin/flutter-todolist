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
    query.orderBy([(t) => drift.OrderingTerm.asc(t.dateAndTime)]);

    query.watch().listen((element) {
      setState(() {
        //TODO: Process all data to send selected segment
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
              Segments
              */
              Segments(data: data, currentSegment: selectedSegment),

              /*
              Last item will have bottom-margin, to prevent overlap with floating action button
              */
              SliverToBoxAdapter(
                child: SizedBox(height: 100, width: double.infinity),
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
              child: SizedBox(
                width: 800,
                child: SegmentedButton<TaskSegments>(
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
                    // Daha fazla segment ekleyerek test edebilirsin
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
