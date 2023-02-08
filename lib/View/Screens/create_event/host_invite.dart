import 'package:flocdock/View/Screens/create_event/choose_category.dart';
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
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../../Widgets/profile_widget.dart';

class HostInvite extends StatefulWidget {
  bool fromEditParticipant;
  List<UserDetail>? guest;
  int? groupId;
  HostInvite({Key? key,this.fromEditParticipant=false,this.guest,this.groupId}) : super(key: key);

  @override
  State<HostInvite> createState() => _HostInviteState();
}

class _HostInviteState extends State<HostInvite> {
  bool isSearch=false;
  bool isNearby=false;
  bool isFavourite=false;
  List<UserDetail> members=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.fromEditParticipant){
      eventDetail.userGuests=[];
      eventDetail.userGuests=widget.guest;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KbgBlack,
      appBar: SimpleAppbar(description: "Invite", pageName: 'HOST',pageTrailing: Images.close,),
      body: Padding(
        padding:EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            isSearch?Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 40,
                  margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_DEFAULT),
                  width: MediaQuery.of(context).size.width*0.8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    cursorColor: Theme.of(context).primaryColor,
                    autofocus: false,
                    obscureText: true,
                    decoration: InputDecoration(
                      focusColor: Color.fromARGB(1,65, 68, 82,).withOpacity(0.9),
                      hoverColor: Color.fromARGB(1,65, 68, 82,).withOpacity(0.9),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(style: BorderStyle.none, width: 0),
                      ),
                      isDense: true,
                      hintText: "Search...",
                      hintStyle: TextStyle(color: KWhite),
                      fillColor: Color.fromARGB(1,65, 68, 82,).withOpacity(0.9),
                      filled: true,

                      prefixIcon: Padding(
                        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        child: SvgPicture.asset(Images.search),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    setState(() {
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
                  value: isNearby,
                  onToggle: (value) {
                    isNearby = value;
                    if(isNearby)
                      getNearbyUsers();
                    else
                      setState(() {});
                  },
                ),
                spaceHorizontal(5),
                MyText(
                  text: "NEARBY",
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
                  value: isFavourite,
                  onToggle: (value) {
                    isFavourite = value;
                    if(isFavourite)
                      getFavoriteUsers();
                    else
                      setState(() {});
                  },
                ),
                spaceHorizontal(5),
                MyText(
                  text: "FAVORITEs",
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
            SizedBox(height: 10,),
            Text(eventDetail.userGuests!.length.toString() +" Selected",style: proximaBold.copyWith(color: KdullWhite,fontSize: Dimensions.fontSizeLarge),),
            SizedBox(height: 15,),
            Expanded(
              child: GridView.builder(
                  gridDelegate:
                  const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 120,
                      crossAxisSpacing: 13,
                      mainAxisSpacing: 13
                  ),
                  itemCount: members.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return InkWell(
                      onTap: (){
                        if(eventDetail.userGuests!.any((element) => element.usersId==members[index].usersId))
                          eventDetail.userGuests!.removeWhere((element) => element.usersId==members[index].usersId);
                        else
                          eventDetail.userGuests!.add(members[index]);
                        setState(() {});
                      },
                      child: ProfileContainer(
                          img: members[index].profilePicture==null||members[index].profilePicture!.isEmpty?AppConstants.placeholder:members[index].profilePicture!,
                          profileName: members[index].userName??'',
                          distance: members[index].distanceAway.toPrecision(2).toString(),
                        isSelected: eventDetail.userGuests!.any((element) => element.usersId==members[index].usersId),
                      ),
                    );
                  }),
            ),
            Align(
              alignment: Alignment.center,
              child:Container(
                height: 35,
                width: 80,
                child: MyButton(
                  onPressed: () => widget.fromEditParticipant?editParticipants():Get.back(),
                  buttonColor: KMediumBlue,
                  text: "Done",
                  textColor: KWhite,
                  textWeight: FontWeight.w700,
                  fontFamily: "Proxima",
                  size: 16,
                ),

              ),

            ),
            if(GetPlatform.isIOS)SizedBox(height: 8,),
          ],
        ),
      ),
    );
  }
  void getNearbyUsers() async {

    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('nearby_users', {
      "usersId":AppData().userdetail!.usersId,
      "userLat":AppData().userdetail!.latitude.toString(),
      "userLong":AppData().userdetail!.longitude.toString(),
    });
    if(response['status']=='success'){
      var jsonData= response['data'] as List;
      members=jsonData.map((e) => UserDetail.fromJson(e)).toList();
      Navigator.pop(context);
      setState(() {});
    }
    else{
      Navigator.pop(context);
      print(response['message']);
     // showCustomSnackBar(response['message']);
    }

  }
  void getFavoriteUsers() async {

    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('get_favourite_users', {
      "usersId":AppData().userdetail!.usersId,
      "userLat":AppData().userdetail!.latitude.toString(),
      "userLong":AppData().userdetail!.longitude.toString(),
    });
    if(response['status']=='success'){
      var jsonData= response['data'] as List;
      members=jsonData.map((e) => UserDetail.fromJson(e)).toList();
      Navigator.pop(context);
      setState(() {});
    }
    else{
      Navigator.pop(context);
      print(response['message']);
      //showCustomSnackBar(response['message']);
    }

  }

  void editParticipants() async {
    List<int> guest=[];
    eventDetail.userGuests!.map((e) {if(e.usersId!=AppData().userdetail!.usersId)guest.add(e.usersId!);}).toList();
    print(guest);
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('edit_participants', {
      "groupId": widget.groupId,
      "usersId": AppData().userdetail!.usersId,
      "guests": guest
    });
    if(response['status']=='Success'){
      Navigator.pop(context);
      Navigator.pop(context);
      showCustomSnackBar(response['data'],isError: false);
    }
    else{
      Navigator.pop(context);
      Navigator.pop(context);
      print(response['message']);
      showCustomSnackBar(response['message']);
    }

  }
}


