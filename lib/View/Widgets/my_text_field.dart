
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  bool isObSecure;

  var hintText,bgColor,width,hight,radius,minLines,maxLines,verticalPadding;

  void Function(String value)? onChanged;
  TextEditingController controller;
  TextInputType textInputType;

  MyTextField({
    this.textInputType=TextInputType.text,
    required this.controller,
    this.hintText,
    this.isObSecure=false,
    this.onChanged,
    this.bgColor=KDullBlack,
    this.width=double.infinity,
    this.hight=49.0,
    this.radius=30.0,
    this.minLines=1,
    this.maxLines=1,
    this.verticalPadding=0.0,
   });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT,vertical: verticalPadding),
      height: hight,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: bgColor
      ),
      child: TextField(

        onChanged: onChanged,
          controller: controller,
          minLines: minLines,
          maxLines: maxLines,
          keyboardType: textInputType,
          obscureText: isObSecure,
          cursorColor: KWhite,
          autofocus: false,
          style: TextStyle(
            color: KWhite,
            fontFamily: "Proxima"
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(color: KWhite.withOpacity(0.5),fontFamily: "Proxima"),
          )
      ),
    );
  }
}
