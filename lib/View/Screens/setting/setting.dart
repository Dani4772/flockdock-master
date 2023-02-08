import 'package:flocdock/View/Screens/help/about.dart';
import 'package:flocdock/View/Screens/help/community_guideline.dart';
import 'package:flocdock/View/Screens/help/contact.dart';
import 'package:flocdock/View/Screens/help/privacy_policy.dart';
import 'package:flocdock/View/Screens/help/terms_services.dart';
import 'package:flocdock/View/Screens/setting/blocked_user.dart';
import 'package:flocdock/View/Screens/setting/gallery_permission.dart';
import 'package:flocdock/View/Screens/setting/unit_system.dart';
import 'package:flocdock/View/Widgets/edit_field.dart';
import 'package:flocdock/View/Screens/setting/widget/setting_widget.dart';
import 'package:flocdock/View/base/custom_snackbar.dart';
import 'package:flocdock/View/base/loading_dialog.dart';
import 'package:flocdock/View/base/simple_appbar.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flocdock/mixin/data.dart';
import 'package:flocdock/models/user_model/signup_model.dart';
import 'package:flocdock/services/dio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  UserDetail userDetail=UserDetail();
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  bool isAllow=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getUserProfileSetting();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KbgBlack,
      appBar: SimpleAppbar(description: "", pageName: "SETTINGS",pageTrailing: Images.close,),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: updateCredentials,
              child: Padding(
                padding: const EdgeInsets.only(right: 25.0,top: 10),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text("SAVE",style: proximaBold.copyWith(color: KWhite)),
                ),
              ),
            ),
            EditField(title: "UserName",controller: nameController,),
            EditField(title: "Email address",controller: emailController,),
            EditField(title: "Password",controller: passwordController,isPassword: true,),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE,vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            //   margin: EdgeInsets.all(20),
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(40),
            //       color: KDullBlack
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text("UserName",style: proximaBold.copyWith(color: KBlue)),
            //       SizedBox(
            //         height: 25,
            //         child: TextField(
            //             controller: nameController,
            //             keyboardType: TextInputType.emailAddress,
            //             cursorColor: KWhite,
            //             autofocus: false,
            //             style: const TextStyle(
            //                 color: KWhite,
            //                 fontFamily: "Proxima"
            //             ),
            //             decoration: const InputDecoration(
            //               border: InputBorder.none,
            //               hintStyle: TextStyle(color: KWhite,fontFamily: "Proxima"),
            //             )
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE,vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            //   margin: EdgeInsets.all(20),
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(40),
            //       color: KDullBlack
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text("Email address",style: proximaBold.copyWith(color: KBlue)),
            //       SizedBox(
            //         height: 25,
            //         child: TextField(
            //             controller: emailController,
            //             keyboardType: TextInputType.emailAddress,
            //             cursorColor: KWhite,
            //             autofocus: false,
            //             style: const TextStyle(
            //                 color: KWhite,
            //                 fontFamily: "Proxima"
            //             ),
            //             decoration: const InputDecoration(
            //               border: InputBorder.none,
            //               hintStyle: TextStyle(color: KWhite,fontFamily: "Proxima"),
            //             )
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE,vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            //   margin: EdgeInsets.only(left: 20,right: 20,bottom: 20),
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(40),
            //       color: KDullBlack
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text("Password",style: proximaBold.copyWith(color: KBlue)),
            //       SizedBox(
            //         height: 25,
            //         child: TextField(
            //             controller: passwordController,
            //             keyboardType: TextInputType.text,
            //             cursorColor: KWhite,
            //             autofocus: false,
            //             obscureText: true,
            //             style: const TextStyle(
            //                 color: KWhite,
            //                 fontFamily: "Proxima"
            //             ),
            //             decoration: const InputDecoration(
            //               border: InputBorder.none,
            //               hintStyle: TextStyle(color: KWhite,fontFamily: "Proxima"),
            //             )
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(height: 20,),
            Container(height:0.5,width: MediaQuery.of(context).size.width*0.9,color: KDullBlack,),
            SettingWidget(text: "Blocked Users",description: userDetail.blockedUsersCount.toString(),onTapTrailing: () => Get.to(BlockedUser())),
            Container(height:0.5,width: MediaQuery.of(context).size.width*0.9,color: KDullBlack,),
            SettingWidget(text: "Unit System",description:userDetail.unitSystem??'',onTapTrailing: () => Get.to(UnitSystem(unitSystem: userDetail.unitSystem,))),
            Container(height:0.5,width: MediaQuery.of(context).size.width*0.9,color: KDullBlack,),
            SettingWidget(text: "Gallery Permission",onTapTrailing: () => Get.to(GalleryPermission())),
            Container(height:0.5,width: MediaQuery.of(context).size.width*0.9,color: KDullBlack,),
            //SettingWidget(text: "Notifications"),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ListTile(
                minVerticalPadding: 0,
                title: Text("Notifications",style: proximaBold.copyWith(color: KBlue)),
                trailing: SizedBox(
                  height: 25,
                  width: 45,
                  child: FlutterSwitch(
                    height: 25,
                    width: 45,
                    padding: 1,
                    toggleSize: 24,
                    activeColor: KBlue,
                    inactiveToggleColor: KDullBlack,
                    value: isAllow,
                    onToggle: (value) {
                        isAllow = value;
                        userDetail.notificationStatus=isAllow?"Yes":"No";
                        updateNotificationStatus();
                    },
                  ),
                ),
              )
            ),
            Container(height:0.5,width: MediaQuery.of(context).size.width*0.9,color: KDullBlack,),
            SettingWidget(text: "About",onTapTrailing: () => Get.to(About())),
            Container(height:0.5,width: MediaQuery.of(context).size.width*0.9,color: KDullBlack,),
            SettingWidget(text: "Privacy Policy",onTapTrailing: () => Get.to(PrivacyPolicy())),
            Container(height:0.5,width: MediaQuery.of(context).size.width*0.9,color: KDullBlack,),
            SettingWidget(text: "Support"),
            Container(height:0.5,width: MediaQuery.of(context).size.width*0.9,color: KDullBlack,),
            SettingWidget(text: "Contact",onTapTrailing: () => Get.to(Contact())),
            Container(height:0.5,width: MediaQuery.of(context).size.width*0.9,color: KDullBlack,),
            SettingWidget(text: "Community Guidelines",onTapTrailing: () => Get.to(CommunityGuideline())),
            Container(height:0.5,width: MediaQuery.of(context).size.width*0.9,color: KDullBlack,),
            SettingWidget(text: "Terms of Service",onTapTrailing: () => Get.to(TermsServices())),
            Container(height:0.5,width: MediaQuery.of(context).size.width*0.9,color: KDullBlack,),
            SettingWidget(text: "Check for Updates"),
            Container(height:0.5,width: MediaQuery.of(context).size.width*0.9,color: KDullBlack,),
          ],
        ),
      ),
    );
  }
  void getUserProfileSetting() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('get_user_profile_settings', {
      "usersId" : AppData().userdetail!.usersId
    });
    if(response['status']=='success'){
      var jsonData= response['data'];
      userDetail=UserDetail.fromJson(jsonData);
      nameController.text=userDetail.userName??'';
      emailController.text=userDetail.email??'';
      passwordController.text="000000";
      isAllow=userDetail.notificationStatus=="Yes";
      print(userDetail.toJson());
      Navigator.pop(context);
      setState(() {});
    }
    else{
      Navigator.pop(context);
      print(response['message']);
      showCustomSnackBar(response['message']);
    }

  }
  void updateCredentials() async {
    if(nameController.text.isEmpty){
      showCustomSnackBar("Enter Name");
    }
    else if(emailController.text.isEmpty){
      showCustomSnackBar("Enter Email");
    }
    else if(passwordController.text.isEmpty){
      showCustomSnackBar("Enter Password");
    }
    else if(passwordController.text.length<6){
      showCustomSnackBar("Password Should be 6 digit");
    }
    else{
      openLoadingDialog(context, "Loading");
      var response;
      response = await DioService.post('update_credentials', {
        "usersId" : AppData().userdetail!.usersId,
        if(AppData().userdetail!.userName!=nameController.text.trim().toString())"userName":nameController.text..trim().toString(),
        if(AppData().userdetail!.email!=emailController.text.trim().toString())"userEmail":emailController.text.trim().toString(),
        if("000000"!=passwordController.text.trim().toString())"password":passwordController.text.trim().toString()
      });
      if(response['status']=='success'){
        AppData().userdetail!.userName=nameController.text.toString();
        AppData().userdetail!.email=emailController.text.toString();
        AppData().update();
        Navigator.pop(context);
      }
      else{
        Navigator.pop(context);
        print(response['message']);
      }
    }
  }
  void updateNotificationStatus() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('update_notification_status', {
      "userId" : AppData().userdetail!.usersId,
      "notificationStatus": userDetail.notificationStatus
    });
    if(response['status']=='Success'){
      showCustomSnackBar(response['data']);
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
