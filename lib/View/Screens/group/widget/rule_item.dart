import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget RulesItem({required String text,bool isAllowed=true})
{
  int lenth=text.length;
  return Container(
    width: 18+lenth*8,
    child: Row(
      children: [
        isAllowed?SvgPicture.asset(Images.check,color: Colors.green,width: 12,height: 12,):
        SvgPicture.asset(Images.close,color: Colors.red,width: 10,height: 10,),
        SizedBox(width: 2,),
        Text(text,style: proximaBold.copyWith(color: KWhite,fontSize: Dimensions.fontSizeSmall)),
      ],
    ),
  );
}