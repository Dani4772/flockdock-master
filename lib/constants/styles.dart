import 'package:flocdock/constants/dimensions.dart';
import 'package:flutter/material.dart';

final proximaLight = TextStyle(
  fontFamily: 'Proxima',
  fontWeight: FontWeight.w300,
  fontSize: Dimensions.fontSizeDefault,
);

final proximaRegular = TextStyle(
  fontFamily: 'Proxima',
  fontWeight: FontWeight.w400,
  fontSize: Dimensions.fontSizeDefault,
);

final proximaMedium = TextStyle(
  fontFamily: 'Proxima',
  fontWeight: FontWeight.w500,
  fontSize: Dimensions.fontSizeDefault,
);

final proximaSemiBold = TextStyle(
  fontFamily: 'Proxima',
  fontWeight: FontWeight.w600,
  fontSize: Dimensions.fontSizeDefault,
);
final proximaBold = TextStyle(
  fontFamily: 'Proxima',
  fontWeight: FontWeight.w700,
  fontSize: Dimensions.fontSizeDefault,
);

final proximaExtraBold = TextStyle(
  fontFamily: 'Proxima',
  fontWeight: FontWeight.w900,
  fontSize: Dimensions.fontSizeLarge,
);
const textBlack= Colors.black;
const textColor= Color(0X99131212);
const textBtnColor= Colors.white;

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  backgroundColor:Colors.amber,
  padding: EdgeInsets.zero,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5),
  ),
);







final divider = Divider(height: 10,thickness: 10);
