/*

Widget for adding shadowed field

Created by Ali Osman ŞAHİN on 09/03/2025

*/

part of '../main.dart';

class ShadowedField extends StatefulWidget {
  final Widget child;
  final String title;
  final EdgeInsets margin;
  const ShadowedField({
    super.key,
    required this.title,
    required this.child,
    this.margin = const EdgeInsets.all(0),
  });

  @override
  State<ShadowedField> createState() => _ShadowedFieldState();
}

class _ShadowedFieldState extends State<ShadowedField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 17,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: widget.child,
            ),
          ],
        ),
      ),
    );
  }
}
