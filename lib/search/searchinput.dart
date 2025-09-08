/*

Shows the search input

Created by Ali Osman ŞAHİN on 09/08/2025

*/

part of '../main.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({super.key});

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      width: _mainPageState.currentState!.searchOpened
          ? MediaQuery.of(context).size.width - 60
          : 10,
      height: _mainPageState.currentState!.searchOpened ? 70 : 10,
      bottom: _mainPageState.currentState!.searchOpened ? 200 : 140,
      left: _mainPageState.currentState!.searchOpened ? 30 : 135,
      duration: Duration(milliseconds: 1200),
      curve: Curves.elasticOut,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(80)),
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
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: SearchBar(
                    controller: controller,
                    autoFocus: true,
                    onChanged: (value) {
                      _mainPageState.currentState!.setState(() {
                        _segmentAllState.currentState!.searchValue = value;
                      });
                    },
                  ),
                ),
                Padding(padding: EdgeInsetsGeometry.only(left: 10)),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(80)),
                      color: Theme.of(context).primaryColorDark,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          spreadRadius: 4,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Bounceable(
                      duration: Duration(milliseconds: 200),
                      onTap: () {},
                      child: IconButton.filled(
                        style: IconButton.styleFrom(
                          backgroundColor: Theme.of(context).canvasColor,
                          foregroundColor: Theme.of(context).primaryColorDark,
                          iconSize: 35,
                        ),
                        onPressed: () {
                          _mainPageState.currentState!.setState(() {
                            if (_segmentAllState
                                .currentState!
                                .searchValue
                                .isEmpty) {
                              _mainPageState.currentState!.searchOpened = false;
                            } else {
                              _segmentAllState.currentState!.searchValue = "";
                              controller.text = "";
                            }
                          });
                        },
                        icon: Icon(
                          controller.text.isNotEmpty
                              ? Icons.close
                              : Icons.keyboard_arrow_down,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
