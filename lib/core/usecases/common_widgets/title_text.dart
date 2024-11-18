import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText({super.key, required this.title, this.color});
  final String title;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: color ?? Colors.black,
        fontFamily: 'NewAmsterdam',
      ),
      textAlign: TextAlign.center,
    );
  }
}
