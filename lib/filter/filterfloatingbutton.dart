/*

Shows the button filtering ui

Created by Ali Osman ŞAHİN on 09/08/2025

*/

part of '../main.dart';

class FilterFloatingButton extends StatefulWidget {
  const FilterFloatingButton({super.key});

  @override
  State<FilterFloatingButton> createState() => _FilterFloatingButtonState();
}

class _FilterFloatingButtonState extends State<FilterFloatingButton> {
  @override
  Widget build(BuildContext context) {
    return Bounceable(
      duration: Duration(milliseconds: 200),
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.5),
              spreadRadius: 4,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ClipRect(
          child: IconButton(
            color: Theme.of(context).canvasColor,
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColorDark,
              shadowColor: Colors.black,
              shape: CircleBorder(),
            ),
            onPressed: () {
              globalNotifier.setFilterOpened(true);
            },
            icon: Icon(Icons.tune, size: 30),
          ),
        ),
      ),
    );
  }
}
