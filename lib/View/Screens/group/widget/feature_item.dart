import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flutter/material.dart';

Widget FeatureItem({required String text})
{
  return Container(
    decoration: BoxDecoration(
        color: KWhite,
        borderRadius: BorderRadius.circular(20)
    ),
    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
    child: Text(text,style: proximaBold.copyWith(color: KPureBlack,fontSize: Dimensions.fontSizeSmall)),
  );
}