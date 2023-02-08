import 'dart:convert';

import 'package:flocdock/Models/groupModel/group_model.dart';
import 'package:flocdock/View/Screens/create_event/basic_info.dart';
import 'package:flocdock/View/Screens/create_event/widget/bottom_navigator.dart';
import 'package:flocdock/View/Screens/create_event/widget/event_category.dart';
import 'package:flocdock/View/Widgets/my_button.dart';
import 'package:flocdock/View/Widgets/my_text.dart';
import 'package:flocdock/View/base/bottom_navbar.dart';
import 'package:flocdock/View/base/custom_appbar.dart';
import 'package:flocdock/View/base/custom_snackbar.dart';
import 'package:flocdock/View/base/loading_dialog.dart';
import 'package:flocdock/View/base/simple_appbar.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flocdock/mixin/data.dart';
import 'package:flocdock/models/groupModel/category_model.dart';
import 'package:flocdock/models/groupModel/event_model.dart';
import 'package:flocdock/services/dio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

EventDetail eventDetail=EventDetail(features: [],tribes: [],importantRules: [],guests: [],userGuests: [],
    groupLat: AppData().userdetail!.latitude??0,groupLong: AppData().userdetail!.longitude??0);
GroupDetail groupDetail=GroupDetail();
class ChooseCategory extends StatefulWidget {
  bool fromEdit;
  int? groupId;
  ChooseCategory({Key? key,this.groupId,this.fromEdit=false}) : super(key: key);

  @override
  State<ChooseCategory> createState() => _ChooseCategoryState();
}

class _ChooseCategoryState extends State<ChooseCategory> {
  List<GroupCategory> categories=[];
  int selected=-1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventDetail=EventDetail(features: [],tribes: [],importantRules: [],guests: [],userGuests: [],
        groupLat: AppData().userdetail!.latitude??0,groupLong: AppData().userdetail!.longitude??0);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getCategories();
      if(widget.fromEdit)prefilledEditGroupDetail();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KbgBlack,
      appBar: SimpleAppbar(description: "Gather a Group", pageName: 'HOST',pageTrailing: Images.close,),
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text("CATEGORY",style: proximaBold.copyWith(color: KWhite,fontSize: Dimensions.fontSizeLarge+1),),
            SizedBox(height: 3,),
            Text("Choose a Category",style: proximaBold.copyWith(color: KdullWhite,fontSize: 15),),
            SizedBox(height: 10,),

            Expanded(
              child: GridView.builder(
                physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 4 / 2.2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8
                  ),
                  itemCount: categories.length,
                  itemBuilder: (BuildContext ctx, index){
                    return InkWell(
                      onTap: (){
                        selected=categories[index].categoryId!;
                        eventDetail.groupCategoryId=categories[index].categoryId;
                        eventDetail.groupCategoryName=categories[index].category;
                        //eventDetail.groupCategoryImage=categories[index].categoryImage;
                        setState(() {

                        });
                      },
                      child: EventCategory(
                        isSelected: selected==categories[index].categoryId!,
                          img: categories[index].categoryImage!,
                          groupName: categories[index].category!,
                      ),
                    );
                  }
              ),
            ),

            BottomNavigator(selected: 1,isLeading: false,onTapTrailing: () => eventDetail.groupCategoryId==null?showCustomSnackBar("Please Choose Category"):Get.to(BasicInfo())),
            // ListView.builder(
            //     physics: NeverScrollableScrollPhysics(),
            //     shrinkWrap: true,
            //     //padding: EdgeInsetsGeometry.infinity,
            //     itemCount: 3,
            //     itemBuilder: (context,index){
            //       return Column(
            //         children: [
            //           InboxList(isInvite: index==1,isLive: index==0,),
            //           Padding(
            //             padding: const EdgeInsets.symmetric(vertical: 5.0),
            //             child: Container(
            //               color: Colors.white.withOpacity(0.2),
            //               width: MediaQuery.of(context).size.width*0.85,
            //               height: 1,
            //             ),
            //           ),
            //         ],
            //
            //       );
            //
            //     }
            // )

          ],
        ),
      ),
    );
  }

  void getCategories() async {

      openLoadingDialog(context, "Loading");
      var response;
      response = await DioService.get('get_predefined_group_details');
      if(response['status']=='success'){
        var jsonData= response['data'];
        groupDetail =  GroupDetail.fromJson(jsonData);
        if(!widget.fromEdit)groupDetail.importantRules!.map((e) => eventDetail.importantRules!.add(Rules(importantRuleId: e.importantRuleId))).toList();
        categories=groupDetail.groupCategories!;
        setState(() {});
        Navigator.pop(context);
      }
      else{
        Navigator.pop(context);
        print(response['message']);
        showCustomSnackBar(response['message']);
      }
    }

  void prefilledEditGroupDetail() async {
    var response;
    response = await DioService.post('prefilled_edit_group_details', {
      "groupId": widget.groupId
    });
    if(response['status']=='success'){
      var jsonData= response['data'] ;
      eventDetail=EventDetail.fromJson(jsonData);
      print(eventDetail.cost);
      selected=eventDetail.groupCategoryId!;
      eventDetail.fromEdit=true;
      categories.map((e){
        if(e.categoryId==selected){
          eventDetail.groupCategoryImage=e.categoryImage;
          eventDetail.groupCategoryName=e.category;
        }
      }).toList();
      setState(() {});
    }
    else{
      print(response['message']);
      showCustomSnackBar(response['message']);
    }

  }
}
