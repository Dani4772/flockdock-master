import 'package:flocdock/View/Widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialButton extends StatelessWidget {
  void Function()? onPressed;
  var text,
      textColor,
      buttonColor,
      textWeight,
      textAlign,
      textDecoration,
      fontFamily;
  double? size;
  String Img;
  double? sizebox;

  SocialButton({
    this.onPressed,
    this.text,
    required this.Img,
    this.size,
    this.textDecoration,
    this.textColor,
    this.buttonColor,
    this.textAlign,
    this.textWeight,
    this.fontFamily,
    this.sizebox
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(30),
      ),
      height: 49,
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SvgPicture.asset(Img,height: 26),
          SizedBox(
            width: 20,
          ),
          MyText(
            color: textColor,
            fontFamily: fontFamily,
            text: text,
            size: size,
            weight: textWeight,
            align: textAlign,
            decoration: textDecoration,
          ),
          SizedBox(
            width: sizebox,
          ),
        ]),
      ),
    );
  }
}
