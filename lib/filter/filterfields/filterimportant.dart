/*

Shows the importancy field of the filtering ui

Created by Ali Osman ŞAHİN on 09/08/2025

*/

part of '../../main.dart';

class FilterImportant extends StatefulWidget {
  const FilterImportant({super.key});

  @override
  State<FilterImportant> createState() => _FilterImportantState();
}

class _FilterImportantState extends State<FilterImportant> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Theme.of(context).canvasColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            spreadRadius: 4,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Only Important", style: TextStyle(fontSize: 17)),
          Switch(
            value: globalNotifier.important,
            onChanged: (value) {
              globalNotifier.setImportant(value);
            },
          ),
        ],
      ),
    );
  }
}
