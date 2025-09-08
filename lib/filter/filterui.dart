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
      width: _mainPageState.currentState!.filterOpened ? 350 : 80,
      height: _mainPageState.currentState!.filterOpened ? 300 : 80,
      bottom: _mainPageState.currentState!.filterOpened ? 200 : 105,
      left: _mainPageState.currentState!.filterOpened ? 20 : 20,
      duration: Duration(seconds: 1),
      curve: Curves.elasticOut,
      child: Container(
        padding: EdgeInsets.all(10),
        child: _mainPageState.currentState!.filterOpened
            ? FilterOpened()
            : FilterFloatingButton(),
      ),
    );
  }
}
