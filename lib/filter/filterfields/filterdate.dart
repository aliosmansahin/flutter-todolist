/*

Shows the date field of the filtering ui

Created by Ali Osman ŞAHİN on 09/08/2025

*/

part of '../../main.dart';

class FilterDate extends StatefulWidget {
  const FilterDate({super.key});

  @override
  State<FilterDate> createState() => _FilterDateState();
}

class _FilterDateState extends State<FilterDate> {
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
                value: "alldate",
                groupValue: globalNotifier.date,
                onChanged: (value) {
                  globalNotifier.setDate(value.toString());
                },
              ),
            ],
          ),
          Row(
            children: [
              Text("Past", style: TextStyle(fontSize: 17)),
              Radio(
                value: "past",
                groupValue: globalNotifier.date,
                onChanged: (value) {
                  globalNotifier.setDate(value.toString());
                },
              ),
            ],
          ),
          Row(
            children: [
              Text("Future", style: TextStyle(fontSize: 17)),
              Radio(
                value: "future",
                groupValue: globalNotifier.date,
                onChanged: (value) {
                  globalNotifier.setDate(value.toString());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
