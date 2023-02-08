import 'package:flocdock/View/Widgets/my_text.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flutter/material.dart';

Widget ValueContainer({
  String value="",
  bool isSelected=false,
}) {
  return Container(
    height: 25,
    width: 8+(value.length*7.5),
    decoration: BoxDecoration(
      color: isSelected?KBlue:KbgBlack,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: isSelected?KBlue:KdullWhite,width: 1),
    ),
    child: Center(
      child:  Text(value,style: proximaBold.copyWith(color: KWhite,fontSize: Dimensions.fontSizeSmall),),

    ),
  );
}