import 'package:flocdock/View/base/custom_image.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flocdock/models/inbox/inbox_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../models/user_model/signup_model.dart';
import '../../chat/chat.dart';

class InboxList extends StatelessWidget {
  UserDetail? userDetail;
  InboxDetail? inboxDetail=InboxDetail();
  void Function()? onTapAccept;
  void Function()? onTapIgnore;
  bool isLive;
  InboxList({Key? key,this.inboxDetail,this.onTapAccept,this.onTapIgnore,this.isLive=false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return inboxDetail!.itemType=="ChatItem"?
    GestureDetector(
      onTap: () => Get.to(Chat(name: inboxDetail!.userName??'',id: inboxDetail!.senderId!,)),
      child: Center(
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.2,
                  height: MediaQuery.of(context).size.width*0.2,
                  child: Stack(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            inboxDetail!.profilePicture==null||inboxDetail!.profilePicture!.isEmpty?AppConstants.placeholder:inboxDetail!.profilePicture!,
                            height: 75,
                            width: 80,
                            fit: BoxFit.cover,
                          )
                      ),
                      inboxDetail!.isOnline?Positioned(
                        right: 0,bottom: 4,
                        child: Container(
                          margin: EdgeInsets.only(left: 5,top: 5,right: 5),
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                            color: Colors.lightGreenAccent.shade400,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ):SizedBox(),
                      Positioned(
                        top: 0,right: 0,
                        child: Container(
                          margin: EdgeInsets.only(left: 5,top: 5,right: 5),
                          height: 10,
                          width: 10,
                          decoration: const BoxDecoration(
                            color: KOrange,
                            shape: BoxShape.circle,
                          ),
                          child: Align(alignment:Alignment.center,child: Text(inboxDetail!.badgeCount.toString(),style: proximaBold.copyWith(color: KWhite,fontSize: Dimensions.fontSizeExtraSmall),)),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.70,
                  padding: EdgeInsets.only(left:Dimensions.PADDING_SIZE_SMALL,top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.67,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(inboxDetail!.userName??'',style: proximaBold.copyWith(color: KBlue,)),
                            Text(inboxDetail!.formattedTime??'',style: proximaRegular.copyWith(color: KDullBlack,),),
                          ],
                        ),
                      ),
                      Text(inboxDetail!.message??'',style: proximaRegular.copyWith(color: KWhite.withOpacity(0.5),),),
                    ],
                  ),
                ),
              ],
            )
        ),
      ),
    ):
    Center(
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width*0.2,
                height: MediaQuery.of(context).size.width*0.2,
                child: Stack(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          inboxDetail!.profilePicture??AppConstants.placeholder,
                          height: 75,
                          width: 80,
                          fit: BoxFit.cover,
                        )
                    ),
                    isLive?Positioned(
                      right: 0,bottom: 4,
                      child: Container(
                        margin: EdgeInsets.only(left: 5,top: 5,right: 5),
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          color: Colors.lightGreenAccent.shade400,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ):
                    Positioned(
                      right: 0,bottom: 4,
                      child: Container(
                        margin: EdgeInsets.only(left: 5,top: 5,right: 5),
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          color: KPureBlack,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SvgPicture.asset(Images.hot),
                        ),
                      ),
                    ),
                    isLive?Positioned(
                      top: 0,right: 0,
                      child: Container(
                        margin: EdgeInsets.only(left: 5,top: 5,right: 5),
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          color: KOrange,
                          shape: BoxShape.circle,
                        ),
                        child: Align(alignment:Alignment.center,child: Text("1",style: proximaBold.copyWith(color: KWhite,fontSize: Dimensions.fontSizeExtraSmall),)),
                      ),
                    ):SizedBox(),
                  ],
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width*0.70,
                padding: EdgeInsets.only(left:Dimensions.PADDING_SIZE_SMALL,top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(inboxDetail!.userName??'',style: proximaBold.copyWith(color: KBlue,)),
                        //Expanded(child: SizedBox()),
                        Text(inboxDetail!.formattedTime??'',style: proximaRegular.copyWith(color: KDullBlack,),),
                      ],
                    ),
                    Text(inboxDetail!.message?.trim()??'',style: proximaRegular.copyWith(color: KWhite.withOpacity(0.5),),),
                    SizedBox(height: 5,),
                    (inboxDetail!.notificationType=="GroupJoinRequest"||inboxDetail!.notificationType=="GroupInviteRequest")&&inboxDetail!.status!="Responded"?
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: onTapAccept,
                          child: Container(
                            margin: EdgeInsets.only(left: 5,right: 5),
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              border: Border.all(width: 2,color: Colors.green),
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: SvgPicture.asset(Images.check,),
                            ),
                          ),
                        ),
                        Text("ACCEPT",style: proximaRegular.copyWith(color: KWhite,),),
                        GestureDetector(
                          onTap: onTapIgnore,
                          child: Container(
                            margin: EdgeInsets.only(left: 5,right: 5),
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              border: Border.all(width: 2,color: Colors.red),
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: SvgPicture.asset(Images.check,color: Colors.red,),
                            ),
                          ),
                        ),
                        Text("IGNORE",style: proximaBold.copyWith(color: KWhite,),),
                      ],
                    ):
                    SizedBox(),
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }

}
