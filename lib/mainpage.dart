/*

The home page of the application

Created by Ali Osman ŞAHİN on 09/03/2025

*/

part of 'main.dart';

GlobalKey<_MainPageState> _mainPageState = GlobalKey();

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Map<DateTime, List<Task>> data = {};
  TaskSegments selectedSegment = TaskSegments.all;

  //To call setState every minute
  late Timer _timer;
  int? _lastMinute;

  //Filter dialog animation
  bool filterOpened = false;

  //Search input animation
  bool searchOpened = false;

  /*
    Listener function to handle events for tasks
  */
  Future<void> listenForUpdates() async {
    final query = db.select(db.tasks);
    //query.orderBy([(t) => drift.OrderingTerm.asc(t.dateAndTime)]);

    query.watch().listen((element) {
      sortData(element);
    });
  }

  /*
    Getter for all data
  */
  Future<void> getAllData() async {
    final query = db.select(db.tasks);

    await query.get().then((value) {
      sortData(value);
    });
  }

  /*
    Sorter function
  */
  void sortData(List<Task> element) {
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
  }

  /*
    Starts minute listener
  */
  void startMinuteListener() {
    _lastMinute = DateTime.now().minute;

    //Checks every second if the minute has changed
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      if (now.minute != _lastMinute) {
        _lastMinute = now.minute;

        //Be called every minute
        setState(() {});
      }
    });
  }

  /*
    InitState function
  */
  @override
  void initState() {
    listenForUpdates();
    super.initState();
    startMinuteListener();
  }

  /*
    Dispose function
  */
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  /*
    Build function
  */
  @override
  Widget build(BuildContext context) {
    getAllData();
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

          //Segment selection buttons
          SegmentButtons(),

          //New task floating button
          FloatingButton(
            bottom: 105,
            right: 20,
            height: 80,
            width: 160,
            icon: Icon(
              Icons.add,
              size: 30,
              color: Theme.of(context).canvasColor,
            ),
            text: Text(
              "New task",
              style: TextStyle(
                color: Theme.of(context).canvasColor,
                fontSize: 17,
              ),
            ),
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (bottomSheetContext) {
                  return AddEditTask();
                },
              );
            },
          ),

          //Search button and input
          //Input will be back of button
          selectedSegment == TaskSegments.all ? SearchInput() : Container(),
          selectedSegment == TaskSegments.all ? SearchButton() : Container(),

          //They must be here
          filterOpened ? Blur() : Container(),
          selectedSegment == TaskSegments.all ? FilterUI() : Container(),
        ],
      ),
      backgroundColor: Theme.of(context).secondaryHeaderColor,
    );
  }
}
