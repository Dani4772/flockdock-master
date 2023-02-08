import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flocdock/View/Screens/group/group_view.dart';
import 'package:flocdock/View/Screens/menu/drawer.dart';
import 'package:flocdock/View/Screens/profile/profile_view.dart';
import 'package:flocdock/View/Widgets/advertisement_container.dart';
import 'package:flocdock/View/Widgets/profile_widget.dart';
import 'package:flocdock/View/base/bottom_navbar.dart';
import 'package:flocdock/View/base/custom_appbar.dart';
import 'package:flocdock/View/base/custom_snackbar.dart';
import 'package:flocdock/View/base/loading_dialog.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flocdock/mixin/data.dart';
import 'package:flocdock/models/profile&Group/profile_group_model.dart';
import 'package:flocdock/services/dio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places_service/places_service.dart';



class DiscoverPage extends StatefulWidget {

  DiscoverPage({Key? key,}) : super(key: key);



  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {













  Position? _currentPositions;
  Position position=Position(longitude: AppData().userdetail!.longitude??0, latitude: AppData().userdetail!.latitude??0,
      timestamp: DateTime.now(), accuracy: 1, altitude: 1, heading: 1, speed: 1, speedAccuracy: 1);
  bool isMap =false;

  LatLng? _currentPosition;
  TextEditingController searchController=TextEditingController();
  List<ProfileGroupDetail>? profileGroup=[];
  int users=0,groups=0;
  bool isSearch =false;
  bool isLoading =true;
  CameraPosition? cameraPosition;
  Set<Marker> markers = Set.of([]);
  late GoogleMapController mapController;
  PlacesService  placesService = PlacesService();
  List<PlacesAutoCompleteResult>  autoCompleteResult=[];
  Location currentLocation = Location();
  GoogleMapController? _controller;
  Set<Marker> _markers={};
  var postlati;
  var postlong;

  // on below line we have specified camera position
  static final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(30.2406, 71.4938),
    zoom: 10,
  );


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    placesService.initialize(apiKey: AppConstants.apiKey);
    //getLocation();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getDiscoverUserGroup();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KbgBlack,
      drawer: MyDrawer(),
      appBar: CustomAppbar(pageName: 'DISCOVER', description: "Global Online",pageTrailing: "",),
      bottomNavigationBar: BottomBar(pageIndex: 2,),
      body: Padding(
        padding:  EdgeInsets.all(isMap?0:Dimensions.PADDING_SIZE_DEFAULT),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Padding(
                  padding: isMap?EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT):EdgeInsets.only(bottom:Dimensions.PADDING_SIZE_DEFAULT),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width*0.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: TextField(
                          controller: searchController,
                          keyboardType: TextInputType.text,
                          onChanged: (value) async {
                            if(value==""){
                              autoCompleteResult.clear();
                              setState(() {});
                            }
                            else{
                              print(value);
                              final autoCompleteSuggestions = await placesService.getAutoComplete(value);
                              autoCompleteResult = autoCompleteSuggestions;
                              setState(() {});
                            }
                            //print(_autoCompleteResult.first.mainText);
                          },
                          cursorColor: KWhite,
                          style: proximaBold.copyWith(color: KWhite.withOpacity(0.5)),
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
                            hintStyle: proximaBold.copyWith(color: KWhite.withOpacity(0.7)),
                            fillColor: Color.fromARGB(1,65, 68, 82,).withOpacity(0.9),
                            filled: true,

                            prefixIcon: Icon(Icons.search,size: 22,color: KWhite.withOpacity(0.7))
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          isMap?getDiscoverUserGroup():usersGroupsCountInRadius();
                          isMap=!isMap;
                          setState(() {});
                        },
                        child: Column(
                          children: [
                            SizedBox(height: isMap? 7 : 1),
                            SvgPicture.asset(isMap?Images.listview:Images.map),
                            SizedBox(height: 5,),
                            Text(isMap?"List":"Map",style: proximaBold.copyWith(color: KWhite,fontSize: Dimensions.fontSizeSmall),),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                isMap?Expanded(
                  child: Stack(
                    children: [
                      // if (_currentPosition != null) Text(
                      //     "LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}"
                      // ),
                      GoogleMap(
                        markers: markers,

                        initialCameraPosition: //_kGoogle,
                        //_kGoogle, //getLocation(),
                        CameraPosition(
                          target:
                          LatLng(position.latitude,position.longitude),
                          zoom: 10,
                        ),


                        onMapCreated: (GoogleMapController mapController) {
                          this.mapController = mapController;
                          //getLocation();
                        },
                        zoomControlsEnabled: false,
                        onCameraMove: (CameraPosition cameraPosition) async {
                          this.cameraPosition=cameraPosition;
                          position=Position(longitude: cameraPosition.target.longitude, latitude: cameraPosition.target.latitude,
                              timestamp: DateTime.now(), accuracy: 1, altitude: 1, heading: 1, speed: 1, speedAccuracy: 1);
                          isLoading=true;
                          setMarker();
                          setMarker();
                          print("cameramove");
                        },
                        onCameraMoveStarted: () {

                        },
                        onCameraIdle: () async {
                          usersGroupsCountInRadius();
                          print("cameraIdle");
                          //plackmark= await placemarkFromCoordinates(_cameraPosition!.target.latitude, _cameraPosition!.target.longitude);
                          //address="${plackmark!.first.subLocality}${plackmark!.first.locality}";
                          //await convertToAddress(_cameraPosition!.target.latitude, _cameraPosition!.target.longitude, "AIzaSyBqdGZNfHhamM_6gbqPCDpJ7H44xEst37A");
                        },
                      ),

                    ],
                  ),
                ):

                Expanded(
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
                                child: InkWell(
                                  onTap: () => Get.to(GroupView(groupId: profileGroup![i].groupId,)),
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
                                  child: InkWell(
                                    onTap: () => Get.to(ProfileView(userId: profileGroup![i].usersId,)),
                                    child: ProfileWidget(
                                        img: profileGroup![i].picture??'',
                                        profileName: profileGroup![i].name??'',
                                        distance: profileGroup![i].distanceAway!.toPrecision(2).toString(),
                                        isOnline: profileGroup![i].isOnline
                                    ),
                                  )
                              ),

                            // StaggeredGridTile.count(
                            //     crossAxisCellCount: 1,
                            //     mainAxisCellCount: 1,
                            //     child: ProfileWidget(
                            //         img: profileDummyData[0].Img,
                            //         profileName: profileDummyData[0].profileName,
                            //         distance: profileDummyData[0].distance,
                            //         col: profileDummyData[0].col
                            //     )
                            // ),
                            // StaggeredGridTile.count(
                            //   crossAxisCellCount: 2,
                            //   mainAxisCellCount: 1,
                            //   child: GroupContainer(
                            //       img: groupDummyData[0].img,
                            //       groupName: groupDummyData[0].groupName,
                            //       distance: groupDummyData[0].distance,
                            //       groupMembers: groupDummyData[0].groupMember,
                            //     index: 1
                            //   ),
                            // ),
                            // StaggeredGridTile.count(
                            //     crossAxisCellCount: 1,
                            //     mainAxisCellCount: 1,
                            //     child: ProfileWidget(
                            //         img: profileDummyData[0].Img,
                            //         profileName: profileDummyData[0].profileName,
                            //         distance: profileDummyData[0].distance,
                            //         col: profileDummyData[0].col
                            //     )
                            // ),
                            // StaggeredGridTile.count(
                            //     crossAxisCellCount: 1,
                            //     mainAxisCellCount: 1,
                            //     child: ProfileWidget(
                            //         img: profileDummyData[0].Img,
                            //         profileName: profileDummyData[0].profileName,
                            //         distance: profileDummyData[0].distance,
                            //         col: profileDummyData[0].col
                            //     )
                            // ),
                            // StaggeredGridTile.count(
                            //     crossAxisCellCount: 1,
                            //     mainAxisCellCount: 1,
                            //     child: ProfileWidget(
                            //         img: profileDummyData[0].Img,
                            //         profileName: profileDummyData[0].profileName,
                            //         distance: profileDummyData[0].distance,
                            //         col: profileDummyData[0].col
                            //     )
                            // ),
                            // StaggeredGridTile.count(
                            //     crossAxisCellCount: 1,
                            //     mainAxisCellCount: 1,
                            //     child: ProfileWidget(
                            //         img: profileDummyData[0].Img,
                            //         profileName: profileDummyData[0].profileName,
                            //         distance: profileDummyData[0].distance,
                            //         col: profileDummyData[0].col
                            //     )
                            // ),
                            // StaggeredGridTile.count(
                            //     crossAxisCellCount: 1,
                            //     mainAxisCellCount: 1,
                            //     child: ProfileWidget(
                            //         img: profileDummyData[0].Img,
                            //         profileName: profileDummyData[0].profileName,
                            //         distance: profileDummyData[0].distance,
                            //         col: profileDummyData[0].col
                            //     )
                            // ),
                            // StaggeredGridTile.count(
                            //     crossAxisCellCount: 1,
                            //     mainAxisCellCount: 1,
                            //     child: ProfileWidget(
                            //         img: profileDummyData[0].Img,
                            //         profileName: profileDummyData[0].profileName,
                            //         distance: profileDummyData[0].distance,
                            //         col: profileDummyData[0].col
                            //     )
                            // ),
                            // StaggeredGridTile.count(
                            //     crossAxisCellCount: 1,
                            //     mainAxisCellCount: 1,
                            //     child: ProfileWidget(
                            //         img: profileDummyData[0].Img,
                            //         profileName: profileDummyData[0].profileName,
                            //         distance: profileDummyData[0].distance,
                            //         col: profileDummyData[0].col
                            //     )
                            // ),
                            // StaggeredGridTile.count(
                            //   crossAxisCellCount: 2,
                            //   mainAxisCellCount: 1,
                            //   child: GroupContainer(
                            //       img: groupDummyData[0].img,
                            //       groupName: groupDummyData[0].groupName,
                            //       distance: groupDummyData[0].distance,
                            //       groupMembers: groupDummyData[0].groupMember,
                            //     index: 1
                            //   ),
                            // ),
                          ],
                        ),
                        //             StaggeredGrid.count(
                        //               mainAxisSpacing: 4,
                        //               crossAxisSpacing: 4,
                        //               crossAxisCount: 3,
                        //               children: [
                        //                 for(int index=0;index<6;index++)
                        //                   mixDummyData[index].isProfile?
                        //                     StaggeredGridTile.count(
                        //                         crossAxisCellCount: 1,
                        //                         mainAxisCellCount: 1,
                        //                         child: ProfileContainer(
                        //                             img: profileDummyData[index].Img,
                        //                             profileName: profileDummyData[index].profileName,
                        //                             distance: profileDummyData[index].distance,
                        //                             col: profileDummyData[index].col
                        //                         )
                        //                     ):
                        //                     StaggeredGridTile.count(
                        //                       crossAxisCellCount: 2,
                        //                       mainAxisCellCount: 1,
                        //                       child: GroupContainer(
                        //                           img: groupDummyData[index].img,
                        //                           groupName: groupDummyData[index].groupName,
                        //                           distance: groupDummyData[index].distance,
                        //                           groupMembers: groupDummyData[index].groupMember),
                        //                     )
                        //               ],
                        // ),
                      ],
                    ),
                  ),
                ),
                if(!isMap)AdvertisementContainer(context: context),

              ],
            ),
            if (autoCompleteResult.isNotEmpty)
              Padding(
                padding:  EdgeInsets.only(top: isMap?70:50),
                child: Container(
                  width: MediaQuery.of(context).size.width*0.9,
                  decoration: const BoxDecoration(
                    color: KDullBlack,
                    //: Border.all(color: Colors.black)
                  ),
                  height: 160,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: autoCompleteResult.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 30,
                        child: ListTile(
                          minVerticalPadding: 0,
                          title: Text(autoCompleteResult[index].mainText ?? "",style: proximaBold.copyWith(color: KWhite),),
                          onTap: () async {
                            FocusScope.of(context).unfocus();
                            var id = autoCompleteResult[index].placeId;
                            final placeDetails = await placesService.getPlaceDetails(id!);
                            print(placeDetails);
                            searchController.text=autoCompleteResult[index].mainText??'';
                            position=Position(longitude: placeDetails.lng??0, latitude: placeDetails.lat??0,timestamp: DateTime.now(),
                                accuracy: 1, altitude: 1, heading: 1, speed: 1, speedAccuracy: 1);
                            isMap=true;
                            autoCompleteResult.clear();
                            isLoading=true;
                            setMarker();
                            usersGroupsCountInRadius();
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            if(isMap)Positioned(
              top: 277,
              child: Container(
                height: 100,
                width: 100,
                child: Column(
                  children: [
                    // SizedBox(height: 18,),
                    Container(
                      width: 60,
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(Images.multi_users,color: KBlue,width: 15,height: 15,),
                          SizedBox(width: 5,),
                          isLoading?
                          SizedBox(height:12,width:12,child: CircularProgressIndicator(color: KBlue,strokeWidth: 2,)):
                          Text("$groups+",style: proximaBold,),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      width: 60,
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(Images.single_user,color: KBlue,width: 15,height: 15,),
                          SizedBox(width: 5,),
                          isLoading?
                          SizedBox(height:12,width:12,child: CircularProgressIndicator(color: KBlue,strokeWidth: 2,)):
                          Text("$users+",style: proximaBold,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }



  void getDiscoverUserGroup() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('get_discovered_user_groups', {
      "usersId":AppData().userdetail!.usersId.toString(),
      "latitude":position.latitude.toString(),
      "longitude":position.longitude.toString()
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
  void usersGroupsCountInRadius() async {
    //openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('users_groups_count_in_radius', {
      "latitude":position.latitude.toString(),
      "longitude":position.longitude.toString()
    });
    if(response['status']=='success'){
      users=response['data']['users_count'];
      groups=response['data']['groups_count'];
      //Navigator.pop(context);
      isLoading=false;
      setMarker();
    }
    else{
      //Navigator.pop(context);
      print(response['message']);
      showCustomSnackBar(response['message']);
    }

  }
  void setMarker() async {
    Uint8List destinationImageData = await convertAssetToUnit8List(
      Images.marker,
    );
    markers.clear();
    markers.add(Marker(
      markerId: const MarkerId('marker'),
      position: LatLng(position.latitude-0.035,position.longitude),
      icon: BitmapDescriptor.fromBytes(destinationImageData),
    ));
    setState(() {});
  }
  setAllMarker(double latitude, double longitude,String name,String display) async {
    //plackmark= await placemarkFromCoordinates(position.latitude, position.longitude);

    markers.add(Marker(
        markerId:  MarkerId(name),
        position: LatLng(latitude,longitude),
        infoWindow: InfoWindow(title: display,)
      //icon: BitmapDescriptor.fromBytes(destinationImageData),
    ));
    setState(() {});
  }
  Future<Uint8List> convertAssetToUnit8List(String imagePath, {int width = 350}) async {
    ByteData data = await rootBundle.load(imagePath);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))!.buffer.asUint8List();
  }
}
