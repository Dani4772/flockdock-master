import 'package:flocdock/View/Screens/create_event/widget/event_category.dart';
import 'package:flocdock/View/Screens/group/group_view.dart';
import 'package:flocdock/View/Screens/profile/widget/preview_card.dart';
import 'package:flocdock/View/Screens/profile/widget/private_picture_permission_dialog.dart';
import 'package:flocdock/View/Screens/profile/widget/profile_item.dart';
import 'package:flocdock/View/Screens/profile/widget/report_block_dialog.dart';
import 'package:flocdock/View/Screens/profile/widget/report_dialog.dart';
import 'package:flocdock/View/Widgets/my_button.dart';
import 'package:flocdock/View/base/custom_snackbar.dart';
import 'package:flocdock/View/base/loading_dialog.dart';
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
import 'package:draggable_bottom_sheet_nullsafety/draggable_bottom_sheet_nullsafety.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ProfileView extends StatefulWidget {
  int? userId;
  ProfileView({Key? key,this.userId}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with TickerProviderStateMixin {

  UserDetail userDetail=UserDetail(tribes: [],seeking: [],attendedGroups: [],hostedGroups: [],otherUserStories: []);
  String seeking="";
  String tribe="";
  String url="";
  String type="Profile";
  double minPrice = 0;
  double maxPrice = 100;
  double value = 76;
  double _upperValue = 100;
  int ind = 0;
  bool isActive=false;
  TabController? _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getUserDetail();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(

        color: KPureBlack,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
        isDraggable: true,
        backdropEnabled: true,
        backdropTapClosesPanel: true,
        minHeight: 135,
        maxHeight: userDetail.attendedGroups!.length == 0?MediaQuery.of(context).size.height*0.7:MediaQuery.of(context).size.height*0.89,
        body: Stack(
          children: [
            GestureDetector(
              onTap: (){
                if(userDetail.otherUserStories![ind].pictureType=="Visible"){
                  print('here it is pressed');
                  print('url');
                  print(url);
                  print('new');
                  url=userDetail.otherUserStories![ind].picture??'';
                  print(url);
                  print(userDetail.otherUserStories![ind].pictureType);
                  print(userDetail.otherUserStories![ind]);
                  print(userDetail.otherUserStories!.length);
                  print(ind);
                }
                else if(userDetail.otherUserStories![ind].pictureType=="Private"){
                  Get.dialog(PrivatPicturePermission(onTapRequestPermission: requestPrivateGallery,));

                }
                ind = ind+1;
                setState(() {});
              },
              child: Image.network(
                //url=
                  url.isNotEmpty?url:userDetail.profilePicture??AppConstants.placeholder,
                //url.isNotEmpty?url:"https://th.bing.com/th/id/R.3e77a1db6bb25f0feb27c95e05a7bc57?rik=DswMYVRRQEHbjQ&riu=http%3a%2f%2fwww.coalitionrc.com%2fwp-content%2fuploads%2f2017%2f01%2fplaceholder.jpg&ehk=AbGRPPcgHhziWn1sygs8UIL6XIb1HLfHjgPyljdQrDY%3d&risl=&pid=ImgRaw&r=0",
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.fill,
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: MediaQuery.of(context).size.width*0.95,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30,),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: (){
                              url=userDetail.profilePicture??AppConstants.placeholder;
                              setState(() {});
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 2,vertical: 5),
                              height: 10,
                              decoration: BoxDecoration(
                                  color: url==userDetail.profilePicture?KBlue:KDullBlack,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                            ),
                          ),
                        ),
                        for(int i=0;i<userDetail.otherUserStories!.length;i++)
                          if(userDetail.otherUserStories![i].pictureType=="Visible")
                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  url=userDetail.otherUserStories![i].picture??'';
                                  setState(() {});
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 2,vertical: 5),
                                  height: 10,
                                  decoration: BoxDecoration(
                                      color: userDetail.otherUserStories![i].picture==url?KBlue:KDullBlack,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                ),
                              ),
                            ),
                        for(int i=0;i<userDetail.otherUserStories!.length;i++)
                          if(userDetail.otherUserStories![i].pictureType=="Private")
                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  if(userDetail.otherUserStories![i].pictureType=="Private") {
                                    if(userDetail.otherPrivateGalleryAccess=="Allowed")
                                      url=userDetail.otherUserStories![i].picture??'';
                                    else
                                      Get.dialog(PrivatPicturePermission(onTapRequestPermission: requestPrivateGallery,));
                                  }
                                  setState(() {});
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 2,vertical: 5),
                                  height: 10,
                                  decoration: BoxDecoration(
                                      color: userDetail.otherUserStories![i].picture==url?KBlue:Colors.red,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                ),
                              ),
                            ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(onTap: () => Get.back(),child: Icon(Icons.arrow_circle_left,color: KBlue,size: 30,)),
                        Expanded(child: Container()),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: favouriteUser,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
                                child: SvgPicture.asset(Images.star,color: userDetail.isFavourite?KBlue:KWhite,width: 18,height: 18,),
                                decoration: BoxDecoration(
                                    color: KDullBlack,
                                    borderRadius: BorderRadius.circular(20)
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            GestureDetector(
                              onTap: () => Get.dialog(ReportBlockDialog(onBlock: blockUser,onReport: () {Get.back();Get.dialog(ReportDialog(onReport: (val){reportUser(val);},));},)),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
                                child: SvgPicture.asset(Images.report,color: KWhite,width: 18,height: 18,),
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
                ),
              ),
            ),
          ],
        ),
        collapsed: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: KPureBlack,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
          ),
          child: PreviewCard(userDetail: userDetail,onTapUser: tapUser,),
        ),
        panel: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width*0.9,
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration:  BoxDecoration(
                color: KPureBlack,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
            ),
            child: Column(
              children: [
                PreviewCard(userDetail: userDetail,onTapUser: tapUser,),
                SizedBox(height: 20,),
                Align(alignment: Alignment.topLeft,child: Text('DESCRIPTION',style: proximaSemiBold.copyWith(color: KBlue,),)),
                SizedBox(height: 10,),
                Align(alignment:Alignment.topLeft,child: Text(userDetail.description??'',style: proximaSemiBold.copyWith(color: KWhite,))),
                SizedBox(height: 15,),
                ProfileItem(title: "HEIGHT",value: userDetail.height??'',),
                ProfileItem(title: "WEIGHT:",value: "${userDetail.weight??''} KG",),
                ProfileItem(title: "ETHNICITY:",value: userDetail.ethnicity??'',),
                ProfileItem(title: "BODY TYPE:",value: userDetail.bodyType??'',),
                ProfileItem(title: "TRIBE:",value: tribe),
                ProfileItem(title: "LOOKING FOR::",value: seeking,),
                Row(
                  children: [
                    Expanded(child: Text("FIND ME ON:", style: proximaSemiBold.copyWith(color: KBlue,))),
                    Expanded(
                        child: Row(
                          children: [
                            if(userDetail.instagramLink!=null)SvgPicture.asset(Images.instagram,width: 20),
                            SizedBox(width: 10,),
                            if(userDetail.facebookLink!=null)SvgPicture.asset(Images.facebook,width: 20),
                            SizedBox(width: 10,),
                            if(userDetail.twitterLink!=null)SvgPicture.asset(Images.twitter,width: 20),
                          ],
                        )
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  color: Colors.white.withOpacity(0.5),
                  height: 1,
                ),
                userDetail.isMeetup?SizedBox():Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Have you met this person?", style: proximaSemiBold.copyWith(color: KWhite,)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MyButton(
                        text: "Yes",
                        size: Dimensions.fontSizeLarge,
                        textColor: KWhite,
                        buttonColor: KBlue,
                        buttonHight: 25.0,
                        buttonWidth: 60.0,
                        onPressed: meetUser,
                      ),
                    ),
                  ],
                ),
                userDetail.attendedGroups!.length == 0? SizedBox():  Container(
                  width: MediaQuery.of(context).size.width,
                  color: KDullBlack,
                  child: TabBar(
                    labelStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                    controller: _tabController,
                    indicatorColor: KBlue,
                    indicatorWeight: 5,
                    labelColor: KWhite,
                    unselectedLabelColor:KdullWhite,
                    tabs: const [
                      Tab(text: 'ATTENDING',),
                      Tab(text: 'HOSTING'),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                userDetail.attendedGroups!.length == 0? SizedBox(): Container(
                  height: 110,
                  width: MediaQuery.of(context).size.width*0.9,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      GridView.builder(
                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 4 / 2.4,
                              crossAxisSpacing: 13,
                              mainAxisSpacing: 13
                          ),
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: userDetail.attendedGroups!.length,
                          itemBuilder: (BuildContext ctx, index){
                            return InkWell(
                              onTap: () => Get.to(GroupView(groupId: userDetail.attendedGroups![index].groupId,)),
                              child: EventCategory(
                                isSelected: false,
                                img: userDetail.attendedGroups![index].coverPhoto??'',
                                groupName: userDetail.attendedGroups![index].category!.category??'',
                              ),
                            );
                          }
                      ),
                      GridView.builder(
                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 4 / 2.4,
                              crossAxisSpacing: 13,
                              mainAxisSpacing: 13
                          ),
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: userDetail.hostedGroups!.length,
                          itemBuilder: (BuildContext ctx, index){
                            return InkWell(
                              onTap: () => Get.to(GroupView(groupId: userDetail.hostedGroups![index].groupId,)),
                              child: EventCategory(
                                isSelected: false,
                                img: userDetail.hostedGroups![index].coverPhoto??'',
                                groupName: userDetail.hostedGroups![index].category!.category??'',
                              ),
                            );
                          }
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),

                Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width*0.9,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: KDullBlack,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Reliability",style: proximaSemiBold.copyWith(color: KWhite,)),
                          Text("${userDetail.reliability}%",style: proximaSemiBold.copyWith(color: KBlue,)),
                        ],
                      ),
                      Container(
                        height: 20,
                        child: SliderTheme(
                          data: SliderThemeData(
                            activeTrackColor: KBlue,
                            inactiveTrackColor: KdullWhite,
                            thumbShape: SliderComponentShape.noThumb,
                            showValueIndicator: ShowValueIndicator.never,
                          ),
                          child: Slider(value: double.tryParse(userDetail.reliability.toString())??0.0, onChanged: (val) {}, min: 0, max:  100),
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 25,),
              ],
            ),
          ),
        ),
      ),
      // body: DraggableBottomSheet(
      //   minExtent: 150,
      //   maxExtent: MediaQuery.of(context).size.height*0.9,
      //   previewChild: Container(
      //     padding: EdgeInsets.symmetric(horizontal: 20),
      //     decoration: BoxDecoration(
      //       color: KPureBlack.withOpacity(0.5),
      //         borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
      //     ),
      //     child: PreviewCard(userDetail: userDetail,onTapUser: tapUser,),
      //   ),
      //   expandedChild: SingleChildScrollView(
      //     child: Container(
      //       width: MediaQuery.of(context).size.width*0.9,
      //       padding: EdgeInsets.symmetric(horizontal: 20),
      //       decoration: const BoxDecoration(
      //           color: KPureBlack,
      //           borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
      //       ),
      //       child: Column(
      //         children: [
      //           PreviewCard(userDetail: userDetail,onTapUser: tapUser,),
      //           SizedBox(height: 10,),
      //           Align(alignment:Alignment.topLeft,child: Text(userDetail.description??'',style: proximaSemiBold.copyWith(color: KWhite,))),
      //           SizedBox(height: 10,),
      //           ProfileItem(title: "HEIGHT",value: userDetail.height??'',),
      //           ProfileItem(title: "WEIGHT:",value: "${userDetail.weight??''} KG",),
      //           ProfileItem(title: "ETHNICITY:",value: userDetail.ethnicity??'',),
      //           ProfileItem(title: "BODY TYPE:",value: userDetail.bodyType??'',),
      //           ProfileItem(title: "TRIBE:",value: tribe),
      //           ProfileItem(title: "LOOKING FOR::",value: seeking,),
      //           Row(
      //             children: [
      //               Expanded(child: Text("FIND ME ON:", style: proximaSemiBold.copyWith(color: KBlue,))),
      //               Expanded(
      //                   child: Row(
      //                     children: [
      //                       if(userDetail.instagramLink!=null)SvgPicture.asset(Images.instagram,width: 20),
      //                       SizedBox(width: 10,),
      //                       if(userDetail.facebookLink!=null)SvgPicture.asset(Images.facebook,width: 20),
      //                       SizedBox(width: 10,),
      //                       if(userDetail.twitterLink!=null)SvgPicture.asset(Images.twitter,width: 20),
      //                     ],
      //                   )
      //               ),
      //             ],
      //           ),
      //           Container(
      //             margin: EdgeInsets.symmetric(vertical: 10),
      //             color: Colors.white.withOpacity(0.5),
      //             height: 1,
      //           ),
      //           userDetail.isMeetup?SizedBox():Row(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Text("Have you met this person?", style: proximaSemiBold.copyWith(color: KWhite,)),
      //               Padding(
      //                 padding: const EdgeInsets.all(8.0),
      //                 child: MyButton(
      //                   text: "Yes",
      //                   size: Dimensions.fontSizeLarge,
      //                   textColor: KWhite,
      //                   buttonColor: KBlue,
      //                   buttonHight: 25.0,
      //                   buttonWidth: 60.0,
      //                   onPressed: meetUser,
      //                 ),
      //               ),
      //             ],
      //           ),
      //           Container(
      //             width: MediaQuery.of(context).size.width,
      //             color: KDullBlack,
      //             child: TabBar(
      //               controller: _tabController,
      //               indicatorColor: KBlue,
      //               indicatorWeight: 5,
      //               labelColor: KWhite,
      //               unselectedLabelColor:KdullWhite,
      //               tabs: const [
      //                 Tab(text: 'ATTENDING'),
      //                 Tab(text: 'HOSTING'),
      //               ],
      //             ),
      //           ),
      //           SizedBox(height: 10,),
      //           Container(
      //             height: 110,
      //             width: MediaQuery.of(context).size.width*0.9,
      //             child: TabBarView(
      //               controller: _tabController,
      //               children: [
      //                 GridView.builder(
      //                     gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      //                         maxCrossAxisExtent: 200,
      //                         childAspectRatio: 4 / 2.7,
      //                         crossAxisSpacing: 13,
      //                         mainAxisSpacing: 13
      //                     ),
      //                     physics: BouncingScrollPhysics(),
      //                     padding: EdgeInsets.zero,
      //                     itemCount: userDetail.attendedGroups!.length,
      //                     itemBuilder: (BuildContext ctx, index){
      //                       return InkWell(
      //                         onTap: () => Get.to(GroupView(groupId: userDetail.attendedGroups![index].groupId,)),
      //                         child: EventCategory(
      //                           isSelected: false,
      //                           img: userDetail.attendedGroups![index].coverPhoto??'',
      //                           groupName: userDetail.attendedGroups![index].category!.category??'',
      //                         ),
      //                       );
      //                     }
      //                 ),
      //                 GridView.builder(
      //                     gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      //                         maxCrossAxisExtent: 200,
      //                         childAspectRatio: 4 / 2.7,
      //                         crossAxisSpacing: 13,
      //                         mainAxisSpacing: 13
      //                     ),
      //                     physics: BouncingScrollPhysics(),
      //                     padding: EdgeInsets.zero,
      //                     itemCount: userDetail.hostedGroups!.length,
      //                     itemBuilder: (BuildContext ctx, index){
      //                       return InkWell(
      //                         onTap: () => Get.to(GroupView(groupId: userDetail.hostedGroups![index].groupId,)),
      //                         child: EventCategory(
      //                           isSelected: false,
      //                           img: userDetail.hostedGroups![index].coverPhoto??'',
      //                           groupName: userDetail.hostedGroups![index].category!.category??'',
      //                         ),
      //                       );
      //                     }
      //                 ),
      //               ],
      //             ),
      //           ),
      //           SizedBox(height: 10,),
      //
      //           Container(
      //             height: 100,
      //             width: MediaQuery.of(context).size.width*0.9,
      //             padding: EdgeInsets.all(15),
      //             decoration: BoxDecoration(
      //               color: KDullBlack,
      //               borderRadius: BorderRadius.circular(10)
      //             ),
      //             child: Column(
      //               children: [
      //                 Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                   children: [
      //                     Text("Reliability",style: proximaSemiBold.copyWith(color: KWhite,)),
      //                     Text("${userDetail.reliability}%",style: proximaSemiBold.copyWith(color: KBlue,)),
      //                   ],
      //                 ),
      //                 SliderTheme(
      //                   data: SliderThemeData(
      //                     activeTrackColor: KBlue,
      //                     inactiveTrackColor: KdullWhite,
      //                     thumbShape: SliderComponentShape.noThumb,
      //                     showValueIndicator: ShowValueIndicator.never,
      //                   ),
      //                   child: Slider(value: double.tryParse(userDetail.reliability.toString())??0.0, onChanged: (val) {}, min: 0, max:  100),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      //   backgroundWidget: SafeArea(
      //     child: Stack(
      //       children: [
      //         Image.network(
      //           url.isNotEmpty?url:"https://th.bing.com/th/id/R.3e77a1db6bb25f0feb27c95e05a7bc57?rik=DswMYVRRQEHbjQ&riu=http%3a%2f%2fwww.coalitionrc.com%2fwp-content%2fuploads%2f2017%2f01%2fplaceholder.jpg&ehk=AbGRPPcgHhziWn1sygs8UIL6XIb1HLfHjgPyljdQrDY%3d&risl=&pid=ImgRaw&r=0",
      //           height: MediaQuery.of(context).size.height,
      //           fit: BoxFit.cover,
      //         ),
      //         Align(
      //           alignment: Alignment.topCenter,
      //           child: Container(
      //             width: MediaQuery.of(context).size.width*0.95,
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Row(
      //                   children: [
      //                     Expanded(
      //                       child: GestureDetector(
      //                         onTap: (){
      //                           url=userDetail.profilePicture??AppConstants.placeholder;
      //                           setState(() {});
      //                         },
      //                         child: Container(
      //                           margin: EdgeInsets.symmetric(horizontal: 2,vertical: 5),
      //                           height: 10,
      //                           decoration: BoxDecoration(
      //                               color: url==userDetail.profilePicture?KBlue:KDullBlack,
      //                               borderRadius: BorderRadius.circular(5)
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                     for(int i=0;i<userDetail.otherUserStories!.length;i++)
      //                       if(userDetail.otherUserStories![i].pictureType=="Visible")
      //                       Expanded(
      //                         child: GestureDetector(
      //                           onTap: (){
      //                             url=userDetail.otherUserStories![i].picture??'';
      //                             setState(() {});
      //                           },
      //                           child: Container(
      //                             margin: EdgeInsets.symmetric(horizontal: 2,vertical: 5),
      //                             height: 10,
      //                             decoration: BoxDecoration(
      //                                 color: userDetail.otherUserStories![i].picture==url?KBlue:KDullBlack,
      //                                 borderRadius: BorderRadius.circular(5)
      //                             ),
      //                           ),
      //                         ),
      //                       ),
      //                     for(int i=0;i<userDetail.otherUserStories!.length;i++)
      //                       if(userDetail.otherUserStories![i].pictureType=="Private")
      //                         Expanded(
      //                           child: GestureDetector(
      //                             onTap: (){
      //                               if(userDetail.otherUserStories![i].pictureType=="Private") {
      //                                 if(userDetail.otherPrivateGalleryAccess=="Allowed")
      //                                   url=userDetail.otherUserStories![i].picture??'';
      //                                 else
      //                                   Get.dialog(PrivatPicturePermission(onTapRequestPermission: requestPrivateGallery,));
      //                               }
      //                               setState(() {});
      //                             },
      //                             child: Container(
      //                               margin: EdgeInsets.symmetric(horizontal: 2,vertical: 5),
      //                               height: 10,
      //                               decoration: BoxDecoration(
      //                                   color: userDetail.otherUserStories![i].picture==url?KBlue:Colors.red,
      //                                   borderRadius: BorderRadius.circular(5)
      //                               ),
      //                             ),
      //                           ),
      //                         ),
      //                   ],
      //                 ),
      //                 SizedBox(height: 10,),
      //                 Row(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     GestureDetector(onTap: () => Get.back(),child: Icon(Icons.arrow_back_ios_sharp,color: KWhite,)),
      //                     Expanded(child: Container()),
      //                     Column(
      //                       children: [
      //                         GestureDetector(
      //                           onTap: favouriteUser,
      //                           child: Container(
      //                             padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
      //                             child: SvgPicture.asset(Images.star,color: userDetail.isFavourite?KBlue:KWhite,width: 18,height: 18,),
      //                             decoration: BoxDecoration(
      //                                 color: KDullBlack,
      //                                 borderRadius: BorderRadius.circular(20)
      //                             ),
      //                           ),
      //                         ),
      //                         SizedBox(height: 10,),
      //                         GestureDetector(
      //                           onTap: () => Get.dialog(ReportBlockDialog(onBlock: blockUser,onReport: () {Get.back();Get.dialog(ReportDialog(onReport: (val){reportUser(val);},));},)),
      //                           child: Container(
      //                             padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
      //                             child: SvgPicture.asset(Images.report,color: KWhite,width: 18,height: 18,),
      //                             decoration: BoxDecoration(
      //                                 color: KDullBlack,
      //                                 borderRadius: BorderRadius.circular(20)
      //                             ),
      //                           ),
      //                         )
      //                       ],
      //                     ),
      //
      //                   ],
      //                 ),
      //
      //               ],
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
  void getUserDetail() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('specific_user_details', {
      "userId":AppData().userdetail!.usersId,
      "otherUserId": widget.userId.toString(),
      "userLat":AppData().userdetail!.latitude.toString(),
      "userLong":AppData().userdetail!.longitude.toString(),
    });
    print(response);
    if(response['status']=='success'){
      var jsonData= response['data'] ;
      userDetail=UserDetail.fromJson(jsonData);
      userDetail.tribes!.map((e) => tribe=tribe+e.tribe!+", ").toList();
      userDetail.seeking!.map((e) => seeking=seeking+e.seeking!+", ").toList();
      url=userDetail.profilePicture??AppConstants.placeholder;
      Navigator.pop(context);
      setState(() {});
    }
    else{
      Navigator.pop(context);
      print(response['message']);
      showCustomSnackBar(response['message']);
    }

  }
  void requestPrivateGallery() async {
    Navigator.pop(context);
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('request_private_gallery', {
      "requestedByUserId":AppData().userdetail!.usersId.toString(),
      "requestedToUserId":userDetail.usersId.toString()
    });
    if(response['status']=='success'){
      showCustomSnackBar(response['data']);
      Navigator.pop(context);
    }
    else{
      Navigator.pop(context);
      print(response['message']);
      showCustomSnackBar(response['message']);
    }

  }
  void meetUser() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('meet_user', {
      "metToUserId": userDetail.usersId.toString(),
      "metByUserId": AppData().userdetail!.usersId.toString()
    });
    if(response['status']=='success'){
      showCustomSnackBar(response['data']);
      userDetail.isMeetup=true;
      Navigator.pop(context);
      setState(() {});
    }
    else{
      Navigator.pop(context);
      print(response['message']);
      showCustomSnackBar(response['message']);
    }

  }
  void tapUser() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('tap_user', {
      "tappingToUserId": userDetail.usersId.toString(),
      "tappingByUserId": AppData().userdetail!.usersId.toString()
    });
    if(response['status']=='success'){
      showCustomSnackBar(response['data']);
      userDetail.isTapped=true;
      Navigator.pop(context);
      setState(() {});
    }
    else{
      Navigator.pop(context);
      print(response['message']);
      showCustomSnackBar(response['message']);
    }

  }
  void favouriteUser() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('favourite_user', {
      "userId": AppData().userdetail!.usersId,
      "favouriteUserId": userDetail.usersId
    });
    if(response['status']=='success'){
      showCustomSnackBar(response['data']);
      userDetail.isFavourite=!userDetail.isFavourite;
      Navigator.pop(context);
      setState(() {});
    }
    else{
      Navigator.pop(context);
      print(response['message']);
      showCustomSnackBar(response['message']);
    }

  }
  void blockUser() async {
    Navigator.pop(context);
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('block_user', {
      "blockedByUserId":AppData().userdetail!.usersId.toString(),
      "blockedUserId":userDetail.usersId.toString()
    });
    if(response['status']=='success'){
      showCustomSnackBar(response['data']);
      Navigator.pop(context);
    }
    else{
      Navigator.pop(context);
      print(response['message']);
      showCustomSnackBar(response['message']);
    }

  }
  void reportUser(String reason) async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('report_user', {
      "reportedByUserId":AppData().userdetail!.usersId.toString(),
      "reportedToUserId":userDetail.usersId.toString(),
      "reason":reason
    });
    if(response['status']=='success'){
      showCustomSnackBar(response['data']);
      Navigator.pop(context);
      Navigator.pop(context);
    }
    else{
      Navigator.pop(context);
      Navigator.pop(context);
      print(response['message']);
      showCustomSnackBar(response['message']);
    }

  }
}
