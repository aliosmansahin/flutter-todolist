/*

Shows a blur

Created by Ali Osman ŞAHİN on 09/08/2025

*/

part of '../main.dart';

class Blur extends StatefulWidget {
  const Blur({super.key});

  @override
  State<Blur> createState() => _BlurState();
}

class _BlurState extends State<Blur> {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: GestureDetector(
        onTap: () {
          globalNotifier.setFilterOpened(false);
        },
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: Colors.black.withAlpha(0), // must be transparent
          ),
        ),
      ),
    );
  }
}
