/*

Shows the opened filtering ui

Created by Ali Osman ŞAHİN on 09/08/2025

*/

part of '../main.dart';

class FilterOpened extends StatefulWidget {
  const FilterOpened({super.key});

  @override
  State<FilterOpened> createState() => _FilterOpenedState();
}

class _FilterOpenedState extends State<FilterOpened> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Theme.of(context).primaryColorDark,
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
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //Only Important
              FilterImportant(),

              // Done/Undone
              FilterStatus(),

              //Past/Future
              FilterDate(),

              //Close Button
              FilterFormButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
