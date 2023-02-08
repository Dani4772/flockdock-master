import 'package:flocdock/Models/profileModel/profile_model.dart';
import 'package:flocdock/View/Widgets/my_button.dart';
import 'package:flocdock/View/Widgets/my_spacing.dart';
import 'package:flocdock/View/Widgets/my_text.dart';
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

class GalleryPermission extends StatefulWidget {
  const GalleryPermission({Key? key}) : super(key: key);

  @override
  State<GalleryPermission> createState() => _GalleryPermissionState();
}

class _GalleryPermissionState extends State<GalleryPermission> with TickerProviderStateMixin {

  TabController? _tabController;
  List<UserDetail> allowedUserDetail=[];
  List<UserDetail> deniedUserDetail=[];
  List<int> denyList=[];
  List<int> allowList=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    _tabController!.addListener(handle);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getAllowedMembers();
    });
  }
  void handle(){
    allowList.clear();
    denyList.clear();
    _tabController!.index==0?getAllowedMembers():getDeniedMembers();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KbgBlack,
      appBar: SimpleAppbar(description: "", pageName: "Gallery Permission",pageTrailing: "",),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(left: 20,right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text("Cancel",style: proximaBold.copyWith(color: KWhite)),
                    ),
                  ),
                  Expanded(child: Container()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyButton(
                      text: _tabController!.index==1?"Allow":"Deny",
                      textColor: KWhite,
                      buttonColor: KDullBlack,
                      buttonHight: 40.0,
                      buttonWidth: 100.0,
                      onPressed: () => _tabController!.index==1?allowPermissionToUsers():denyPermissionToUsers(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyButton(
                      text: _tabController!.index==1?"Allow All":"Deny All",
                      textColor: KWhite,
                      buttonColor: KBlue,
                      buttonHight: 40.0,
                      buttonWidth: 100.0,
                      onPressed: (){
                        if(_tabController!.index==1){
                          allowList.clear();
                          deniedUserDetail.map((e) => allowList.add(e.usersId!)).toList();
                          allowPermissionToUsers();
                        }
                        else{
                          denyList.clear();
                          allowedUserDetail.map((e) => denyList.add(e.usersId!)).toList();
                          denyPermissionToUsers();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: KDullBlack,
              child: TabBar(
                controller: _tabController,
                indicatorColor: KBlue,
                indicatorWeight: 5,
                labelColor: KWhite,
                unselectedLabelColor:KdullWhite,
                tabs: [
                  Tab(text: 'Allowed'),
                  Tab(text: 'Denied'),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.9,
              height: 300,
              padding: EdgeInsets.only(top: 10),
              child: TabBarView(
                controller: _tabController,
                children: [
                  GridView.builder(
                      gridDelegate:
                      const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 120,
                          crossAxisSpacing: 13,
                          mainAxisSpacing: 13
                      ),
                      itemCount: allowedUserDetail.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return InkWell(
                          onTap: (){
                            if(denyList.contains(allowedUserDetail[index].usersId))
                              denyList.remove(allowedUserDetail[index].usersId);
                            else
                              denyList.add(allowedUserDetail[index].usersId!);
                            setState(() {});
                          },
                          child: ProfileContainer(
                              img: allowedUserDetail[index].profilePicture??AppConstants.placeholder,
                              profileName: allowedUserDetail[index].userName??'',
                              isSelected: denyList.contains(allowedUserDetail[index].usersId)
                          ),
                        );
                      }),
                  GridView.builder(
                      gridDelegate:
                      const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 120,
                          crossAxisSpacing: 13,
                          mainAxisSpacing: 13
                      ),
                      itemCount: deniedUserDetail.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return InkWell(
                          onTap: (){
                            if(allowList.contains(deniedUserDetail[index].usersId))
                              allowList.remove(deniedUserDetail[index].usersId);
                            else
                              allowList.add(deniedUserDetail[index].usersId!);
                            setState(() {});
                          },
                          child: ProfileContainer(
                              img: deniedUserDetail[index].profilePicture??AppConstants.placeholder,
                              profileName: deniedUserDetail[index].userName??'',
                              isSelected: allowList.contains(deniedUserDetail[index].usersId)
                          ),
                        );
                      }),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
  void getAllowedMembers() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('get_gallery_permission_members', {
      "usersId" : AppData().userdetail!.usersId,
      "permissionType" : "Allowed"
    });
    if(response['status']=='success'){
      var jsonData= response['data'] as List;
      allowedUserDetail=jsonData.map((e) => UserDetail.fromJson(e)).toList();
      Navigator.pop(context);
      setState(() {});
    }
    else{
      Navigator.pop(context);
      print(response['message']);
      showCustomSnackBar(response['message']);
    }

  }
  void getDeniedMembers() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('get_gallery_permission_members', {
      "usersId" : AppData().userdetail!.usersId,
      "permissionType" : "Denied"
    });
    if(response['status']=='success'){
      var jsonData= response['data'] as List;
      deniedUserDetail=jsonData.map((e) => UserDetail.fromJson(e)).toList();
      Navigator.pop(context);
      setState(() {});
    }
    else{
      Navigator.pop(context);
      print(response['message']);
      showCustomSnackBar(response['message']);
    }

  }

  void allowPermissionToUsers() async {
    print("Allow");
    print(allowList.toList());
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('allow_permission_to_users', {
      "usersId" : AppData().userdetail!.usersId,
      "allowingUserIds" : allowList
    });
    if(response['status']=='success'){
      showCustomSnackBar(response['data']);
      Navigator.pop(context);
      deniedUserDetail.removeWhere((element) => allowList.contains(element.usersId));
      allowList.clear();
      setState(() {});
    }
    else{
      Navigator.pop(context);
      print(response['message']);
      showCustomSnackBar(response['message']);
    }

  }
  void denyPermissionToUsers() async {
    print("Deny");
    print(denyList.toList());
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('deny_permission_to_users', {
      "usersId" : AppData().userdetail!.usersId,
      "denyingUserIds" : denyList
    });
    if(response['status']=='success'){
      showCustomSnackBar(response['data']);
      Navigator.pop(context);
      allowedUserDetail.removeWhere((element) => denyList.contains(element.usersId));
      denyList.clear();
      setState(() {});
    }
    else{
      Navigator.pop(context);
      print(response['message']);
      showCustomSnackBar(response['message']);
    }

  }
}
Widget ProfileContainer({required String img,required String profileName,
   required bool isSelected,}){
  return Stack(children: <Widget>[
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            img.isNotEmpty?img:"https://th.bing.com/th/id/R.3e77a1db6bb25f0feb27c95e05a7bc57?rik=DswMYVRRQEHbjQ&riu=http%3a%2f%2fwww.coalitionrc.com%2fwp-content%2fuploads%2f2017%2f01%2fplaceholder.jpg&ehk=AbGRPPcgHhziWn1sygs8UIL6XIb1HLfHjgPyljdQrDY%3d&risl=&pid=ImgRaw&r=0",
          ),
        ),
      ),
    ),
    Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.7),
                Colors.grey.withOpacity(0.0),
              ],
              stops: [
                0.0,
                1.0
              ])),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.center,
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            MyText(
              text: profileName,
              size: 14,
              weight: FontWeight.w800,
              color: KWhite,
              fontFamily: "Proxima",
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                Container(
                  height: 18,
                  width: 18,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected?KBlue:null,
                      border: Border.all(width:2,color: KWhite)
                  ),
                  child: Center(child: isSelected?Icon(Icons.check,color: KWhite,size: 12,):SizedBox()),
                )
              ],
            )
          ],
        ),
      ),
    )
  ]);
}

