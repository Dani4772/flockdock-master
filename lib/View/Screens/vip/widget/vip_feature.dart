
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget VIPFeature({required String feature,bool isAllow=true})
{
  return Padding(
    padding: const EdgeInsets.only(top: 10.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isAllow?SvgPicture.asset(Images.check,color: Colors.green,width: 1,height: 12,):
        SvgPicture.asset(Images.close,color: Colors.red,width: 10,height: 10,),
        SizedBox(width: isAllow?10:12,),
        Expanded(child: Text(feature,style: proximaSemiBold.copyWith(color: KWhite,fontSize: Dimensions.fontSizeDefault),)),
      ],
    ),
  );
}
