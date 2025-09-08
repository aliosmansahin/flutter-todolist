/*

Shows the search button

Created by Ali Osman ŞAHİN on 09/08/2025

*/

part of '../main.dart';

class SearchButton extends StatefulWidget {
  const SearchButton({super.key});

  @override
  State<SearchButton> createState() => _SearchButtonState();
}

class _SearchButtonState extends State<SearchButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingButton(
      width: 80,
      height: 80,
      bottom: 105,
      left: 100,
      icon: Icon(
        _segmentAllState.currentState!.searchValue.isNotEmpty
            ? Icons.search_off
            : Icons.search,
        size: 30,
        color: _mainPageState.currentState!.searchOpened
            ? Colors.black
            : Theme.of(context).canvasColor,
      ),
      onPressed: () {
        _mainPageState.currentState!.setState(() {
          _mainPageState.currentState!.searchOpened =
              !_mainPageState.currentState!.searchOpened;
          FocusManager.instance.primaryFocus?.unfocus();
        });
      },
    );
  }
}
