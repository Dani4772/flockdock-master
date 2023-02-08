import 'package:flocdock/View/Screens/profile/widget/report_card.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ReportDialog extends StatefulWidget {
  void Function(String)? onReport;
  ReportDialog({Key? key,this.onReport}) : super(key: key);

  @override
  State<ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  int selected=0;
  String reportType="";
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      backgroundColor: KDullBlack,
      child: Container(
        height: 300,
          padding: EdgeInsets.only(top: 20,right: 20,left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(child: Container()),
                  Text("Report User",style: proximaBold.copyWith(fontSize:Dimensions.fontSizeLarge,color: KWhite,)),
                  Expanded(child: Container()),
                  InkWell(
                    onTap: () => Get.back(),
                    child: SvgPicture.asset(Images.close,color: KdullWhite,height: 15,width: 15,),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Text("Why you want to Block the user?",textAlign: TextAlign.center,style: proximaBold.copyWith(fontSize:Dimensions.fontSizeLarge,color: KWhite.withOpacity(0.5),)),
              SizedBox(height: 20,),
              ReportCard(title: "Illegal Activity",isSeclected: selected==1,onTap: (){reportType="Illegal Activity";selected=1;setState(() {});widget.onReport!(reportType);}),
              SizedBox(height: 10,),
              ReportCard(title: "Spam",isSeclected: selected==2,onTap: (){reportType="Spam";selected=2;setState(() {});widget.onReport!(reportType);}),
              SizedBox(height: 10,),
              ReportCard(title: "Harassment or Bullying",isSeclected: selected==3,onTap: (){reportType="Harassment or Bullying";selected=3;setState(() {});widget.onReport!(reportType);}),
              SizedBox(height: 10,),
              ReportCard(title: "Hate Speech/Discrimination",isSeclected: selected==4,onTap: (){reportType="Hate Speech/Discrimination";selected=4;setState(() {});widget.onReport!(reportType);}),
              SizedBox(height: 10,),
              ReportCard(title: "Underage",isSeclected: selected==5,onTap: (){reportType="Underage";selected=5;setState(() {});widget.onReport!(reportType);}),
              SizedBox(height: 10,),
              ReportCard(title: "Impersonation",isSeclected: selected==6,onTap: (){reportType="Impersonation";selected=6;setState(() {});widget.onReport!(reportType);}),
            ],
          ),
      ),
    );
  }
}
