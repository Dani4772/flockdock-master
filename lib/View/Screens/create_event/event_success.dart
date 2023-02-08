import 'package:flocdock/Models/groupModel/group_model.dart';
import 'package:flocdock/Models/profileModel/profile_model.dart';
import 'package:flocdock/View/Screens/Home/home_page.dart';
import 'package:flocdock/View/Screens/create_event/choose_category.dart';
import 'package:flocdock/View/Screens/create_event/widget/bottom_navigator.dart';
import 'package:flocdock/View/Screens/create_event/widget/features.dart';
import 'package:flocdock/View/Screens/create_event/widget/important_rule.dart';
import 'package:flocdock/View/Screens/create_event/widget/tribe.dart';
import 'package:flocdock/View/Widgets/my_button.dart';
import 'package:flocdock/View/Widgets/my_spacing.dart';
import 'package:flocdock/View/Widgets/my_text.dart';
import 'package:flocdock/View/Widgets/my_text_field.dart';
import 'package:flocdock/View/base/bottom_navbar.dart';
import 'package:flocdock/View/base/custom_image.dart';
import 'package:flocdock/View/base/simple_appbar.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flocdock/models/groupModel/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

class EventSuccess extends StatefulWidget {
  const EventSuccess({Key? key}) : super(key: key);

  @override
  State<EventSuccess> createState() => _EventSuccessState();
}

class _EventSuccessState extends State<EventSuccess> {
  bool isSwitch=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KbgBlack,
      appBar: SimpleAppbar(description: "Gather a Group", pageName: 'HOST',pageTrailing: "",),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        const  SizedBox(),
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Text("SUCCESS",style: proximaBold.copyWith(color: KWhite,fontSize: Dimensions.fontSizeLarge),),
                SizedBox(height: 10,),
                Text("Your entry has been submitted!",style: proximaBold.copyWith(color: KdullWhite,fontSize: Dimensions.fontSizeLarge),),
                SizedBox(height: 20,),
                Container(
                  width: MediaQuery.of(context).size.width*0.8,
                  height: MediaQuery.of(context).size.height*0.2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: KBlue,width: 3),
                     image: DecorationImage(image: NetworkImage(eventDetail.groupCategoryImage??''),fit: BoxFit.cover)
                  ),
                  child:
                  //Image.network(eventDetail.groupCategoryImage??''),
                    //Image.asset('assets/images/dummyDataGroup.png')
                  Center(
                    child: MyText(
                      text: eventDetail.groupCategoryName??'',
                      fontFamily: "Proxima",
                      color: KWhite,
                      weight: FontWeight.w800,
                      size: 18,
                    ),
                  ),
                ),

              ],
            ),
          ),
      Padding(
        padding:  EdgeInsets.only(bottom: GetPlatform.isIOS?16.0:8.0),
        child: Container(
          height: 35,
          width: 80,
          child: MyButton(
            onPressed: () {
              eventDetail=EventDetail(features: [],tribes: [],importantRules: [],guests: [],userGuests: []);
              Get.offAll(HomePage());
            },
            buttonColor: KMediumBlue,
            text: "Done",
            textColor: KWhite,
            textWeight: FontWeight.w700,
            fontFamily: "Proxima",
            size: 16,
          ),

      )
      )
        ],
      ),
    );
  }
}
