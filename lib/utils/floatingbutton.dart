/*

Floating button widget

Created by Ali Osman ŞAHİN on 09/08/2025

*/

part of '../main.dart';

class FloatingButton extends StatefulWidget {
  Icon? icon;
  Text? text;
  VoidCallback? onPressed;
  double? top;
  double? bottom;
  double? left;
  double? right;
  double? width;
  double? height;
  FloatingButton({
    super.key,
    this.icon,
    this.text,
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.width,
    this.height,
    required this.onPressed,
  });

  @override
  State<FloatingButton> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.top,
      bottom: widget.bottom,
      left: widget.left,
      right: widget.right,
      width: widget.width,
      height: widget.height,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(widget.height ?? 0)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.5),
                spreadRadius: 4,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child:
              widget.text !=
                  null //If text is not null display textbutton, no matter if icon is null
              ? TextButton(
                  onPressed: widget.onPressed,
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColorDark,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget.icon ?? Container(),
                      widget.icon != null
                          ? Padding(padding: EdgeInsetsGeometry.only(right: 10))
                          : Container(),
                      widget.text!,
                    ],
                  ),
                )
              : widget.icon !=
                    null //If text is null, display icon button if icon is not null
              ? IconButton(
                  onPressed: widget.onPressed,
                  icon: widget.icon!,
                  style: IconButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColorDark,
                  ),
                )
              : Container(),
        ),
      ),
    );
  }
}
