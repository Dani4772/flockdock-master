import 'package:flocdock/View/Screens/inbox/widget/inbox_list.dart';
import 'package:flocdock/View/Screens/inbox/widget/slideactionmodel.dart';
import 'package:flocdock/View/Screens/inbox/widget/taps.dart';
import 'package:flocdock/View/Screens/menu/drawer.dart';
import 'package:flocdock/View/base/bottom_navbar.dart';
import 'package:flocdock/View/base/custom_appbar.dart';
import 'package:flocdock/View/base/custom_snackbar.dart';
import 'package:flocdock/View/base/loading_dialog.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flocdock/mixin/data.dart';
import 'package:flocdock/models/inbox/inbox_model.dart';
import 'package:flocdock/models/inbox/tap_model.dart';
import 'package:flocdock/services/dio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:dio/dio.dart';

class InboxPage extends StatefulWidget {

  @override
  _InboxPageState createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> with TickerProviderStateMixin {
  List<TapDetail> tapDetail=[];
  List<InboxDetail> inboxMessages=[];
  TabController? _tabController;
  Dio dio=Dio();
  // void Function()? onTapAccept;
  // void Function()? onTapIgnore;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getInboxList();
      getAllTaps();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KbgBlack,
      drawer: MyDrawer(),
      appBar: CustomAppbar(pageName: 'INBOX', description: "Messages & Notifications",pageTrailing: "",),
      bottomNavigationBar: BottomBar(pageIndex: 1,),
      body: Column(
        children: [
          Container(
            color: KDullBlack,
            child: TabBar(
              controller: _tabController,
              indicatorColor: KBlue,
              indicatorWeight: 5,
              labelColor: KWhite,
              unselectedLabelColor:KdullWhite,
              labelStyle: proximaBold.copyWith(fontSize: Dimensions.fontSizeSmall),
              tabs: [
                Tab(text: 'Messages & Notifications'),
                Tab(text: 'Taps'),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width*0.9,
              padding: EdgeInsets.only(top: 10),
              child: TabBarView(
                controller: _tabController,
                children: [
              RefreshIndicator(
                displacement: 250,
                backgroundColor: Colors.white,
                color: Colors.grey,
                strokeWidth: 3,
                triggerMode: RefreshIndicatorTriggerMode.onEdge,
                onRefresh: () async {
                  await Future.delayed(Duration(milliseconds: 1500));
                  setState(() {
                    getInboxList();
                  });
                },
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        //padding: EdgeInsetsGeometry.infinity,
                        itemCount: inboxMessages.length,
                        itemBuilder: (context,index){
                          return Column(
                            children: [
                              Slidable(

                                actionPane: SlidableScrollActionPane(),
                                secondaryActions: [
                                  IconSlideAction(
                                    caption: 'Delete',
                                    color: KbgBlack,
                                    icon: Icons.delete,
                                    foregroundColor: Colors.white,
                                    onTap: ()=>setState(() {
                                      print('into Messages Inbox');
                                      print('Notification ID : ');
                                      print(inboxMessages[index].notificationId);
                                      print('index id: ');
                                      print(index);
                                      deleteNotification(inboxMessages[index].notificationId.toString());
                                      inboxMessages.removeAt(index);
                                    } ),
                                  )],
                                child: InboxList(
                                  inboxDetail: inboxMessages[index],
                                  onTapAccept: () => inboxMessages[index].notificationType=="GroupJoinRequest"?acceptJoiningRequest(index):acceptInviteRequest(index),
                                  onTapIgnore: () => inboxMessages[index].notificationType=="GroupJoinRequest"?rejectJoiningRequest(index):rejectInviteRequest(index),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5.0),
                                child: Container(
                                  color: Colors.white.withOpacity(0.2),
                                  width: MediaQuery.of(context).size.width*0.9,
                                  height: 1,
                                ),
                              ),
                            ],

                          );

                        }
                    ),
                  ),
                   ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        //padding: EdgeInsetsGeometry.infinity,
                        itemCount: tapDetail.length,
                        itemBuilder: (context,index){
                          return Column(
                            children: [
                              Slidable(
                                actionPane: SlidableScrollActionPane(
                                ),
                                secondaryActions: [
                                  IconSlideAction(
                                    caption: 'Delete',
                                    color: KbgBlack,
                                    icon: Icons.delete,
                                    onTap: ()=>setState(() {
                                      tapDetail.removeAt(index);
                                      print('into Tab');
                                      print('Notification ID : ');
                                      deleteTaps(tapDetail[index].tapId.toString());
                                      print(tapDetail[index].tapId.toString());
                                      // print(tapDetail[index].userName);
                                      // print(tapDetail[index].tapId);
                                      // print('index id: ');
                                      // print(index);


                                    }  //
                                    ),)
                                    ],
                                  child:Tap(
                                    image: tapDetail[index].profilePicture??'',
                                    title: tapDetail[index].userName??'',
                                    time: tapDetail[index].formattedTime??'',
                                    isLive: tapDetail[index].isOnline,
                              ),),

                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5.0),
                                child: Container(
                                  color: Colors.white.withOpacity(0.2),
                                  width: MediaQuery.of(context).size.width*0.9,
                                  height: 1,
                                ),
                              ),
                            ],
                          );
                        }
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

  }

  void getAllTaps() async {
    var response;
    response = await DioService.post('get_all_taps', {
      "userId":AppData().userdetail!.usersId
    });
    if(response['status']=='success'){
      var jsonData= response['data'] as List;
      tapDetail=jsonData.map((e) => TapDetail.fromJson(e)).toList();
    }
    else{
      print(response['message']);
      //showCustomSnackBar(response['message']);
    }
  }

  void getInboxList() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('get_inbox_list', {
      "userId":AppData().userdetail!.usersId.toString()
    });
    print(response);
    if(response['status']=='success'){
      var jsonData= response['data'] as List;
      inboxMessages=jsonData.map((e) => InboxDetail.fromJson(e)).toList();
      Navigator.pop(context);
      setState(() {});
    }
    else{
      Navigator.pop(context);
      print(response['message']);
      //showCustomSnackBar(response['message']);
    }

  }

  void acceptJoiningRequest(int index) async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('accept_joining_request', {
        "joiningUserId" : AppData().userdetail!.usersId,
        "groupId" : inboxMessages[index].groupId,
        "notificationId": inboxMessages[index].notificationId
    });
    if(response['status']=='success'){
      showCustomSnackBar(response['data'],isError: false);
      Navigator.pop(context);
    }
    else{
      Navigator.pop(context);
      print(response['message']);
      showCustomSnackBar(response['message']);
    }
  }

  void rejectJoiningRequest(int index) async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('reject_joining_request', {
      "joiningUserId" : AppData().userdetail!.usersId.toString(),
      "groupId" : inboxMessages[index].groupId.toString(),
      "notificationId": inboxMessages[index].notificationId.toString()
    });
    if(response['status']=='success'){
      showCustomSnackBar(response['data'],isError: false);
      Navigator.pop(context);
    }
    else{
      Navigator.pop(context);
      print(response['message']);
      showCustomSnackBar(response['message']);
    }
  }
 // notifiction/{id}/delete
 //  Future<void> deleteUser(int index) async {
 //    try {
 //      var response;
 //      response = await DioService.post('notifiction/$id/delete', {
 //        id = index;
 //      });
 //      print('Notification Deleted!');
 //    } catch (e) {
 //      print('Error deleting user: $e');
 //    }
 //  }

  void deleteNotification(String id)async{
    print('Into the function');
    print(id);
    var response = await dio.delete('https://flockdock.eigix.net/api/notifiction/delete',
      data: {
        "notification_id" : id,
      },
    );
    if(response=='success'){

      print('Message Notification Deleted');
    }
    else{
      print('Error. Not Deleted');
    }
  }

  void deleteTaps(String id)async{
    print('Into the Tap function');
    print(id);
    var response = await dio.delete('https://flockdock.eigix.net/api/Taps/delete',
      data: {
        "tap_id" : id,
      },
    );
    if(response=='success'){

      print('Message Notification Deleted');
    }
    else{
      print('Error. Not Deleted');
    }
  }



  // void deleteNotification(String id) async {
  //   print('Into the function');
  //   print(id);
  //   var response;
  //   response = await .delete('notifiction/delete', {
  //     "notification_id" : id.toString(),
  //   });
  //   if(response['status']=='success'){
  //     print(response['data']);
  //     print('Message Notification Deleted');
  //   }
  //   else{
  //     print(response['message']);
  //     print('Error. Not Deleted');
  //   }
  // }


  //
  // void deletemsg( int index)

  void acceptInviteRequest(int index) async {
    print(inboxMessages[index].toJson());
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('accept_invite_request', {
      "invitedUserId" : AppData().userdetail!.usersId.toString(),
      "groupId" : inboxMessages[index].groupId.toString(),
      "notificationId": inboxMessages[index].notificationId.toString()
    });
    if(response['status']=='success'){
      showCustomSnackBar(response['data'],isError: false);
      print(response['data']);
      Navigator.pop(context);
    }
    else{
      Navigator.pop(context);
      print(response['message']);
      showCustomSnackBar(response['message']);
    }
  }

  void rejectInviteRequest(int index) async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('reject_invite_request', {
      "invitedUserId" : AppData().userdetail!.usersId.toString(),
      "groupId" : inboxMessages[index].groupId.toString(),
      "notificationId": inboxMessages[index].notificationId.toString()
    });
    print(response);
    if(response['status']=='success'){
      showCustomSnackBar(response['data'],isError: false);
      Navigator.pop(context);
    }
    else{
      Navigator.pop(context);
      print(response['message']);
      showCustomSnackBar(response['message']);
    }
  }
}

