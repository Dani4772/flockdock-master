import 'dart:async';
import 'package:any_link_preview/any_link_preview.dart';
import 'package:dio/dio.dart';
import 'package:flocdock/View/Screens/chat/pictures_page.dart';
import 'package:flocdock/View/Screens/chat/pictures_view.dart';
import 'package:flocdock/View/Screens/chat/saved_phrase.dart';
import 'package:flocdock/View/Screens/profile/widget/report_dialog.dart';
import 'package:flocdock/View/Widgets/my_text_field.dart';
import 'package:flocdock/View/base/custom_snackbar.dart';
import 'package:flocdock/View/base/loading_dialog.dart';
import 'package:flocdock/View/base/simple_appbar.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flocdock/mixin/data.dart';
import 'package:flocdock/models/message/chat_model.dart';
import 'package:flocdock/services/dio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/message/picture_model.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';



class Chat extends StatefulWidget {
  String name;
  int id;
  Chat({Key? key,this.name="",required this.id}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<ChatMessages> messages=[];
  ChatMessages message=ChatMessages();
  UpdatedMessages updatedMessages=UpdatedMessages(unreadMessages: []);
  TextEditingController messageController=TextEditingController();
  Timer? timer;
  PickedFile pickedFile=PickedFile("");
  String image="";
  bool isSearch =false;
  TextEditingController searchController=TextEditingController();
  ScrollController _scrollController=ScrollController();
  Pictures pictures=Pictures(recentImages: [],lastWeekImages: [],lastMonthImages: []);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      startChat();
      getMessages();

    });
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) =>  updateMessages());
  }
  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KbgBlack,
      appBar: SimpleAppbar(description: "Messages", pageName: "INBOX",pageTrailing: "",),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            child: Align(
              // alignment: Alignment.center,
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back_ios_rounded,color: KDullBlack,size: 20,),
                        Text("Back",style: proximaBold.copyWith(color: KdullWhite)),
                      ],
                    ),
                  ),
                  SizedBox(width: 100,),
                  Text(widget.name,style: proximaBold.copyWith(color: KWhite),),
                  SizedBox(width: 80,),
                  isSearch?Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 30,
                          // margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_DEFAULT),
                          // width: MediaQuery.of(context).size.width*0.3,
                          width: 22,
                          padding: EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: TextField(
                            controller: searchController,
                            keyboardType: TextInputType.text,
                            // onChanged: (value) async {
                            //   // if(value!=""){
                            //   //   searchUserGroups();
                            //   // }
                            //   //print(_autoCompleteResult.first.mainText);
                            // },
                            cursorColor: KWhite,
                            style: proximaBold.copyWith(color: KWhite),
                            autofocus: false,
                            decoration: InputDecoration(
                              focusColor: Color.fromARGB(1,65, 68, 82,).withOpacity(0.9),
                              hoverColor: Color.fromARGB(1,65, 68, 82,).withOpacity(0.9),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(style: BorderStyle.none, width: 0),
                              ),
                              isDense: true,
                              hintText: "Search...",
                               hintStyle: proximaBold.copyWith(color: KWhite.withOpacity(0.5),
                               ),
                              fillColor: Color.fromARGB(1,65, 68, 82,).withOpacity(0.9),
                              filled: true,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(bottom: 6.0),
                                child: Icon(Icons.search,size: 15,color: KWhite.withOpacity(0.5)),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            // print("AppLifecycleState.paused");
                            // print(AppLifecycleState.paused.index);
                            // print(AppLifecycleState.paused.name);
                            // print("AppLifecycleState.detached");
                            // print(AppLifecycleState.detached.index);
                            // print(AppLifecycleState.detached.name);
                            // print("AppLifecycleState.inactive");
                            // print(AppLifecycleState.inactive.index);
                            // print(AppLifecycleState.inactive.name);
                            // print("AppLifecycleState.resumed");
                            // print(AppLifecycleState.resumed.index);
                            // print(AppLifecycleState.resumed.name);

                            setState(() {
                              searchController.clear();
                              isSearch=!isSearch;
                            });
                          },
                          child: Align(
                              // alignment: Alignment.center,
                              child: Container(
                                  padding: EdgeInsets.only(right: 20.0),
                                  child: Icon(Icons.close,color: KWhite, size: 20,)
                              )
                          ),
                        )
                      ],
                    ),
                  ):SizedBox(),
                  isSearch?SizedBox():Expanded(
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          isSearch=!isSearch;
                        });
                      },
                      child: Align(
                          // alignment: Alignment.centerRight,
                          child: SvgPicture.asset(Images.search, width: 15,)
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => Get.dialog(
                        Dialog(
                          backgroundColor: Colors.transparent,
                          insetPadding: EdgeInsets.only(top: 90,left: MediaQuery.of(context).size.width*0.60,right: 10),
                          alignment: Alignment.topRight,
                          child: Container(
                            height: 120,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: KDullBlack,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: KDullBlack,width: 1),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                InkWell(
                                    onTap: (){
                                      Get.back();
                                      Get.to(PicturesPage(id: widget.id,));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text('Pictures', style: proximaBold.copyWith(color: KWhite),),
                                    )
                                ),
                                Container(height:1,color: KdullWhite,margin: EdgeInsets.symmetric(vertical: 10),),
                                InkWell(
                                    onTap: (){
                                      Get.back();
                                      Get.dialog(ReportDialog(onReport: (val){reportUser(val);},));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5),                                            child: Text('Report', style: proximaBold.copyWith(color: KWhite),),
                                    )
                                ),
                                Container(height:1,color: KdullWhite,margin: EdgeInsets.symmetric(vertical: 10),),
                                InkWell(
                                    onTap: (){
                                      Get.back();
                                      blockUser();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text('Block', style: proximaBold.copyWith(color: KWhite),),
                                    )
                                ),


                              ],
                            ),
                          ),
                        )
                    ),
                    child: Center(
                        child:  Icon(Icons.more_vert,size:20,color: Colors.grey.withOpacity(0.5),)
                    ),
                  )
                  // PopupMenuButton(
                  //   shape: Border.all(width: 1,color: KdullWhite,),
                  //   padding: EdgeInsets.all(10),
                  //   color: KDullBlack,
                  //     child: Center(
                  //         child:  Icon(Icons.more_vert,size:20,color: Colors.grey.withOpacity(0.5),)
                  //     ),
                  //     itemBuilder: (context) => [
                  //       PopupMenuItem(
                  //         onTap: () => Get.to(PicturesPage()),
                  //         padding:const EdgeInsets.symmetric(vertical: 0,horizontal: 8),
                  //         height:20,
                  //         child: Column(
                  //           children: [
                  //             Text('Pictures', style: proximaBold.copyWith(color: KWhite),),
                  //             Container(height:1,color: KdullWhite,margin: EdgeInsets.symmetric(vertical: 5),),
                  //           ],
                  //         ),
                  //       ),
                  //       PopupMenuItem(
                  //         padding:const EdgeInsets.symmetric(vertical: 0,horizontal: 8),
                  //         height:20,
                  //         child: Column(
                  //           children: [
                  //             Text('Report', style: proximaBold.copyWith(color: KWhite),),
                  //             Container(height:1,color: KdullWhite,margin: EdgeInsets.symmetric(vertical: 5),),
                  //           ],
                  //         ),
                  //       ),
                  //       PopupMenuItem(
                  //         onTap: () => blockUser(),
                  //         padding:const EdgeInsets.symmetric(vertical: 0,horizontal: 8),
                  //         height:20,
                  //         child: Column(
                  //           children: [
                  //             Text('Block', style: proximaBold.copyWith(color: KWhite),),
                  //             Container(height:1,color: KdullWhite,margin: EdgeInsets.symmetric(vertical: 5),),
                  //           ],
                  //         ),
                  //
                  //
                  //       ),
                  //     ]
                  // ),

                ],
              ),
            ),
          ),
          Container(height:1,color: KDullBlack,),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.zero,
                      //physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      //padding: EdgeInsetsGeometry.infinity,
                      itemCount: messages.length+1,
                      itemBuilder: (context,index){
                      print(index);

                        if(index == messages.length){
                           return Container(
                            height: 70,
                          );
                        }
                      print('inside builder');
                        if(index == 0){
                          print('inside if statement');
                          _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 1), curve: Curves.easeOut);
                        }
                      //if(index == 0){
                       // scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 1), curve: Curves.easeOut);}
                        return messages[index].userId==AppData().userdetail!.usersId.toString()?
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.8,
                            child: Column(
                              children: [
                                messages[index].msgType=="attachment"?FullScreenWidget(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width*0.8,
                                    height: MediaQuery.of(context).size.height*0.25

                                    ,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(messages[index].message??'',),
                                        fit: BoxFit.scaleDown,
                                      ),
                                        borderRadius: BorderRadius.circular(10),
                                        color: KDullBlack
                                    ),
                                    padding: EdgeInsets.all(15),
                                    margin: EdgeInsets.only(top: 10,right: 20),
                                  ),
                                ):
                                messages[index].msgType=="location"?
                                Container(
                                  width: MediaQuery.of(context).size.width*0.8,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: KDullBlack
                                  ),
                                  margin: EdgeInsets.only(top: 10,right: 20),
                                  child: AnyLinkPreview(
                                    link: messages[index].message!,
                                    errorBody: messages[index].message!,
                                    onTap: () async{
                                      if (await canLaunch(messages[index].message!,)) {
                                        await launch(messages[index].message!,);
                                      }
                                      else{
                                        //showCustomSnackBar("message");
                                      }
                                    },
                                  )
                                ):
                                Container(
                                  width: MediaQuery.of(context).size.width*0.8,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: KDullBlack
                                  ),
                                  padding: EdgeInsets.all(15),
                                  margin: EdgeInsets.only(top: 10,right: 20),
                                  child: Text(messages[index].message??'',style: proximaBold.copyWith(color: KWhite)),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 4.0,left: 10),
                                    child: Text(messages[index].time??'',style: proximaBold.copyWith(color: KWhite.withOpacity(0.5))),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ):
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.8,
                            child: Column(
                              children: [
                                messages[index].msgType=="attachment"?FullScreenWidget(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width*0.8,
                                    height: MediaQuery.of(context).size.height*0.25,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(messages[index].message??'',),
                                            fit: BoxFit.fill
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                        color: KDullBlack
                                    ),
                                    padding: EdgeInsets.all(15),
                                    margin: EdgeInsets.only(top: 10,left: 20),
                                  ),
                                ):
                                messages[index].msgType=="location"?
                                Container(
                                  width: MediaQuery.of(context).size.width*0.8,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: KdullWhite
                                  ),
                                  margin: EdgeInsets.only(top: 20,left: 20),
                                  child: AnyLinkPreview(
                                    link: messages[index].message!,
                                    errorBody: messages[index].message!,
                                    onTap: () async{
                                      if (await canLaunch(messages[index].message!,)) {
                                      await launch(messages[index].message!,);
                                      }
                                      else{
                                       // showCustomSnackBar("message");
                                      }
                                    },
                                  ),
                                ):
                                Container(
                                  width: MediaQuery.of(context).size.width*0.8,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: KdullWhite
                                  ),
                                  padding: EdgeInsets.all(15),
                                  margin: EdgeInsets.only(top: 20,left: 20),
                                  child: Text(messages[index].message??'',style: proximaBold.copyWith(color: KWhite)),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 4.0,right: 10),
                                    child: Text(messages[index].time??'',style: proximaBold.copyWith(color: KWhite.withOpacity(0.5))),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                // PopupMenuButton(
                //     shape: Border.all(width: 1,color: KdullWhite),
                //     padding: EdgeInsets.zero,
                //     color: KDullBlack,
                //     child: Container(
                //       height: 40,
                //       width: 40,
                //       decoration: const BoxDecoration(
                //           shape: BoxShape.circle,
                //           color: KDullBlack
                //       ),
                //       child: Center(child: SvgPicture.asset(Images.add,height: 15,width: 15,color: KBlue,)),
                //     ),
                //     itemBuilder: (context) => [
                //       PopupMenuItem(
                //         onTap: () async{
                //           pickedFile = await ImagePicker().getImage(source: ImageSource.gallery) as PickedFile ;
                //           uploadChatAttachment();
                //         },
                //         padding:const EdgeInsets.symmetric(vertical: 0,horizontal: 20),
                //         height:35,
                //         child: Row(
                //           children: [
                //             SvgPicture.asset(Images.photo),
                //             SizedBox(width: 10,),
                //             Text('Send Photos', style: proximaBold.copyWith(color: KWhite),),
                //           ],
                //         ),
                //       ),
                //       PopupMenuItem(
                //         onTap: sendLocation,
                //         padding:const EdgeInsets.symmetric(vertical: 0,horizontal: 20),
                //         height:35,
                //         child: Row(
                //           children: [
                //             SvgPicture.asset(Images.address,color: KBlue,height: 20,width: 20,),
                //             SizedBox(width: 13,),
                //             Text('Send Location', style: proximaBold.copyWith(color: KWhite),),
                //           ],
                //         ),
                //       ),
                //       PopupMenuItem(
                //         onTap: () => Get.to(SavedPhrase()),
                //         padding:const EdgeInsets.symmetric(vertical: 0,horizontal: 20),
                //         height:35,
                //         child: Row(
                //           children: [
                //             SvgPicture.asset(Images.chat,color: KBlue,),
                //             SizedBox(width: 10,),
                //             Text('Saved Phrases', style: proximaBold.copyWith(color: KWhite),),
                //           ],
                //         ),
                //       ),
                //     ]
                // ),
                InkWell(
                  onTap: () => Get.dialog(
                      Dialog(
                        backgroundColor: Colors.transparent,
                        insetPadding: EdgeInsets.only(left:15,bottom: 70,right: MediaQuery.of(context).size.width*0.22),
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          height: 200,
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          decoration: BoxDecoration(
                            color: KDullBlack,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: KDullBlack,width: 1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                  onTap: () async {
                                    Get.back();
                                    pickedFile = await ImagePicker().getImage(source: ImageSource.gallery) as PickedFile ;
                                    uploadChatAttachment();
                                  },
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(Images.photo,height: 30,width: 30,
                                      ),
                                      SizedBox(width: 10,),
                                      Text('Send Photos', style: proximaBold.copyWith(color: KWhite,fontSize: 20),),
                                    ],
                                  ),
                              ),
                              SizedBox(height: 17,),
                              InkWell(
                                  onTap: (){
                                    Get.back();
                                    sendLocation();
                                  },
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(Images.address,color: KBlue,height:30,width: 30,),
                                      SizedBox(width: 13,),
                                      Text('Send Location', style: proximaBold.copyWith(color: KWhite,fontSize: 20),),
                                    ],
                                  ),
                              ),
                              SizedBox(height: 17,),
                              InkWell(
                                  onTap: (){
                                    Get.back();
                                    Get.to(SavedPhrase(
                                      sendPhrase: (val){
                                        sendTextMessage(fromPhrase: true,text: val);
                                      },
                                    ));                              },
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(Images.chat,color: KBlue,height: 30,width: 30,),
                                      SizedBox(width: 10,),
                                      Text('Saved Phrases', style: proximaBold.copyWith(color: KWhite,fontSize: 20),),
                                    ],
                                  ),
                              ),
                            ],
                          ),
                        ),
                      )
                  ),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: KDullBlack
                    ),
                    child: Center(child: SvgPicture.asset(Images.add,height: 15,width: 15,color: KBlue,)),
                  )
                ),
                SizedBox(width: 10,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 50,
                  width: MediaQuery.of(context).size.width*0.75,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: KDullBlack
                  ),
                  child: TextField(
                    controller: messageController,
                    style: TextStyle(color: KWhite),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Write message here...",
                      hintStyle: TextStyle(color: KWhite),
                      suffixIcon:  GestureDetector(
                          onTap: (){
                            print('inside');

                            _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
                            sendTextMessage();
                            },
                          child: Container(
                              padding: EdgeInsets.only(left: 10,top: 10,bottom: 10),
                              height: 20,
                              child: SvgPicture.asset('assets/images/send.svg'))
                      ),
                    ),
                  ),
                ),
                // Expanded(
                //     child: MyTextField(
                //         controller: messageController,
                //       hintText: "Write message here...",
                //     )
                // ),
                SizedBox(width: 10,),

              ],
            ),
          ),
        ],
      ),
    );
  }
  void startChat() async {
    var response;
    response = await DioService.post('chat', {
      "userId": AppData().userdetail!.usersId.toString(),
      "otherUserId": widget.id.toString(),
      "requestType": "startChat"
    });
    if(response['status']=='success'){
      //showCustomSnackBar(response['data'],isError: false);
    }
    else{
      print(response['message']);
      //showCustomSnackBar(response['message']);
    }
  }
  void getMessages() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('chat', {
      "userId": AppData().userdetail!.usersId.toString(),
      "otherUserId": widget.id.toString(),
      "requestType": "getMessages"
    });
    if(response['status']=='success'){
      var jsonData= response['data'] as List;
      jsonData.forEach((e) => print(e['userId'].runtimeType));
      messages=jsonData.map((e) => ChatMessages.fromJson(e)).toList();
      setState(() {});

      //scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      Navigator.pop(context);
    }
    else{
      Navigator.pop(context);
      print(response['message']);
      showCustomSnackBar(response['message']);
    }
  }
  void sendTextMessage({bool fromPhrase=false,String text=""}) async {
    if(!fromPhrase&&messageController.text.trim().isEmpty) {
      showCustomSnackBar("Enter message");
    } else {
      //openLoadingDialog(context, "Loading");
      var response;
      response = await DioService.post('chat', {
        "userId": AppData().userdetail!.usersId.toString(),
        "otherUserId": widget.id.toString(),
        "messageType": "Text",
        "content": fromPhrase?text:messageController.text.trim().toString(),
        "requestType": "sendMessage"
      });
      if(response['status']=='success'){
        //Navigator.pop(context);
        message.userId=AppData().userdetail!.usersId.toString();
        message.name=AppData().userdetail!.userName;
        message.profilePicture=AppData().userdetail!.profilePicture;
        message.msgType="Text";
        message.message=fromPhrase?text:messageController.text.trim().toString();
        message.time=DateFormat.jm().format(DateTime.now());
        message.date="";
        messageController.clear();
       // _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
        messages.add(message);
        message=ChatMessages();
                setState(() {});
      }
      else{
        Navigator.pop(context);
        print(response['message']);
        showCustomSnackBar(response['message']);
      }
    }
  }
  void sendLocation() async {
    String url="https://www.google.com/maps/search/?api=1&query="
        "${AppData().userdetail!.latitude!},${AppData().userdetail!.longitude!}";
    print(url);
      //openLoadingDialog(context, "Loading");
      var response;
      response = await DioService.post('chat', {
        "userId": AppData().userdetail!.usersId.toString(),
        "otherUserId": widget.id.toString(),
        "messageType": "location",
        "content": url,
        "requestType": "sendMessage"
      });
      if(response['status']=='success'){
        message.userId=AppData().userdetail!.usersId.toString();
        message.name=AppData().userdetail!.userName;
        message.profilePicture=AppData().userdetail!.profilePicture;
        message.msgType="location";
        message.message=url;
        message.time=DateFormat.jm().format(DateTime.now());
        message.date="";
        messages.add(message);
        message=ChatMessages();
        //scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.easeOut);

        setState(() {});
        //Navigator.pop(context);
      }
      else{
        Navigator.pop(context);
        print(response['message']);
        //showCustomSnackBar(response['message']);
      }
  }
  void updateMessages() async {
    var response;
    response = await DioService.post('chat', {
      "userId": AppData().userdetail!.usersId.toString(),
      "otherUserId": widget.id.toString(),
      "requestType": "updateMessages"
    });
    if(response['status']=='success'){
      var jsonData= response['data'];
      updatedMessages=UpdatedMessages.fromJson(jsonData);
      updatedMessages.unreadMessages!.map((e) => messages.add(e)).toList();
      //scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      setState(() {});
    }
    else{
      print(response['message']);
    }
  }

  Future<void> uploadChatAttachment() async {

    FormData data=FormData.fromMap({
      'attachment': await MultipartFile.fromFile(pickedFile.path)
    });

    //openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('upload_chat_attachment', data);
    if(response['status']=='success'){
      image=response['data'];
      //Navigator.pop(context);
      //scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      sendPhoto();
      //showCustomSnackBar(response['data']);
    }
    else{
      Navigator.pop(context);
      showCustomSnackBar(response['message']);

    }
  }
  void sendPhoto() async {
    //openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('chat', {
      "userId": AppData().userdetail!.usersId.toString(),
      "otherUserId": widget.id.toString(),
      "messageType": "attachment",
      "content": image,
      "requestType": "sendMessage"
    });
    print(response);
    if(response['status']=='success'){
      message.userId=AppData().userdetail!.usersId.toString();
      message.name=AppData().userdetail!.userName;
      message.profilePicture=AppData().userdetail!.profilePicture;
      message.msgType="attachment";
      message.message=response['data']['message'];
      message.time=DateFormat.jm().format(DateTime.now());
      message.date="";
      messages.add(message);
      message=ChatMessages();
      image="";
      //scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      setState(() {});
      //Navigator.pop(context);
    }
    else{
      Navigator.pop(context);
      print(response['message']);
      showCustomSnackBar(response['message']);
    }
  }
  void blockUser() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('block_user', {
      "blockedByUserId":AppData().userdetail!.usersId.toString(),
      "blockedUserId":widget.id.toString()
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
      "reportedToUserId":widget.id.toString(),
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
