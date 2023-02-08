import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flutter/material.dart';
class ProfileItem extends StatelessWidget {
  String title;
  String value;
  ProfileItem({Key? key,this.title="",this.value=""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Text(title, style: proximaSemiBold.copyWith(color: KBlue,))),
            Expanded(child: Text(value, style: proximaSemiBold.copyWith(color: KWhite,),)),
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          color: Colors.white.withOpacity(0.5),
          height: 1,
        ),
      ],
    );
  }
}
