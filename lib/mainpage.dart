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
          Junk items to test scrolling
          */
          SliverList.builder(
            itemBuilder: (context, index) {
              return TaskCard();
            },
            itemCount: 50,
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
