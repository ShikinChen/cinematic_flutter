import 'package:flutter/material.dart';

class BottomGradient extends StatelessWidget {
  final double offset;

  BottomGradient({this.offset: 0.95});

  BottomGradient.noOffset() : offset = 1.0;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset(0.0, offset),
            end: FractionalOffset(0.0, 0.0),
            colors: <Color>[
              Color(0xff222128),
              Color(0x442C2B33),
              Color(0x002C2B33),
            ],
          ),
        ),
      );
}
