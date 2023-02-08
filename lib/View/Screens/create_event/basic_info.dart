
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flocdock/View/Screens/create_event/choose_category.dart';
import 'package:flocdock/View/Screens/create_event/event_details.dart';
import 'package:flocdock/View/Screens/create_event/widget/bottom_navigator.dart';
import 'package:flocdock/View/Widgets/my_text_field.dart';
import 'package:flocdock/View/base/custom_snackbar.dart';
import 'package:flocdock/View/base/loading_dialog.dart';
import 'package:flocdock/View/base/simple_appbar.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flocdock/mixin/data.dart';
import 'package:flocdock/services/dio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:places_service/places_service.dart';

import '../../../models/user_model/signup_model.dart';
import '../../Widgets/my_spacing.dart';

class BasicInfo extends StatefulWidget {
  const BasicInfo({Key? key}) : super(key: key);

  @override
  State<BasicInfo> createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {
  TimeOfDay pickedTime=TimeOfDay.now();
  DateTime startDatePicked=DateTime.now();
  DateTime endDatePicked=DateTime.now();
  final TextEditingController _addressController=TextEditingController();
  final TextEditingController _additionalController=TextEditingController();
  String start_date=DateFormat("dd MMM, yyyy HH:mm").format(DateTime.now());
  String end_date=DateFormat("dd MMM, yyyy HH:mm").format(DateTime.now());
  DateTime selectedDate=DateTime.now();
  PickedFile pickedFile=PickedFile("");
  UserDetail userDetail=UserDetail(userSeeking: [],userTribes: []);
  Position? position;
  Set<Marker> markers = Set.of([]);
  CameraPosition? cameraPosition;
  PlacesService  placesService = PlacesService();
  List<PlacesAutoCompleteResult>  _autoCompleteResult=[];
  GoogleMapController? googleMapController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    placesService.initialize(apiKey: AppConstants.apiKey);
    if(eventDetail.address!=null)
      _addressController.text=eventDetail.address!;
    if(eventDetail.additionalInstructions!=null)
      _additionalController.text=eventDetail.additionalInstructions!;
    setMarker();
  }

  Future<void> getPosition() async {
    position= await _determinePosition();
    await convertToAddress(position!.latitude, position!.longitude, AppConstants.apiKey);
    eventDetail.groupLat=position!.latitude;
    eventDetail.groupLong=position!.longitude;
    setMarker();
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
          String address="";
          address = firstresult["formatted_address"];
          List<String> list=address.split(',');
          eventDetail.address="";
          for(int i=0;i<list.length;i++) {
            if(i!=0) {
              eventDetail.address = eventDetail.address! + list[i] + " ";
            }
          }
          _addressController.text=eventDetail.address!;
          setState(() {
          });
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
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: KbgBlack,
        appBar: SimpleAppbar(description: "Gather a Group", pageName: 'HOST',pageTrailing: Images.close,isEvent: true,),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding:EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("CHILL OUT GROUP",style: proximaBold.copyWith(color: KWhite,fontSize: Dimensions.fontSizeLarge),),
              SizedBox(height: 5,),
              Text("BASIC INFO",style: proximaBold.copyWith(color: KdullWhite),),
              SizedBox(height: 20,),
              Text("Upload a cover photo",style: proximaBold.copyWith(color: KWhite),),
              SizedBox(height: 3,),
              GestureDetector(
                onTap: () async {
                  pickedFile = await ImagePicker().getImage(source: ImageSource.gallery) as PickedFile ;
                  setState(() {});
                  uploadPicture();
                  print("eventDetail.toJson()");
                  print(eventDetail.toJson());
                  print("groupDetail.toJson()");
                  print(groupDetail.toJson());
                },
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height*0.2,
                  decoration: pickedFile.path.isNotEmpty?BoxDecoration(
                    image: DecorationImage(image: FileImage(File(pickedFile.path)),fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(0.2)
                  ):
                      eventDetail.fromEdit?
                      BoxDecoration(
                          image: DecorationImage(image: NetworkImage(eventDetail.coverPhoto??''),fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.withOpacity(0.2)
                      ):
                  BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(0.2)
                  ),
                  child: Center(
                      child: pickedFile.path.isNotEmpty||eventDetail.fromEdit?
                      SizedBox():
                      SvgPicture.asset(
                        Images.add,
                        height: 40,
                        width: 40,
                      )
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text("Starting Date",style: proximaBold.copyWith(color: KWhite),),
                  SizedBox(height: 5,),
                //SizedBox(width: MediaQuery.of(context).size.width*0.25,),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(color: KDullBlack,
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_SMALL+1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        GestureDetector(
                          onTap: () async{
                            DateTime? selected;
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    color: KWhite,
                                    height: 400,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: CupertinoDatePicker(
                                            onDateTimeChanged: (DateTime date) {
                                              selected=date;
                                            },
                                            mode: CupertinoDatePickerMode.dateAndTime,
                                            use24hFormat: true,
                                            initialDateTime: selectedDate,
                                            minimumDate: DateTime(1970),
                                            maximumDate: DateTime(2050),
                                          ),
                                        ),
                                        CupertinoButton(
                                          child: Text("OK",style: proximaBold.copyWith(color: KBlue)),
                                          onPressed: () {
                                            if (selected!=null && selected != selectedDate) {
                                              print(selected);
                                              selectedDate = selected!;
                                              start_date=DateFormat("dd MMM, yyyy HH:mm").format(selectedDate);
                                              //List<String> datetime=dateTime.toString().split(" ");
                                              String start_time = DateFormat("HH:mm:ss").format(DateTime.now());
                                              eventDetail.startingDate=DateFormat("yyyy-MM-dd").format(selectedDate);
                                              eventDetail.startingTime= start_time;

                                              print(eventDetail.startingDate.toString());
                                              print(start_time);

                                              setState(() {});
                                            }
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Container(
                            height: 25,
                            width: MediaQuery.of(context).size.width*0.8,
                            //color: Colors.white,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: KDullBlack,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left:5.0),
                                  child: Text(start_date,

                                    style: TextStyle(
                                        color: KWhite.withOpacity(0.5),
                                        fontFamily: "Proxima",
                                        fontSize: 16
                                    ),
                                  ),
                                ),
                                spaceHorizontal(10),
                                Container(
                                  height: 30,
                                  width: 13,
                                  child:SvgPicture.asset(
                                    Images.calendar,
                                    color: KWhite.withOpacity(0.5),
                                  ),),
                              ],
                            ),
                          ),
                          //child: EditField(isEnabled: false,controller: TextEditingController(text: DOB),),
                        ),
                      ],),
                    ),
                  ),

              ],),
              SizedBox(height: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Ending Date",style: proximaBold.copyWith(color: KWhite),),
                  SizedBox(height: 5,),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(color: KDullBlack,
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_SMALL+1),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                        GestureDetector(
                          onTap: () async{
                            DateTime? selected;
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    color: KWhite,
                                    height: 400,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: CupertinoDatePicker(
                                            onDateTimeChanged: (DateTime date) {
                                              selected=date;
                                            },
                                            mode: CupertinoDatePickerMode.dateAndTime,
                                            use24hFormat: true,
                                            initialDateTime: selectedDate,
                                            minimumDate: DateTime(1970),
                                            maximumDate: DateTime(2050),
                                          ),
                                        ),
                                        CupertinoButton(
                                          child: Text("OK",style: proximaBold.copyWith(color: KBlue)),
                                          onPressed: () {
                                            if (selected!=null && selected != selectedDate) {
                                              print(selected);
                                              selectedDate = selected!;
                                              String end_time = DateFormat("HH:mm:ss ").format(selectedDate);
                                              end_date=DateFormat("dd MMM, yyyy HH:mm").format(selectedDate);
                                              eventDetail.endingDate=DateFormat("yyyy-MM-dd").format(selectedDate);
                                              eventDetail.endingTime= end_time;

                                              print(eventDetail.endingDate.toString());
                                              //userDetail.birthday=DateFormat("yyyy-MM-dd").format(selectedDate);

                                              print(end_time);
                                              setState(() {});
                                            }
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Container(
                            height: 25,
                            width: MediaQuery.of(context).size.width*0.8,
                            //color: Colors.white,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: KDullBlack,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left:5.0),
                                  child: Text(end_date,

                                    style: TextStyle(
                                        color: KWhite.withOpacity(0.5),
                                        fontFamily: "Proxima",
                                        fontSize: 16
                                    ),
                                  ),
                                ),
                                spaceHorizontal(10),
                                Container(
                                  height: 30,
                                  width: 13,
                                  child:SvgPicture.asset(
                                    Images.calendar,
                                    color: KWhite.withOpacity(0.5),
                                  ),),
                              ],
                            ),
                          ),
                          //child: EditField(isEnabled: false,controller: TextEditingController(text: DOB),),
                        ),
                      ],),
                    ),
                  ),

                ],
              ),
              SizedBox(height: 20,),
              Text("Address",style: proximaBold.copyWith(color: KWhite),),
              SizedBox(height: 5,),
              MyTextField(
                verticalPadding: 0.0,

                hight: 50.0, controller: _addressController,
                onChanged: (value) async {
                  if(value==""){
                    setState(() {
                      _autoCompleteResult.clear();
                    });
                  }
                  else{
                    print(value);
                    print(_addressController.text);
                    final autoCompleteSuggestions = await placesService.getAutoComplete(value);
                    _autoCompleteResult = autoCompleteSuggestions;
                    setState(() {});
                  }
                },
              ),
              if (_autoCompleteResult.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    decoration: const BoxDecoration(
                      color: KDullBlack,
                      //: Border.all(color: Colors.black)
                    ),
                    height: 140,
                    child: ListView.builder(
                      itemCount: _autoCompleteResult.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_autoCompleteResult[index].mainText ?? "",style: proximaBold.copyWith(color: KWhite),),
                          //subtitle: Text(_autoCompleteResult[index].description ?? ""),
                          onTap: () async {
                            var id = _autoCompleteResult[index].placeId;
                            final placeDetails = await placesService.getPlaceDetails(id!);
                            print(placeDetails);
                            _addressController.text="${_autoCompleteResult[index].mainText??''}, ${_autoCompleteResult[index].secondaryText??''}";
                            eventDetail.address=_addressController.text;
                            eventDetail.groupLat=placeDetails.lat;
                            eventDetail.groupLong=placeDetails.lng;
                            googleMapController!.animateCamera(
                                CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                    target: LatLng(eventDetail.groupLat??0,eventDetail.groupLong??0),
                                    zoom: 10,
                                  ),
                                )
                            );
                            setMarker();
                            _autoCompleteResult.clear();
                            setState(() {});
                          },
                        );
                      },
                    ),
                  ),
                ),
              SizedBox(height: 20,),
              Text("Map view",style: proximaBold.copyWith(color: KWhite),),
              SizedBox(height: 5,),
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: GoogleMap(
                        markers: markers,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(eventDetail.groupLat??0,eventDetail.groupLong??0),
                          zoom: 10,
                        ),
                        onMapCreated: (GoogleMapController mapController) {
                          googleMapController=mapController;
                        },
                        zoomControlsEnabled: false,
                        onCameraMove: (CameraPosition cameraPosition) async {
                          this.cameraPosition=cameraPosition;
                          eventDetail.groupLat=cameraPosition.target.latitude;
                          eventDetail.groupLong=cameraPosition.target.longitude;
                          await setMarker();
                        },
                        onCameraMoveStarted: () {

                        },
                        onCameraIdle: () async {
                          //await convertToAddress(eventDetail.groupLat??0, eventDetail.groupLong??0, AppConstants.apiKey);
                        },
                      ),
                    )
                  ),
                  Container(
                      width: double.infinity,
                      height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Text("Additional Instructions",style: proximaBold.copyWith(color: KWhite),),
              SizedBox(height: 5,),
              MyTextField(
                radius: 5.0,
                  minLines: 3,
                  maxLines: 3,
                  verticalPadding: 0.0,
                  hight: 80.0,
                  controller: _additionalController,
                onChanged: (val) => eventDetail.additionalInstructions=_additionalController.text,
              ),
              SizedBox(height: 20,),


              BottomNavigator(selected: 2, onTapLeading: () => Get.back(), onTapTrailing: basicInfoCheck),
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
      ),
    );
  }
  void basicInfoCheck(){
    if(eventDetail.coverPhoto==null){
      showCustomSnackBar("Please upload cover photo");
    }
    else if(eventDetail.startingDate==null){
      showCustomSnackBar("Please select start date");
    }
    else if(eventDetail.endingDate==null){
      showCustomSnackBar("Please select end date");
    }
    else if(eventDetail.address==null||eventDetail.address!.isEmpty){
      showCustomSnackBar("Please enter address");
    }
    else if(eventDetail.additionalInstructions==null||eventDetail.additionalInstructions!.isEmpty){
      showCustomSnackBar("Please enter additional instruction");
    }
    else{
      Get.to(EventDetails());
    }

  }
  Future<void> uploadPicture() async {

    FormData data=FormData.fromMap({
      'cover_photo': await MultipartFile.fromFile(pickedFile.path)
    });

    openLoadingDialog(context, "Loading");
    var response;

    response = await DioService.post('upload_group_cover', data);
    if(response['status']=='success'){
      eventDetail.coverPhoto=response["data"];
      Navigator.pop(context);
      //showCustomSnackBar(response['data']);
    }
    else{
      Navigator.pop(context);
      //showCustomSnackBar(response['message']);

    }
  }

  setMarker() async {
    markers.clear();
    //googleMapController!.getScreenCoordinate(LatLng(eventDetail.groupLat??0, eventDetail.groupLong??0));
    markers.add(Marker(
      markerId: const MarkerId('marker'),
      position: LatLng(eventDetail.groupLat??0,eventDetail.groupLong??0),
    ));
    setState(() {});
  }
}
