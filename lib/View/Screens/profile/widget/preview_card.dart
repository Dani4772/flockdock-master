import 'package:flocdock/View/Screens/chat/chat.dart';
import 'package:flocdock/View/base/custom_snackbar.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flocdock/models/user_model/signup_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class PreviewCard extends StatelessWidget {
  UserDetail? userDetail;
  void Function()? onTapUser;
  PreviewCard({Key? key,this.userDetail,this.onTapUser}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Container(
          height: 7,
          width: MediaQuery.of(context).size.width*0.3,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: KBlue,
              borderRadius: BorderRadius.circular(5)
          ),
        ),
        Row(
          children: [
            Text(userDetail!.userName??'',style: proximaBold.copyWith(color: KWhite,fontSize: Dimensions.fontSizeOverLarge)),
            userDetail!.verified=="No"?SizedBox():
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle
              ),
              child: Center(child: Icon(Icons.check,color: KWhite,size: 20,)),
            ),
            userDetail!.isOnline?Container(
              height: 12,
              width: 12,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.lightGreenAccent.withOpacity(0.8),
                  shape: BoxShape.circle
              ),
            ):SizedBox(),

          ],
        ),
        SizedBox(height: 6,),
        Row(
          children: [
            Text("${userDetail!.age??""} Years old,",style: proximaSemiBold.copyWith(color: KWhite,fontWeight: FontWeight.normal)),
            SizedBox(width: 10,),
            Text(userDetail!.relationshipStatus??'',style: proximaBold.copyWith(color: KWhite,fontSize: Dimensions.fontSizeLarge)),
          ],
        ),
        // SizedBox(height: 6,),
        Row(
          children: [
            SvgPicture.asset(Images.address,width: 15,height: 15,),
            SizedBox(width: 5,),
            Text("${userDetail!.distanceAway.toPrecision(2).toString()} km",style: proximaSemiBold.copyWith(fontWeight:FontWeight.normal,color: KWhite,)),
            Expanded(child: Container()),
            Row(
              children: [
                GestureDetector(
                  onTap: userDetail!.isTapped?() => showCustomSnackBar("Already Taped",isError: false):onTapUser,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 7),
                    child: SvgPicture.asset(Images.active_fire,width: 18,height: 18,color: userDetail!.isTapped?null:KWhite,),
                    decoration: BoxDecoration(
                        color: KDullBlack,
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                GestureDetector(
                  onTap: () => Get.to(Chat(name: userDetail!.userName??'',id: userDetail!.usersId!,)),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
                    child: SvgPicture.asset(Images.chat,color: KWhite,width: 18,height: 18,),
                    decoration: BoxDecoration(
                        color: KDullBlack,
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
