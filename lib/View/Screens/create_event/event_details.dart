import 'package:flocdock/View/Screens/create_event/choose_category.dart';
import 'package:flocdock/View/Screens/create_event/guest.dart';
import 'package:flocdock/View/Screens/create_event/widget/bottom_navigator.dart';
import 'package:flocdock/View/Screens/create_event/widget/cover.dart';
import 'package:flocdock/View/Screens/create_event/widget/features.dart';
import 'package:flocdock/View/Screens/create_event/widget/important_rule.dart';
import 'package:flocdock/View/Screens/create_event/widget/tribe.dart';
import 'package:flocdock/View/Widgets/my_text_field.dart';
import 'package:flocdock/View/base/custom_snackbar.dart';
import 'package:flocdock/View/base/simple_appbar.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventDetails extends StatelessWidget {
   EventDetails({Key? key}) : super(key: key);

  TextEditingController costController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    int selected=1;
    int cost=0;
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: KbgBlack,
        appBar: SimpleAppbar(description: "Gather a Group", pageName: 'HOST',pageTrailing: Images.close,isEvent: true,),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding:EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text("CHILL OUT GROUP",style: proximaBold.copyWith(color: KWhite,fontSize: Dimensions.fontSizeLarge),),
                    SizedBox(height: 5,),
                    Text("DETAILS",style: proximaBold.copyWith(color: KdullWhite,fontSize: 16),),
                    SizedBox(height: 25,),
                    Text("Tribe",style: proximaExtraBold.copyWith(color: KWhite,),),
                    SizedBox(height: 12),
                    TribeItems(),
                    SizedBox(height: 25),
                    Text("Important Rules",style: proximaExtraBold.copyWith(color: KWhite,),),
                    SizedBox(height: 12),
                    ImportantRule(),
                    SizedBox(height: 25),
                    Text("Features",style: proximaExtraBold.copyWith(color: KWhite,),),
                    SizedBox(height: 12),
                    Features(),
                    SizedBox(height: 25),
                    // MyText(
                    //   text: "Top-to-Bottom Ratio",
                    //   color: KWhite,
                    //   weight: FontWeight.w400,
                    //   size: 18,
                    //   fontFamily: "Proxima",
                    // ),
                    // spaceVertical(10),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Container(
                    //       height: 29,
                    //       width: 29,
                    //       decoration: BoxDecoration(
                    //           color: KDullBlack, shape: BoxShape.circle),
                    //       child: Center(
                    //           child: MyText(
                    //         text: "Icon",
                    //         size: 12,
                    //         color: KWhite,
                    //       )),
                    //     ),
                    //     Slider(
                    //       value: _currentSliderValue,
                    //       max: 100,
                    //       activeColor: KBlue,
                    //       inactiveColor: KDullBlack,
                    //       label: _currentSliderValue.round().toString(),
                    //       onChanged: (double value) {
                    //         setState(() {
                    //           _currentSliderValue = value;
                    //         });
                    //       },
                    //     ),
                    //     Container(
                    //       height: 29,
                    //       width: 29,
                    //       decoration: BoxDecoration(
                    //           color: KDullBlack, shape: BoxShape.circle),
                    //       child: Center(
                    //           child: MyText(
                    //         text: "Icon",
                    //         color: KWhite,
                    //             size: 12,
                    //       )),
                    //     ),
                    //   ],
                    // ),
                    // spaceVertical(20),
                    Text("Cover",style: proximaExtraBold.copyWith(color: KWhite,),),
                    SizedBox(height: 12,),
                    Cover(selected: (select,val){
                      selected=select;
                      cost=val;
                      print(selected);
                      print(cost);
                      if(select==1)
                        eventDetail.cover="Free admittance";
                      else
                        eventDetail.cover="Per Guest";
                    },
                    ),

                    SizedBox(height: 20,),
                  ],
                ),
              ),
            ),
            Padding(
              padding:EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              child: Align(alignment:Alignment.bottomCenter,child: BottomNavigator(selected: 3,onTapLeading: () => Get.back(),onTapTrailing: detailCheck)),
            ),
          ],
        ),
      ),
    );
  }
  void detailCheck(){
    if(eventDetail.tribes==null||eventDetail.tribes!.isEmpty){
      showCustomSnackBar("Please select tribe");
    }
    else if(eventDetail.features==null||eventDetail.features!.isEmpty){
      showCustomSnackBar("Please select features");
    }
    else if(eventDetail.cover==null||eventDetail.cover!.isEmpty){
      eventDetail.cover="Free admittance";
      Get.to(Guest());
    }
    else{
      Get.to(Guest());
    }
  }

}
