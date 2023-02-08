import 'package:flocdock/Models/profileModel/profile_model.dart';
import 'package:flocdock/View/Screens/Home/home_page.dart';
import 'package:flocdock/View/Screens/create_event/widget/bottom_navigator.dart';
import 'package:flocdock/View/Screens/create_event/widget/features.dart';
import 'package:flocdock/View/Screens/create_event/widget/important_rule.dart';
import 'package:flocdock/View/Screens/create_event/widget/tribe.dart';
import 'package:flocdock/View/Widgets/my_button.dart';
import 'package:flocdock/View/Widgets/my_spacing.dart';
import 'package:flocdock/View/Widgets/my_text.dart';
import 'package:flocdock/View/Widgets/my_text_field.dart';
import 'package:flocdock/View/Widgets/profile_widget.dart';
import 'package:flocdock/View/base/bottom_navbar.dart';
import 'package:flocdock/View/base/custom_image.dart';
import 'package:flocdock/View/base/custom_snackbar.dart';
import 'package:flocdock/View/base/loading_dialog.dart';
import 'package:flocdock/View/base/simple_appbar.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flocdock/mixin/data.dart';
import 'package:flocdock/models/user_model/signup_model.dart';
import 'package:flocdock/services/dio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class EventEnd extends StatefulWidget {
  List<UserDetail>? endedGroupMembers=[];
  EventEnd({Key? key,this.endedGroupMembers}) : super(key: key);

  @override
  State<EventEnd> createState() => _EventEndState();
}

class _EventEndState extends State<EventEnd> {
  bool isSwitch=false;
  List<int> reliableMembers=[];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return true;
      },
      child: Scaffold(
        backgroundColor: KbgBlack,
        appBar: SimpleAppbar(description: "", pageName: 'BEACH PARTY',pageTrailing: "",),
        body: Padding(
          padding:EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 10,),
              Text("Group has Ended",style: proximaBold.copyWith(color: KWhite,fontSize: Dimensions.fontSizeLarge),),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("We hope you have fun! Please specify which of the users attended the groupby ticking their profile image.",textAlign: TextAlign.center,style: proximaBold.copyWith(color: KdullWhite,fontSize: Dimensions.fontSizeLarge),),
              ),
              SizedBox(height: 25,),
              Expanded(
                child: GridView.builder(
                    gridDelegate:
                    const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 120,
                        crossAxisSpacing: 13,
                        mainAxisSpacing: 13
                    ),
                    itemCount: widget.endedGroupMembers!.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return InkWell(
                        onTap: (){
                          if(reliableMembers.contains(widget.endedGroupMembers![index].usersId))
                            reliableMembers.remove(widget.endedGroupMembers![index].usersId);
                          else
                            reliableMembers.add(widget.endedGroupMembers![index].usersId!);
                          setState(() {});
                        },
                        child: ProfileContainer(
                            img: widget.endedGroupMembers![index].profilePicture==null||
                                widget.endedGroupMembers![index].profilePicture!.isEmpty?
                            AppConstants.placeholder:widget.endedGroupMembers![index].profilePicture!,
                            profileName:  widget.endedGroupMembers![index].userName??'',
                            distance: widget.endedGroupMembers![index].distanceAway.toPrecision(2).toString(),
                          isSelected: reliableMembers.contains(widget.endedGroupMembers![index].usersId),
                        ),
                      );
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Text("Skip",style: proximaBold.copyWith(color: KWhite,fontSize: Dimensions.fontSizeLarge),),
                  MyButton(
                    text: "Skip",
                    textColor: KWhite,
                    buttonColor: KbgBlack,
                    buttonHight: 30.0,
                    buttonWidth: 60.0,
                    onPressed: () => Get.back(),
                  ),
                  MyButton(
                    text: "DONE",
                    textColor: KWhite,
                    buttonColor: KBlue,
                    buttonHight: 35.0,
                    buttonWidth: 80.0,
                    onPressed: storeReliabilityMembers,
                  ),
                ],
              ),
              if(GetPlatform.isIOS)SizedBox(height: 8,)
            ],
          ),
        ),
      ),
    );
  }
  void storeReliabilityMembers() async {

    print("store_reliability_members");
    print(widget.endedGroupMembers?.first.groupId,);
    print(reliableMembers.toList());
    print(AppData().userdetail!.usersId);
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('store_reliability_members', {
      "groupId": widget.endedGroupMembers?.first.groupId,
      "memberId": reliableMembers,
      "usersId": AppData().userdetail!.usersId
    });
    if(response['status']=='success'){
      showCustomSnackBar(response['data']);
      Navigator.pop(context);
      Get.to(HomePage());
    }
    else{
      Navigator.pop(context);
      print(response['message']);
      showCustomSnackBar(response['message']);
    }
  }
}
