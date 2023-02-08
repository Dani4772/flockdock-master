import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  var text, color, weight, align,decoration,fontFamily;
  double? size;
  int? maxLines;

  MyText({
    this.text,
    this.size,
    this.decoration = TextDecoration.none,
    this.color ,
    this.weight,
    this.align,
    this.fontFamily="Proxima",
    this.maxLines
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: weight,
        decoration: decoration,
        fontFamily: '$fontFamily',
      ),
      textAlign: align,
      maxLines: maxLines,
    );
  }
}
