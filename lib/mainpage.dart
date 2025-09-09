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
  //To call setState every minute
  late Timer _timer;
  int? _lastMinute;

  /*
    Listener function to handle events for tasks
  */
  Future<void> listenForUpdates() async {
    final query = db.select(db.tasks);
    //query.orderBy([(t) => drift.OrderingTerm.asc(t.dateAndTime)]);

    query.watch().listen((element) {
      Map<DateTime, List<Task>> sortedData = sortData(element);
      globalNotifier.updateTaskData(sortedData);
    });
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
    super.initState();

    startMinuteListener();
    listenForUpdates();
  }

  @override
  void didChangeDependencies() {
    globalNotifier = Provider.of<GlobalNotifier>(context, listen: true);
    super.didChangeDependencies();
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
    return Scaffold(
      body: Consumer<GlobalNotifier>(
        builder: (context, value, child) {
          return Stack(
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
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                      centerTitle: true,
                    ),
                  ),

                  /*
                  Segments
                  */
                  Segments(),

                  /*
                  Last item will have bottom-margin, to prevent overlap with floating action button
                  */
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: globalNotifier.searchOpened ? 280 : 180,
                      width: double.infinity,
                    ),
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
              if (globalNotifier.selectedSegment == TaskSegments.all) ...[
                SearchInput(),
                SearchButton(),
                if (globalNotifier.filterOpened) Blur(),
                FilterUI(),
              ],
            ],
          );
        },
      ),
      backgroundColor: Theme.of(context).secondaryHeaderColor,
    );
  }
}
