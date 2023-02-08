import 'package:dio/dio.dart';
import 'package:flocdock/View/Screens/create_event/choose_category.dart';
import 'package:flocdock/View/Screens/create_event/event_end.dart';
import 'package:flocdock/View/Screens/group/group_view.dart';
import 'package:flocdock/View/Screens/menu/drawer.dart';
import 'package:flocdock/View/Screens/profile/profile_view.dart';
import 'package:flocdock/View/Widgets/advertisement_container.dart';
import 'package:flocdock/View/Widgets/my_spacing.dart';
import 'package:flocdock/View/Widgets/my_text.dart';
import 'package:flocdock/View/base/bottom_navbar.dart';
import 'package:flocdock/View/base/custom_appbar.dart';
import 'package:flocdock/View/base/custom_snackbar.dart';
import 'package:flocdock/View/base/filter_dialog.dart';
import 'package:flocdock/View/base/loading_dialog.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flocdock/mixin/data.dart';
import 'package:flocdock/models/groupModel/event_model.dart';
import 'package:flocdock/models/profile&Group/profile_group_model.dart';
import 'package:flocdock/models/user_model/signup_model.dart';
import 'package:flocdock/services/dio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flocdock/View/Widgets/profile_widget.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isProfile = true;
  bool isGroup = false;
  bool isSearch =false;
  TextEditingController searchController=TextEditingController();
  List<ProfileGroupDetail>? profileGroup=[];
  List<GroupData>? groupData=[];
  List<UserDetail>? userData=[];
  List<UserDetail>? endedGroupMembers=[];
  Position? position;
  String address="";
  EventDetail filterDetail=EventDetail(categories: [],tribes: [],features: [],rules: [],cover: "Free Admittance",date: "",address: "");


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getPosition();
      getUsers();
      getGroups();
      endedGroupMembersList();
    });

  }


  Future<void> getPosition() async {
    position= await _determinePosition();
    await updateLocation();
    await convertToAddress(position!.latitude, position!.longitude, AppConstants.apiKey);

  }
  convertToAddress(double lat, double long, String apikey) async {
    Dio dio = Dio();  //initilize dio package
    String apiurl = "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=$apikey";
    var response = await dio.get(apiurl); //send get request to API URL
    if(response.statusCode == 200){ //if connection is successful
      Map data = response.data; //get response data
      if(data["status"] == "OK"){ //if status is "OK" returned from REST API
        if(data["results"].length > 0){ //if there is atleast one address
          Map firstresult = data["results"][0]; //select the first address
          String location="";
          location = firstresult["formatted_address"];
          List<String> list=location.split(',');
          address="";
          for(int i=0;i<list.length;i++) {
            if(i!=0) {
              address=address + list[i]+"," ;
            }
          }
        }
      }
    }
  }
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        backgroundColor: KbgBlack,
        drawer: MyDrawer(),
        appBar: CustomAppbar(pageName: 'Docks', description: "Nearby Groups & Profiles",
          onTap: () => Get.to(() => ChooseCategory()),
          isFilter: true,
          onTapFilter: () => Get.dialog(FilterDialog(
            filterDetail: filterDetail,
            applyFilter: (val){
              filterDetail=val;
              print(filterDetail.toJson());
              Get.back();
              getFilteredGroups();
            },
            cancelFilter: () => Get.back(),
          )
          ),
        ),
        bottomNavigationBar: BottomBar(),
        body: Padding(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          child: Column(
            children: [
              isSearch?Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 49,
                    margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_DEFAULT),
                    width: MediaQuery.of(context).size.width*0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: TextField(
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      onChanged: (value) async {
                        if(value!=""){
                          searchUserGroups();
                        }
                        //print(_autoCompleteResult.first.mainText);
                      },
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
                        hintStyle: proximaBold.copyWith(color: KWhite.withOpacity(0.5),fontSize: 16),
                        fillColor: Color.fromARGB(1,65, 68, 82,).withOpacity(0.9),
                        filled: true,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(bottom: 6.0),
                          child: Icon(Icons.search,size: 24,color: KWhite.withOpacity(0.5)),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      print("AppLifecycleState.paused");
                      print(AppLifecycleState.paused.index);
                      print(AppLifecycleState.paused.name);
                      print("AppLifecycleState.detached");
                      print(AppLifecycleState.detached.index);
                      print(AppLifecycleState.detached.name);
                      print("AppLifecycleState.inactive");
                      print(AppLifecycleState.inactive.index);
                      print(AppLifecycleState.inactive.name);
                      print("AppLifecycleState.resumed");
                      print(AppLifecycleState.resumed.index);
                      print(AppLifecycleState.resumed.name);

                      setState(() {
                        searchController.clear();
                        isSearch=!isSearch;
                      });
                    },
                    child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          padding: EdgeInsets.only(bottom: 15),
                            child: Icon(Icons.close,color: KWhite,)
                        )
                    ),
                  )
                ],
              ):SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlutterSwitch(
                    height: 20.0,
                    width: 38.0,
                    padding: 1.0,
                    inactiveToggleColor: KDullBlack,
                    activeToggleColor: KBlue,
                    toggleSize: 20.0,
                    inactiveColor: KdullWhite,
                    activeColor: KdullWhite,
                    value: isProfile,
                    onToggle: (value) {
                      isProfile=value;
                      if(isProfile&&isGroup)
                        getProfileGroups();
                      else if(isProfile)
                        getUsers();
                      else if(!isGroup) {
                        isGroup=true;
                        getGroups();
                      }
                      else
                        setState(() {});
                    },
                  ),
                  spaceHorizontal(5),
                  MyText(
                    text: "SHOW PROFILES",
                    color: KdullWhite,
                    size: 12,
                    weight: FontWeight.w700,
                    fontFamily: "Proxima",
                  ),
                  spaceHorizontal(20),
                  FlutterSwitch(
                    height: 20.0,
                    width: 38.0,
                    padding: 1.0,
                    inactiveToggleColor: KDullBlack,
                    activeToggleColor: KBlue,
                    toggleSize: 20.0,
                    inactiveColor: KdullWhite,
                    activeColor: KdullWhite,
                    value: isGroup,
                    onToggle: (value) {
                      isGroup = value;
                      if(isProfile&&isGroup)
                        getProfileGroups();
                      else if(isGroup)
                        getGroups();
                      else if(!isProfile) {
                        isProfile=true;
                        getUsers();
                      }
                      else
                        setState(() {});
                    },
                  ),
                  spaceHorizontal(5),
                  MyText(
                    text: "SHOW GROUPS",
                    color: KdullWhite,
                    size: 12,
                    weight: FontWeight.w700,
                    fontFamily: "Proxima",
                  ),
                  isSearch?SizedBox():Expanded(
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          isSearch=!isSearch;
                        });
                      },
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: SvgPicture.asset(Images.search)
                      ),
                    ),
                  )
                ],
              ),
              spaceVertical(28),
              isSearch == true || isGroup == true && isProfile == true
                  ? Expanded(
                    child: SingleChildScrollView(
                      child: Wrap(
                        children: [
                          StaggeredGrid.count(
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            crossAxisCount: 3,
                            children: [
                              for(int i=0;i<profileGroup!.length;i++)
                                profileGroup![i].objectType=="Group"?
                                StaggeredGridTile.count(
                                  crossAxisCellCount: 2,
                                  mainAxisCellCount: 1,
                                  child: GestureDetector(
                                    onTap: () => Get.to(GroupView(groupId: profileGroup![i].groupId)),
                                    child: GroupWidget(
                                      img: profileGroup![i].picture??'',
                                      groupName: profileGroup![i].name??'',
                                      distance: profileGroup![i].distanceAway!.toPrecision(2).toString(),
                                      groupMembers: profileGroup![i].totalActiveMembers.toString(),
                                    ),
                                  ),
                                ):
                                StaggeredGridTile.count(
                                    crossAxisCellCount: 1,
                                    mainAxisCellCount: 1,
                                    child: GestureDetector(
                                      onTap: () => Get.to(ProfileView(userId: profileGroup![i].usersId)),
                                      child: ProfileWidget(
                                          img: profileGroup![i].picture??'',
                                          profileName: profileGroup![i].name??'',
                                          distance: profileGroup![i].distanceAway!.toPrecision(2).toString(),
                                        isOnline: profileGroup![i].isOnline
                                      ),
                                    )
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                  : isProfile == true
                  ? Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    children: [
                      StaggeredGrid.count(
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        crossAxisCount: 3,
                        children: [
                          for(int index=0;index<userData!.length;index++)
                            StaggeredGridTile.count(
                                crossAxisCellCount: 1,
                                mainAxisCellCount: 1,
                                child: GestureDetector(
                                  onTap: () => Get.to(ProfileView(userId: userData![index].usersId)),
                                  child: ProfileWidget(
                                      img: userData![index].profilePicture??AppConstants.placeholder,
                                      profileName: userData![index].userName??'',
                                      distance: userData![index].distanceAway.toPrecision(2).toString(),
                                      isOnline: userData![index].isOnline
                                  ),
                                )
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
                  : isGroup == true?
                  Expanded(
                    child: GridView.builder(
                      physics: BouncingScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 4 / 2,
                            crossAxisSpacing: 13,
                            mainAxisSpacing: 13,
                        ),
                        itemCount: groupData!.length,
                        itemBuilder: (BuildContext ctx, index){
                          return GestureDetector(
                            onTap: () => Get.to(GroupView(groupId: groupData![index].groupId,)),
                            child: GroupWidget(
                                img: groupData![index].coverPhoto!,
                                groupName: groupData![index].category!.category!,
                                distance: groupData![index].distanceAway!.toPrecision(2).toString(),
                                groupMembers: groupData![index].totalAttendees.toString(),
                            ),
                          );
                        }
                    ),
                  ): Expanded(child: Container()),

              // Expanded(
              //   child: GridView.builder(
              //       gridDelegate:
              //       const SliverGridDelegateWithMaxCrossAxisExtent(
              //           maxCrossAxisExtent: 100,
              //           crossAxisSpacing: 13,
              //           mainAxisSpacing: 13
              //       ),
              //       itemCount: userData!.length,
              //       itemBuilder: (BuildContext ctx, index) {
              //         return GestureDetector(
              //           onTap: () => Get.to(ProfileView(userId: userData![index].usersId)),
              //           child: ProfileWidget(
              //               img: userData![index].profilePicture??AppConstants.placeholder,
              //               profileName: userData![index].userName??'',
              //               distance: userData![index].distanceAway.toPrecision(2).toString(),
              //               isOnline: userData![index].isOnline
              //           ),
              //         );
              //       }),
              // ),
              AdvertisementContainer(context: context, height: isGroup && !isProfile? 65 : 90)

            ],
          ),
        ),
      ),
    );
  }

  void endedGroupMembersList() async {

    print("endedGroupMembersList");
    print(AppData().userdetail!.usersId);
    print(AppData().userdetail!.latitude);
    print(AppData().userdetail!.longitude);
    var response;
    openLoadingDialog(context, "Loading");
    response = await DioService.post('ended_group_members', {
      "userId": AppData().userdetail!.usersId,
      "userLat": AppData().userdetail!.latitude.toString(),
      "userLong": AppData().userdetail!.longitude.toString()
    });
    print("response----0-------- ${response}");
    if(response['status']=='success'){

      var jsonData= response['data'] as List;
      endedGroupMembers=jsonData.map((e) => UserDetail.fromJson(e)).toList();
      endedGroupMembers!.isNotEmpty?Get.to(() =>EventEnd(endedGroupMembers: endedGroupMembers,)):null;

      Navigator.pop(context);
      Navigator.pop(context);
    }
    else{
      Navigator.pop(context);

      print(response['message']);
      //showCustomSnackBar(response['message']);
    }
  }

  Future updateLocation() async {
    print("position!.latitude");
    AppData().userdetail!.latitude=position!.latitude;
    AppData().userdetail!.longitude=position!.longitude;
    print(AppData().userdetail!.latitude);
    print(AppData().userdetail!.longitude);
    AppData().update();
    var response;
    response = await DioService.post('update_user_location', {
      "usersId" : AppData().userdetail!.usersId,
      "userLat" : position!.latitude,
      "userLong" : position!.longitude
    });
    if(response['status']=='success'){
      print(response['data']);
    }
    else{
      print(response['message']);
      showCustomSnackBar(response['message']);
    }

  }

  void getUsers() async {

    print("AppData().userdetail!.latitude");
    print(AppData().userdetail!.usersId);
    print(AppData().userdetail!.latitude);
    print(AppData().userdetail!.longitude);
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('nearby_users', {
      "usersId":AppData().userdetail!.usersId,
      "userLat":AppData().userdetail!.latitude.toString(),
      "userLong":AppData().userdetail!.longitude.toString(),
    });
    if(response['status']=='success'){
      var jsonData= response['data'] as List;
      userData=jsonData.map((e) => UserDetail.fromJson(e)).toList();
      Navigator.pop(context);
      setState(() {});
    }
    else{
      Navigator.pop(context);
      print(response['message']);
      showCustomSnackBar(response['message']);
    }

  }
  void getGroups() async {
    print("AppData().userdetail!.latitude");
    print(AppData().userdetail!.latitude);
    print(AppData().userdetail!.longitude);
      openLoadingDialog(context, "Loading");
      var response;
      response = await DioService.post('get_all_groups', {
        "usersId":AppData().userdetail!.usersId,
        "userLat":AppData().userdetail!.latitude.toString(),
        "userLong":AppData().userdetail!.longitude.toString(),
      });
      if(response['status']=='success'){
        var jsonData= response['data'] as List;
        groupData=jsonData.map((e) => GroupData.fromJson(e)).toList();
        Navigator.pop(context);
        setState(() {});
      }
      else{
        Navigator.pop(context);
        print(response['message']);
        showCustomSnackBar(response['message']);
      }

    }

  void getProfileGroups() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('get_both_user_groups', {
      "usersId":AppData().userdetail!.usersId,
      "userLat":AppData().userdetail!.latitude.toString(),
      "userLong":AppData().userdetail!.longitude.toString(),
    });
    if(response['status']=='success'){
      var jsonData= response['data'] as List;
      profileGroup=jsonData.map((e) => ProfileGroupDetail.fromJson(e)).toList();
      Navigator.pop(context);
      setState(() {});
    }
    else{
      Navigator.pop(context);
      print(response['message']);
      showCustomSnackBar(response['message']);
    }

  }

  void searchUserGroups() async {
    //openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('search_user_groups', {
      "usersId":AppData().userdetail!.usersId.toString(),
      "userLat":AppData().userdetail!.latitude.toString(),
      "userLong":AppData().userdetail!.longitude.toString(),
      "searchFilter":searchController.text.toString()
    });
    if(response['status']=='success'){
      var jsonData= response['data'] as List;
      profileGroup=jsonData.map((e) => ProfileGroupDetail.fromJson(e)).toList();
      //Navigator.pop(context);
      setState(() {});
    }
    else{
      //Navigator.pop(context);
      print(response['message']);
      showCustomSnackBar(response['message']);
    }

  }

  void getFilteredGroups() async {
    print("AppData().userdetail!.latitude");
    print(AppData().userdetail!.latitude);
    print(AppData().userdetail!.longitude);
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('filtered_groups', {
      "usersId":AppData().userdetail!.usersId,
      "userLat":AppData().userdetail!.latitude.toString(),
      "userLong":AppData().userdetail!.longitude.toString(),
      if(filterDetail.date!.isNotEmpty)"dateFilter" : filterDetail.date,
      if(filterDetail.address!.isNotEmpty)"locationFilter" : filterDetail.address,
      if(filterDetail.categories!.isNotEmpty)"typeCategoryFilter" : filterDetail.categories,
      if(filterDetail.tribes!.isNotEmpty)"tribeFilter" : filterDetail.tribes,
      if(filterDetail.rules!.isNotEmpty)"importantRulesFilter" : filterDetail.rules,
      if(filterDetail.features!.isNotEmpty)"featuresFilter" : filterDetail.features,
      if(filterDetail.cover!.isNotEmpty)"coverFilter" : filterDetail.cover
    });
    if(response['status']=='success'){
      var jsonData= response['data'] as List;
      groupData=jsonData.map((e) => GroupData.fromJson(e)).toList();
      Navigator.pop(context);
      setState(() {});
    }
    else{
      Navigator.pop(context);
      print(response['message']);
      showCustomSnackBar(response['message']);
    }

  }

}
