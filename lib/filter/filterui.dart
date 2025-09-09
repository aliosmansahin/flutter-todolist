/*

Shows the filtering ui

Created by Ali Osman ŞAHİN on 09/08/2025

*/

part of '../main.dart';

class FilterUI extends StatefulWidget {
  const FilterUI({super.key});

  @override
  State<FilterUI> createState() => _FilterUIState();
}

class _FilterUIState extends State<FilterUI> {
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      width: globalNotifier.filterOpened
          ? MediaQuery.of(context).size.width - 40
          : 80,
      height: globalNotifier.filterOpened ? 380 : 80,
      bottom: globalNotifier.filterOpened ? 120 : 105,
      left: globalNotifier.filterOpened ? 20 : 20,
      duration: Duration(milliseconds: 1200),
      curve: Curves.elasticOut,
      child: Container(
        padding: EdgeInsets.all(10),
        child: globalNotifier.filterOpened
            ? FilterOpened()
            : FilterFloatingButton(),
      ),
    );
  }
}
