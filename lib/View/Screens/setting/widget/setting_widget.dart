import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flutter/material.dart';
Widget SettingWidget({String text="",String description="",void Function()? onTapTrailing}){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15),
    child: description.isEmpty?ListTile(
      minVerticalPadding: 0,
      title: Text(text,style: proximaBold.copyWith(color: KBlue)),
      trailing: InkWell(
        onTap: onTapTrailing,
          child: Icon(Icons.arrow_forward_ios_sharp,size:18,color: KWhite,)
      ),
    ):ListTile(
      minVerticalPadding: 0,
      title: Text(text,style: proximaBold.copyWith(color: KBlue)),
      subtitle: Text(description,style: proximaBold.copyWith(color: KDullBlack)),
      trailing: InkWell(
          onTap: onTapTrailing,
          child: Icon(Icons.arrow_forward_ios_sharp,size:18,color: KWhite,)
      ),
    ),
  );
}