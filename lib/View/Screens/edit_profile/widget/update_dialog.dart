import 'package:flocdock/View/Widgets/my_button.dart';
import 'package:flocdock/View/base/custom_image.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EditDelete extends StatelessWidget {
  void Function()? onEditTap;
  void Function()? onDeleteTap;
  EditDelete({Key? key,this.onEditTap,this.onDeleteTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      backgroundColor: KDullBlack,
      child: Container(
        height: 170,
          width: 250,
          padding: EdgeInsets.only(top: 20,right: 20,left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(child: Container()),
                  Text("Edit Profile picture",style: proximaBold.copyWith(fontSize:Dimensions.fontSizeLarge,color: KWhite,)),
                  Expanded(child: Container()),
                  InkWell(
                    onTap: () => Get.back(),
                      child: SvgPicture.asset(Images.close,color: KdullWhite,height: 15,width: 15,),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Text("Do you want to Edit or \nDelete the picture?",textAlign: TextAlign.center,style: proximaBold.copyWith(fontSize:Dimensions.fontSizeLarge,color: KWhite.withOpacity(0.5),)),
              SizedBox(height: 20,),
              Row(
                children: [
                  Container(
                    height: 35,
                    width: MediaQuery.of(context).size.width/3.5,
                    child: MyButton(
                      onPressed: onEditTap,
                      buttonColor: KMediumBlue,
                      text: "Edit",
                      textColor: KWhite,
                      textWeight: FontWeight.w700,
                      fontFamily: "Proxima",
                      size: 16,
                    ),

                  ),
                  SizedBox(width: 10,),
                  Container(
                    height: 35,
                    width: MediaQuery.of(context).size.width/3.5,
                    child: MyButton(
                      onPressed: onDeleteTap,
                      buttonColor: KMediumBlue,
                      text: "Delete",
                      textColor: KWhite,
                      textWeight: FontWeight.w700,
                      fontFamily: "Proxima",
                      size: 16,
                    ),

                  ),
                ],
              )
            ],
          ),
      ),
    );
  }
}
