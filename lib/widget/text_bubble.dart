import 'package:flutter/material.dart';

class TextBubble extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 6.0,
            vertical: 4.0,
          ),
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 12.0,
            ),
          ),
        ),
      );

  TextBubble(
    this.text, {
    this.backgroundColor = const Color(0xFF424242),
    this.textColor = Colors.white,
  });
}
