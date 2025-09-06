/*

Date text widget

Created by Ali Osman ŞAHİN on 09/06/2025

*/

part of '../main.dart';

class DateHeader extends StatefulWidget {
  final DateTime date;
  const DateHeader({super.key, required this.date});

  @override
  State<DateHeader> createState() => _DateHeaderState();
}

class _DateHeaderState extends State<DateHeader> {
  String dateHeader = "";
  void formatDateHeader() {
    DateTime taskDateWOutTime = DateTime(
      widget.date.year,
      widget.date.month,
      widget.date.day,
    );

    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = today.subtract(Duration(days: 1));
    DateTime tomorrow = today.add(Duration(days: 1));

    if (taskDateWOutTime == today) {
      dateHeader = "Today";
    } else if (taskDateWOutTime == yesterday) {
      dateHeader = "Yesterday";
    } else if (taskDateWOutTime == tomorrow) {
      dateHeader = "Tomorrow";
    } else {
      dateHeader = DateFormat("yyyy/MM/dd").format(widget.date).toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    formatDateHeader();

    return Padding(
      padding: const EdgeInsets.only(top: 18, left: 10),
      child: Text(
        dateHeader,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
