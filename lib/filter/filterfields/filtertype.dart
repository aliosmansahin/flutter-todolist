/*

Shows the type field of the filtering ui

Created by Ali Osman ŞAHİN on 09/08/2025

*/

part of '../../main.dart';

class FilterType extends StatefulWidget {
  const FilterType({super.key});

  @override
  State<FilterType> createState() => _FilterTypeState();
}

class _FilterTypeState extends State<FilterType> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(
      text: _segmentAllState.currentState!.type,
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.text = _segmentAllState.currentState!.type;
    return Container(
      padding: EdgeInsets.only(left: 10),
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
          Text("Task Type", style: TextStyle(fontSize: 17)),
          DropdownMenu(
            controller: controller,
            onSelected: (value) {
              _segmentAllState.currentState!.setState(() {
                if (value != null) {
                  _segmentAllState.currentState!.type = value;
                }
              });
            },
            dropdownMenuEntries: [
              DropdownMenuEntry(value: "All", label: "All"),
              DropdownMenuEntry(value: "Food", label: "Food"),
              DropdownMenuEntry(value: "Sport", label: "Sport"),
              DropdownMenuEntry(value: "Work", label: "Work"),
              DropdownMenuEntry(value: "School", label: "School"),
            ],
          ),
        ],
      ),
    );
  }
}
