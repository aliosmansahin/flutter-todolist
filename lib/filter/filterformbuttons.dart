/*

Shows the opened filtering ui

Created by Ali Osman ŞAHİN on 09/08/2025

*/

part of '../main.dart';

class FilterFormButtons extends StatefulWidget {
  const FilterFormButtons({super.key});

  @override
  State<FilterFormButtons> createState() => _FilterFormButtonsState();
}

class _FilterFormButtonsState extends State<FilterFormButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Bounceable(
            duration: Duration(milliseconds: 200),
            onTap: () {},
            child: ElevatedButton(
              onPressed: () {
                _mainPageState.currentState!.setState(() {
                  _segmentAllState.currentState!.resetFilters();
                });
              },
              child: Text("Reset", style: TextStyle(fontSize: 17)),
            ),
          ),
        ),
        Padding(padding: EdgeInsetsGeometry.only(left: 10)),
        Expanded(
          flex: 2,
          child: Bounceable(
            duration: Duration(milliseconds: 200),
            onTap: () {},
            child: ElevatedButton(
              onPressed: () {
                _mainPageState.currentState!.setState(() {
                  _mainPageState.currentState!.filterOpened = false;
                });
              },
              child: Text("Close", style: TextStyle(fontSize: 17)),
            ),
          ),
        ),
      ],
    );
  }
}
