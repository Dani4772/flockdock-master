import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flutter/material.dart';
class ReportCard extends StatelessWidget {
  String title;
  bool isSeclected;
  void Function()? onTap;
  ReportCard({required this.title,this.isSeclected=false,this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:Container(
        child: Row(
          children: [
            Icon(Icons.check_circle,color: isSeclected?KBlue:null,),
            SizedBox(width: 5,),
            Text(title,style: proximaSemiBold.copyWith(color: KWhite),),
          ],
        ),
      )
    );
  }
}
