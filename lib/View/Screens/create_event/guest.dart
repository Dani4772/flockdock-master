import 'package:flocdock/View/Screens/create_event/choose_category.dart';
import 'package:flocdock/View/Screens/create_event/event_success.dart';
import 'package:flocdock/View/Screens/create_event/host_invite.dart';
import 'package:flocdock/View/Screens/create_event/widget/bottom_navigator.dart';
import 'package:flocdock/View/Widgets/my_text_field.dart';
import 'package:flocdock/View/base/custom_snackbar.dart';
import 'package:flocdock/View/base/loading_dialog.dart';
import 'package:flocdock/View/base/simple_appbar.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flocdock/mixin/data.dart';
import 'package:flocdock/services/dio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

class Guest extends StatefulWidget {
  const Guest({Key? key}) : super(key: key);

  @override
  State<Guest> createState() => _GuestState();
}

class _GuestState extends State<Guest> {
  bool isSwitch=false;
  bool isInvite=false;
  double _currentSliderValue=0;
  TextEditingController groupSizeController=TextEditingController();
  TextEditingController inviteSizeController=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    groupSizeController.text=eventDetail.maxGroupSize??"";
    inviteSizeController.text=eventDetail.inviteOtherGuests??"";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: KbgBlack,
        appBar: SimpleAppbar(description: "Gather a Group", pageName: 'HOST',pageTrailing: Images.close,isEvent: true,),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding:const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text("CHILL OUT GROUP",style: proximaBold.copyWith(color: KWhite,fontSize: Dimensions.fontSizeLarge),),
                    const SizedBox(height: 5,),
                    Text("GUEST",style: proximaBold.copyWith(color: KdullWhite),),
                    SizedBox(height: 20,),
                    eventDetail.userGuests!.isNotEmpty?Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width*0.9,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: eventDetail.userGuests!.length,
                          itemBuilder: (context,index){
                            return Container(
                              margin: EdgeInsets.only(right: 10),
                              child: index+1==eventDetail.userGuests!.length||index==0?Row(
                                children: [
                                  if(index==0)Column(
                                    children: [
                                      ClipOval(child: Image.network(AppData().userdetail!.profilePicture??AppConstants.placeholder,
                                        height: 50,width: 50,fit: BoxFit.cover,)),
                                      SizedBox(height: 5,),
                                      Text(AppData().userdetail!.userName??'',style: proximaRegular.copyWith(color: KWhite,fontSize: Dimensions.fontSizeExtraSmall),),
                                    ],
                                  ),
                                  if(index==0)SizedBox(width: 10,),
                                  Column(
                                    children: [
                                      ClipOval(
                                          child: Image.network(
                                            eventDetail.userGuests![index].profilePicture==null||eventDetail.userGuests![index].profilePicture!.isEmpty?
                                            AppConstants.placeholder:eventDetail.userGuests![index].profilePicture!,
                                        height: 50,width: 50,fit: BoxFit.cover,)),
                                      SizedBox(height: 5,),
                                      Text(eventDetail.userGuests![index].userName??'',style: proximaRegular.copyWith(color: KWhite,fontSize: Dimensions.fontSizeExtraSmall),),
                                    ],
                                  ),
                                  if(index+1==eventDetail.userGuests!.length)SizedBox(width: 10,),
                                  if(index+1==eventDetail.userGuests!.length)GestureDetector(
                                    onTap: () async {
                                      await Get.to(HostInvite());
                                      setState(() {});
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: KBlue
                                          ),
                                          child: Center(child: SvgPicture.asset(Images.add,height: 20,width: 20,color: KPureBlack,)),
                                        ),
                                        SizedBox(height: 5,),
                                        Text("Invite",style: proximaRegular.copyWith(color: KWhite,fontSize: Dimensions.fontSizeExtraSmall),),
                                      ],
                                    ),
                                  )
                                ],
                              ):
                              Column(
                                children: [
                                  ClipOval(
                                      child: Image.network(
                                        eventDetail.userGuests![index].profilePicture==null||eventDetail.userGuests![index].profilePicture!.isEmpty?
                                        AppConstants.placeholder:eventDetail.userGuests![index].profilePicture!,
                                        height: 50,width: 50,fit: BoxFit.cover,
                                      )
                                  ),
                                  SizedBox(height: 5,),
                                  Text(eventDetail.userGuests![index].userName??'',style: proximaRegular.copyWith(color: KWhite,fontSize: Dimensions.fontSizeExtraSmall),),
                                ],
                              ),
                            );
                          }
                      ),
                    ):
                    Wrap(
                      spacing: 10,
                      children: [
                        Column(
                          children: [
                            ClipOval(
                                child: Image.network(
                              AppData().userdetail!.profilePicture??AppConstants.placeholder,
                              height: 70,width: 70,fit: BoxFit.cover,
                                )
                            ),
                            SizedBox(height: 5,),
                            Text(AppData().userdetail!.userName??'',style: proximaRegular.copyWith(color: KWhite,fontSize: Dimensions.fontSizeExtraSmall),),
                          ],
                        ),
                        GestureDetector(
                          onTap: () async {
                            await Get.to(HostInvite());
                            setState(() {});
                          },
                          child: Column(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: KBlue
                                ),
                                child: Center(child: SvgPicture.asset(Images.add,height: 20,width: 20,color: KPureBlack,)),
                              ),
                              SizedBox(height: 5,),
                              Text("Invite",style: proximaRegular.copyWith(color: KWhite,fontSize: Dimensions.fontSizeExtraSmall),),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30,),
                    Row(
                      children: [
                        FlutterSwitch(
                          height: 25,
                          width: 45,
                          padding: 1,
                          toggleSize: 24,
                          activeColor: KBlue,
                          inactiveToggleColor: KDullBlack,
                          value: isSwitch,
                          onToggle: (value) {
                            setState(() {
                              isSwitch = value;
                            });
                            if(isSwitch)
                              eventDetail.topToBottomRatio=_currentSliderValue.toString();
                          },
                        ),
                        SizedBox(width: 20,),
                        Text("Top-to-Bottom Ratio",style: proximaBold.copyWith(color: KWhite,fontSize: Dimensions.fontSizeDefault+2,fontWeight: FontWeight.w500),),
                      ],
                    ),
                    SizedBox(height: 25,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(Images.top,height: 30,width: 30,color: KdullWhite,),
                          Slider(
                            value: _currentSliderValue,
                            max: 100,
                            activeColor: KBlue,
                            inactiveColor: KDullBlack,
                            label: _currentSliderValue.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                _currentSliderValue = value;
                              });
                            },
                          ),
                          Image.asset(Images.bottom,height: 30,width: 30,color: KdullWhite,),
                        ],
                      ),
                    ),
                    SizedBox(height: 25,),
                    Text("Maximum group size",style: proximaBold.copyWith(color: KWhite,fontSize: Dimensions.fontSizeDefault+2,fontWeight: FontWeight.w500),),
                    SizedBox(height: 5,),
                    MyTextField(
                      verticalPadding: 0.0,
                      hight: 50.0,
                      width: 120.0,
                      controller: groupSizeController,
                      onChanged: (val) => eventDetail.maxGroupSize=val,
                    ),
                    SizedBox(height: 35,),
                    Row(
                      children: [
                        FlutterSwitch(
                          height: 25,
                          width: 45,
                          padding: 1,
                          toggleSize: 24,
                          activeColor: KBlue,
                          inactiveToggleColor: KDullBlack,
                          value: isInvite,
                          onToggle: (value) {
                            setState(() {
                              isInvite = value;
                            });
                          },
                        ),
                        SizedBox(width: 20,),
                        Text("Guests can invite others",style: proximaBold.copyWith(color: KWhite,fontSize: Dimensions.fontSizeDefault+2,fontWeight: FontWeight.w500),),
                      ],
                    ),
                    SizedBox(height: 20,),
                    isInvite?MyTextField(
                      verticalPadding: 0.0,
                      hight: 50.0,
                      width: 120.0,
                      controller: inviteSizeController,
                      onChanged: (val) => eventDetail.inviteOtherGuests=inviteSizeController.text,
                    ):SizedBox(),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            ),
            Padding(
              padding:EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              child: BottomNavigator(selected: 4,trailing:"FINISH",
                  onTapLeading: () => Get.back(),onTapTrailing: eventDetail.fromEdit?editEvent:createEvent),
            ),
          ],
        ),
      ),
    );
  }
  void createEvent() async {
      eventDetail.userGuests!.map((e) => eventDetail.guests!.contains(e.usersId)?null:eventDetail.guests!.add(e.usersId!)).toList();
      eventDetail.title="test";
      eventDetail.usersId=AppData().userdetail!.usersId;
      print(eventDetail.toJson());
      openLoadingDialog(context, "Loading");
      var response;
      response = await DioService.post('create_group', {
        "usersId": eventDetail.usersId.toString(),
        "groupCategoryId": eventDetail.groupCategoryId.toString(),
        "title": eventDetail.title,
        "coverPhoto": eventDetail.coverPhoto,
        "startingTime": eventDetail.startingTime,
        "startingDate": eventDetail.startingDate,
        "endingDate": eventDetail.endingDate,
        "endingTime": eventDetail.endingTime,
        "address": eventDetail.address,
        "groupLong": eventDetail.groupLong.toString(),
        "groupLat": eventDetail.groupLat.toString(),
        "additionalInstructions": eventDetail.additionalInstructions,
        "cover": eventDetail.cover,
        "cost": eventDetail.cost,
        "guests" : eventDetail.guests,
        "maxGroupSize": eventDetail.maxGroupSize,
        "topToBottomRatio": eventDetail.topToBottomRatio,
        "inviteOtherGuests": eventDetail.inviteOtherGuests,
        "tribes": eventDetail.tribes,
        "importantRules": [
          for(int i=0; i<eventDetail.importantRules!.length;i++)
            {
              "importantRuleId": eventDetail.importantRules![i].importantRuleId,
              "answer": eventDetail.importantRules![i].answer
            },
        ],
        "features": eventDetail.features
      });

      print(eventDetail.usersId.toString());
    print(eventDetail.groupCategoryId.toString());
    print(eventDetail.title);
    print(eventDetail.coverPhoto);
    print(eventDetail.startingTime);
    print(eventDetail.startingDate);
    print(eventDetail.endingDate);
    print(eventDetail.endingTime);
    print(eventDetail.address);
    print(eventDetail.groupLong.toString());
    print(eventDetail.groupLat.toString());
    print(eventDetail.additionalInstructions);
    print(eventDetail.cover);
    print(eventDetail.cost);
    print(eventDetail.guests);
    print(eventDetail.maxGroupSize);
    print(eventDetail.topToBottomRatio);
    print(eventDetail.inviteOtherGuests);
    print(eventDetail.tribes);

      if(response['status']=='success'){
        print(response['data']);
        Navigator.pop(context);
        Get.offAll(EventSuccess());
        showCustomSnackBar(response['data']);
      }
      else{
        Navigator.pop(context);
        print(response['message']);
        showCustomSnackBar(response['message']);
      }

    }

  void editEvent() async {
      eventDetail.guests=[];
      eventDetail.userGuests!.map((e) => eventDetail.guests!.contains(e.usersId)?null:eventDetail.guests!.add(e.usersId!)).toList();
      eventDetail.title="test";
      eventDetail.usersId=AppData().userdetail!.usersId;
      openLoadingDialog(context, "Loading");
      var response;
      response = await DioService.post('edit_group', {
        "groupId": eventDetail.groupId,
        "usersId": eventDetail.usersId.toString(),
        "groupCategoryId": eventDetail.groupCategoryId.toString(),
        "title": eventDetail.title,
        if(!eventDetail.coverPhoto!.startsWith("http"))"coverPhoto": eventDetail.coverPhoto,
        "startingTime": eventDetail.startingTime,
        "startingDate": eventDetail.startingDate,
        "endingDate": eventDetail.endingDate,
        "endingTime": eventDetail.endingTime,
        "address": eventDetail.address,
        "groupLong": eventDetail.groupLong.toString(),
        "groupLat": eventDetail.groupLat.toString(),
        "additionalInstructions": eventDetail.additionalInstructions,
        "cover": eventDetail.cover,
        "cost": eventDetail.cost,
        "guests" : eventDetail.guests,
        "maxGroupSize": eventDetail.maxGroupSize,
        "topToBottomRatio": eventDetail.topToBottomRatio,
        "inviteOtherGuests": eventDetail.inviteOtherGuests,
        "tribes": eventDetail.tribes,
        "importantRules": [
          for(int i=0; i<eventDetail.importantRules!.length;i++)
            {
              "importantRuleId": eventDetail.importantRules![i].importantRuleId,
              "answer": eventDetail.importantRules![i].answer
            },
        ],
        "features": eventDetail.features
      });
      if(response['status']=='success'){
        print(response['data']);
        Navigator.pop(context);
        Get.offAll(EventSuccess());
        showCustomSnackBar(response['data']);
      }
      else{
        Navigator.pop(context);
        print(response['message']);
        showCustomSnackBar(response['message']);
      }

  }
}
