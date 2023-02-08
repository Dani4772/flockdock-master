import 'package:flocdock/constants/constants.dart';
import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  void Function()? onPressed;
  var text, textColor,buttonColor,buttonWidth,buttonHight, textWeight, textAlign, textDecoration, fontFamily;
  double? size;

  MyButton({
    this.onPressed,
    this.text,
    this.size,
    this.textDecoration, 
    this.textColor,
    this.buttonColor,
    this.textAlign,
    this.textWeight,
    this.fontFamily,
    this.buttonHight=49.0,
    this.buttonWidth=double.infinity
  });

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        height: widget.buttonHight,
        width: widget.buttonWidth,
        decoration: BoxDecoration(
          color: widget.buttonColor,
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
              colors: [
                widget.buttonColor,
                widget.buttonColor==KMediumBlue?KDarkBlue:widget.buttonColor,
              ],
              stops: [
                0.0,
                1.0
              ])
        ),
        child: Center(
          child: Text(
                widget.text,
                style: TextStyle(
                  fontSize: widget.size,
                  color: widget.textColor,
                  fontWeight: widget.textWeight,
                  decoration: widget.textDecoration,
                  fontFamily: widget.fontFamily,
                ),
                textAlign: widget.textAlign,
              ),
        ),
      ),
    );
  }
}

