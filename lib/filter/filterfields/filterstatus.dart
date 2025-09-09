/*

Shows the status field of the filtering ui

Created by Ali Osman ŞAHİN on 09/08/2025

*/

part of '../../main.dart';

class FilterStatus extends StatefulWidget {
  const FilterStatus({super.key});

  @override
  State<FilterStatus> createState() => _FilterStatusState();
}

class _FilterStatusState extends State<FilterStatus> {
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
          Row(
            children: [
              Text("All", style: TextStyle(fontSize: 17)),
              Radio(
                value: "alldone",
                groupValue: globalNotifier.done,
                onChanged: (value) {
                  globalNotifier.setDone(value.toString());
                },
              ),
            ],
          ),
          Row(
            children: [
              Text("Done", style: TextStyle(fontSize: 17)),
              Radio(
                value: "done",
                groupValue: globalNotifier.done,
                onChanged: (value) {
                  globalNotifier.setDone(value.toString());
                },
              ),
            ],
          ),
          Row(
            children: [
              Text("Undone", style: TextStyle(fontSize: 17)),
              Radio(
                value: "undone",
                groupValue: globalNotifier.done,
                onChanged: (value) {
                  globalNotifier.setDone(value.toString());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
