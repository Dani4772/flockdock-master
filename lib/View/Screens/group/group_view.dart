import 'package:flocdock/View/Screens/Home/home_page.dart';
import 'package:flocdock/View/Screens/create_event/choose_category.dart';
import 'package:flocdock/View/Screens/create_event/host_invite.dart';
import 'package:flocdock/View/Screens/group/widget/action_widget.dart';
import 'package:flocdock/View/Screens/group/widget/feature_item.dart';
import 'package:flocdock/View/Screens/group/widget/join_dialog.dart';
import 'package:flocdock/View/Screens/group/widget/message.dart';
import 'package:flocdock/View/Screens/group/widget/rule_item.dart';
import 'package:flocdock/View/Widgets/my_button.dart';
import 'package:flocdock/View/Widgets/my_text.dart';
import 'package:flocdock/View/base/custom_snackbar.dart';
import 'package:flocdock/View/base/loading_dialog.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flocdock/mixin/data.dart';
import 'package:flocdock/models/groupModel/event_model.dart';
import 'package:flocdock/models/message/message_model.dart';
import 'package:flocdock/services/dio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GroupView extends StatefulWidget {
  int? groupId;
  GroupView({Key? key,this.groupId}) : super(key: key);

  @override
  _GroupViewState createState() => _GroupViewState();
}

class _GroupViewState extends State<GroupView> {
  GroupData? groupData=GroupData(isUserAttending: false,isUserInterested: false,isUserReported: false,
      members: [],features: [],rules: [],tribes: [],groupLat: 0,groupLong: 0);
  Set<Marker> markers = Set.of([]);
  bool isJoined=false;
  bool isHost=false;
  List<Messages> message=[];
  TextEditingController messageController=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getGroupDetail();
    });

  }
  @override
  Widget build(BuildContext context) {
    double hight=MediaQuery.of(context).size.height;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent, // status bar color
    ));
    return Scaffold(
      backgroundColor: KbgBlack,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              groupData?.coverPhoto==null?
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.3,
                  ):
              Stack(
                children: [
                  Image.network(
                      groupData?.coverPhoto??'',
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.23,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0,left: 15),
                    child: GestureDetector(onTap: () => Get.back(),child: Icon(Icons.arrow_back_ios_sharp,color: KWhite,)),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    margin: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: KWhite,width: 1),
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: SvgPicture.asset(Images.fire),
                    ),
                  ),
                  Text(groupData?.category?.category??'',style: proximaExtraBold.copyWith(color: KWhite,fontSize: 24,fontWeight: FontWeight.w800)),
                  Expanded(child: SizedBox()),
                  isJoined&&!isHost?GestureDetector(
                    onTap: leaveGroup,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text("LEAVE GROUP",style: proximaBold.copyWith(color: Colors.redAccent,fontSize: Dimensions.fontSizeSmall)),
                    ),
                  ):SizedBox(),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("From",style: proximaBold.copyWith(color: KdullWhite,)),
                        SizedBox(height: 10,),
                        Text("To",style: proximaBold.copyWith(color: KdullWhite)),
                      ],
                    ),
                    SizedBox(width: 10,),
                    SvgPicture.asset(Images.event_date),
                    SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(groupData?.formattedFromDatetime??'',style: proximaBold.copyWith(color: KdullWhite,)),
                        SizedBox(height: 10,),
                        Text(groupData?.formattedToDatetime??'',style: proximaBold.copyWith(color: KdullWhite)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Container(
                color: Colors.white.withOpacity(0.2),
                width: MediaQuery.of(context).size.width*0.85,
                height: 1,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: isJoined?30:50,vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if(groupData!.isUserAttending! && AppData().userdetail!.usersId!=groupData!.usersId)
                      ActionWidget(text: "ATTENDING", icon: Images.attending,color: KBlue),
                    isHost?
                    ActionWidget(text: "EDIT", icon: Images.edit,onTap: () => Get.to(ChooseCategory(fromEdit: true,groupId: groupData!.groupId,))):
                    ActionWidget(text: "INTERESTED", icon: Images.star,onTap: interestGroup,color: groupData!.isUserInterested!?KBlue:KWhite),
                    isHost?
                    ActionWidget(text: "CANCEL", icon: Images.close,onTap: cancelGroup):
                    ActionWidget(text: "SHARE", icon: Images.share),
                    isHost?
                    ActionWidget(text: "EDIT PARTICIPANTS", icon: Images.multi_users,onTap: (){
                      Get.to(HostInvite(fromEditParticipant: true,groupId: groupData?.groupId,guest: groupData?.members,));
                    }):
                    ActionWidget(text: "REPORT", icon: Images.report,onTap: reportGroup,color: groupData!.isUserReported!?KBlue:KWhite),
                  ],
                ),
              ),
              Container(
                color: Colors.white.withOpacity(0.2),
                width: MediaQuery.of(context).size.width*0.85,
                height: 1,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                  child: Text("Address",style: proximaExtraBold.copyWith(color: KWhite,fontSize: Dimensions.fontSizeLarge)),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0,right: 20,bottom: 10),
                  child: Text(groupData?.address??'',style: proximaRegular.copyWith(color: KWhite,fontSize: Dimensions.fontSizeSmall)),
                ),
              ),

              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    height: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: GoogleMap(
                        markers: markers,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(groupData!.groupLat??0,groupData!.groupLong??0),
                          zoom: 10,
                        ),
                        onMapCreated: (GoogleMapController mapController) {

                        },
                        zoomControlsEnabled: false,
                        onCameraMove: (CameraPosition cameraPosition) async {

                        },
                        onCameraMoveStarted: () {

                        },
                        onCameraIdle: () async {

                        },
                      ),
                    )
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${isHost?"PARTICIPANTS":"ATTENDING"} ("+groupData!.totalAttendees.toString()+")",style: proximaExtraBold.copyWith(color: KWhite,fontSize: Dimensions.fontSizeLarge)),
                      if(isJoined&&!isHost)Text("You are going to this event",style: proximaSemiBold.copyWith(color: KWhite.withOpacity(0.5),fontSize: Dimensions.fontSizeSmall)),
                    ],
                  ),
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width*0.9,
                child: Wrap(
                  spacing: 8,
                  runSpacing: 10,
                  children: [
                    for(int index=0;index<groupData!.members!.length;index++)
                      Container(
                        width: MediaQuery.of(context).size.width*0.16,
                        height: MediaQuery.of(context).size.width*0.16,
                        child: InkWell(
                          //onTap: () => Get.to(ProfileView(userId: groupData!.members![index].usersId,)),
                          child: ProfileContainer(
                              img: groupData!.members![index].profilePicture??AppConstants.placeholder,
                              profileName: groupData!.members![index].userName??'',
                            isHost: groupData!.members![index].usersId==groupData!.usersId,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                  child: Text("FEATURES",style: proximaExtraBold.copyWith(color: KWhite,fontSize: Dimensions.fontSizeLarge)),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      for(int i=0;i<groupData!.features!.length;i++)
                        FeatureItem(text: groupData!.features![i].feature??''),
                    ],
                  )
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                  child: Text("IMPORTANT RULES",style: proximaExtraBold.copyWith(color: KWhite,fontSize: Dimensions.fontSizeLarge)),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0,),
                    child: Wrap(
                      spacing: 8,
                      children: [
                        for(int i=0;i<groupData!.rules!.length;i++)
                          if(groupData!.rules![i].answer=="No")
                            RulesItem(text: groupData!.rules![i].importantRule!,isAllowed: false),
                      ],
                    )
                ),
              ),
              SizedBox(height: 2,),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0,),
                    child: Wrap(
                      spacing: 8,
                      children: [
                        for(int i=0;i<groupData!.rules!.length;i++)
                          if(groupData!.rules![i].answer=="Yes")
                            RulesItem(text: groupData!.rules![i].importantRule!,),
                      ],
                    )
                ),
              ),
              SizedBox(height: 12,),

              isJoined?Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5),
                  child: Text("GROUP MESSAGES",style: proximaExtraBold.copyWith(color: KWhite,fontSize: Dimensions.fontSizeLarge)),
                ),
              ):Container(
                width: MediaQuery.of(context).size.width,
                height: 73,
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                color: KDullBlack.withOpacity(0.5),
                child: MyButton(
                  text: isJoined?"Join":"Joined",
                  textColor: KWhite,
                  size: Dimensions.fontSizeExtraLarge,
                 buttonColor: KMediumBlue,
                 // buttonColor: Colors.pink,
                  buttonHight: 53.0,
                  buttonWidth: MediaQuery.of(context).size.width*0.8,
                  onPressed: () => Get.dialog(JoinDialog(onConfirmPressed: (){
                    Get.back();
                    joinGroup();
                    print('thsi is presses');
                    print(isJoined);
                  },)),
                ),
              ),
              if(isJoined)SizedBox(
                height: message.isEmpty?0:message.length==1?hight*0.1:message.length==2?hight*0.2:hight*0.3,
                child: ListView.builder(
                  reverse: true,
                  padding: EdgeInsets.zero,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: message.length,
                    itemBuilder: (context,index){
                      return Message(message: message[index]);
                    }
                ),
              ),
              if(isJoined)Container(
                decoration: BoxDecoration(
                  color: KDullBlack,
                  borderRadius: BorderRadius.circular(40)
                ),
                margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.55,
                      child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: KWhite,
                          controller: messageController,
                          autofocus: false,
                          style: proximaBold.copyWith(color: KWhite),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Write a message",
                            hintStyle: proximaBold.copyWith(color: Colors.white.withOpacity(0.7))
                          )
                      ),
                    ),
                    Container(
                      height: 35,
                      width: 70,
                      child: MyButton(
                        onPressed: sendMessage,
                        buttonColor: KMediumBlue,
                        text: "Send",
                        textColor: KWhite,
                        textWeight: FontWeight.w700,
                        fontFamily: "Proxima",
                        size: 16,
                      ),

                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void sendMessage() async {
    if(messageController.text.trim().isEmpty){
      showCustomSnackBar("Type Message to send");
    }
    else{
      openLoadingDialog(context, "Loading");
      var response;
      response = await DioService.post('group_messages', {
        "usersId":AppData().userdetail!.usersId,
        "groupId":groupData!.groupId,
        "requestType" : "sendMessage",
        "content": messageController.text.toString()
      });
      if(response['status']=='success'){
        Navigator.pop(context);
        messageController.clear();
        getMessage();
      }
      else{
        Navigator.pop(context);
        print(response['message']);
        showCustomSnackBar(response['message']);
      }
    }

  }
  void getMessage() async {
    var response;
    response = await DioService.post('group_messages', {
      "usersId":AppData().userdetail!.usersId,
      "groupId":groupData!.groupId,
      "requestType" : "getMessages"
    });
    if(response['status']=='success'){
      var jsonData= response['data'] as List;
      message=jsonData.map((e) => Messages.fromJson(e)).toList();
      setState(() {});
    }
    else{
      print(response['message']);
      //showCustomSnackBar(response['message']);
    }

  }
  void joinGroup() async {
      openLoadingDialog(context, "Loading");
      var response;
      response = await DioService.post('join_group_as_attendee', {
        "usersId":AppData().userdetail!.usersId.toString(),
        "groupId":groupData!.groupId.toString()
      });
      if(response['status']=='success'){
        var jsonData= response['data'];
        showCustomSnackBar(response['data'],isError: false);
        setState(() {});
        Navigator.pop(context);
      }
      else{
        Navigator.pop(context);
        print(response['message']);
        showCustomSnackBar(response['message']);
      }

    }
  void interestGroup() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('user_interest_in_group', {
      "usersId":AppData().userdetail!.usersId.toString(),
      "groupId":groupData!.groupId.toString()
    });
    if(response['status']=='success'){
      showCustomSnackBar(response['data'],isError: false);
      groupData?.isUserInterested=true;
      setState(() {});
      Navigator.pop(context);
    }
    else{
      Navigator.pop(context);
      print(response['message']);
      showCustomSnackBar(response['message']);
    }

  }
  void leaveGroup() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('leave_group', {
      "usersId":AppData().userdetail!.usersId.toString(),
      "groupId":groupData!.groupId.toString()
    });
    if(response['status']=='success'){
      showCustomSnackBar(response['data'],isError: false);
      isJoined=false;
      groupData?.isUserAttending=false;
      setState(() {});
      Navigator.pop(context);
    }
    else{
      Navigator.pop(context);
      print(response['message']);
      showCustomSnackBar(response['message']);
    }

  }
  void reportGroup() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('report_group', {
      "usersId":AppData().userdetail!.usersId.toString(),
      "groupId":groupData!.groupId.toString()
    });
    if(response['status']=='success'){
      showCustomSnackBar(response['data'],isError: false);
      groupData?.isUserReported=true;
      setState(() {});
      Navigator.pop(context);
    }
    else{
      Navigator.pop(context);
      print(response['message']);
      showCustomSnackBar(response['message']);
    }

  }
  void cancelGroup() async {
    print(groupData!.groupId.toString());
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('cancel_group', {
      "groupId":groupData!.groupId.toString()
    });
    if(response['status']=='success'){
      print(response);
      showCustomSnackBar(response['data']['status_message'],isError: false);
      Navigator.pop(context);
      Get.to(HomePage());
    }
    else{
      Navigator.pop(context);
      print(response['message']);
      showCustomSnackBar(response['message']);
    }
  }

  void getGroupDetail() async {
    print(widget.groupId);
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('specific_group_details', {
      "usersId":AppData().userdetail!.usersId,
      "userLat":AppData().userdetail!.latitude.toString(),
      "userLong":AppData().userdetail!.longitude.toString(),
      "groupId" : widget.groupId.toString()
    });
    if(response['status']=='success'){
      var jsonData= response['data'] ;
      groupData=GroupData.fromJson(jsonData);
      isHost=AppData().userdetail!.usersId==groupData!.usersId;
      isJoined=isHost?true:groupData!.isUserAttending!;
      isJoined?getMessage():null;
      await setMarker();
      Navigator.pop(context);
      setState(() {});
    }
    else{

      print('specific group details function');
      print(isJoined);
      Navigator.pop(context);
      print(response['message']);
      showCustomSnackBar(response['message']);
    }
  }
   setMarker() async {
    markers.clear();
    print("groupData!.groupLat");
    print(groupData!.groupLat);
    print(groupData!.groupLong);
    print("groupData!.groupLong");
    markers.add(Marker(
      markerId: const MarkerId('marker'),
      position: LatLng(groupData!.groupLat??0,groupData!.groupLong??0),
    ));
    setState(() {});
  }
}
Widget ProfileContainer({required String img,required String profileName,bool isHost=false})
{
  return Stack(children: <Widget>[
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.transparent,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(
              img.isURL?img:"https://th.bing.com/th/id/R.f70716a016d050b36d53b140cfcefce5?rik=nHI2ixAxPcXyMQ&riu=http%3a%2f%2fsumprop.com%2fsites%2fdefault%2ffiles%2fOur+Work+Icon.jpg&ehk=e6KzrPqL8uZWbVkxhSb%2fjY%2fvr1jLONs96WxhfGtl8Fg%3d&risl=&pid=ImgRaw&r=0"
          ),
        ),
      ),
    ),
    Center(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.5),
                Colors.grey.withOpacity(0.0),
              ],
              stops: const [
                0.0,
                1.0
              ]
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText(
              text: profileName,
              size: 10,
              weight: FontWeight.w800,
              color: KWhite,
              fontFamily: "Proxima",
            ),
            isHost?Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: KBlue,
              ),
              padding: EdgeInsets.symmetric(vertical: 2,horizontal: 5),
              child: MyText(
                text: "Host",
                size: 10,
                weight: FontWeight.w800,
                color: KWhite,
                fontFamily: "Proxima",
              ),
            ):SizedBox(),
          ],
        ),
      ),
    )
  ]);
}
