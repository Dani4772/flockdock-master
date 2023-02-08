import 'package:flocdock/View/Widgets/my_spacing.dart';
import 'package:flocdock/View/Widgets/my_text.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget EventCategory({
  required String img,
  required String groupName,
  bool isSelected=false,
}) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isSelected?KBlue:KbgBlack,width: 2),
        image: DecorationImage(image: NetworkImage(img), fit: BoxFit.cover)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyText(
          text: groupName,
          fontFamily: "Proxima",
          color: KWhite,
          weight: FontWeight.w800,
          size: 18,
        ),
      ],
    ),
  );
}
