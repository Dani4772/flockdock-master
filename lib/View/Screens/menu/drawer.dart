import 'package:flocdock/View/Screens/landingPage/landing_page.dart';
import 'package:flocdock/View/Screens/edit_profile/edit_profile.dart';
import 'package:flocdock/View/Screens/edit_profile/profile_picture.dart';
import 'package:flocdock/View/Screens/setting/setting.dart';
import 'package:flocdock/View/Screens/vip/upgrade_vip.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flocdock/mixin/data.dart';
import 'package:flocdock/services/dio_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}
class _MyDrawerState extends State<MyDrawer> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: KPureBlack,
        child: Column(
          children: [
            SizedBox(height: 40,),
             Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: const Padding(
                  padding:  EdgeInsets.only(left: 20.0),
                  child: Icon(Icons.close,color: KWhite,),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.05),
            Center(
            child: Column(
              children: [
                InkWell(
                  onTap: () => Get.to(EditProfilePicture()),
                  child: Container(
                    padding: EdgeInsets.all(1),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: KBlue,
                      shape: BoxShape.circle
                    ),
                    child: ClipOval(
                      child:
                          Image.network(
                            AppData().userdetail!.profilePicture??AppConstants.placeholder,
                            height: 90,
                            width: 90, fit:
                            BoxFit.cover,
                          )
                    ),
                  ),
                ),
                SizedBox(height: 18),
                InkWell(
                  onTap: () => Get.to(EditProfile()),
                    child: Text("Edit Profile", style: proximaBold.copyWith(color: KBlue),),
                ),
              ],
            ),
          ),
            SizedBox(height: MediaQuery.of(context).size.height*0.05),
            ListTile(
              horizontalTitleGap: 0,
              leading: Padding(
                padding: EdgeInsets.all(10.0),
                  child: SvgPicture.asset(Images.setting,color: KWhite.withOpacity(0.7),)
              ),
              title: Text(
                "Settings",
                style: proximaBold.copyWith(fontSize:Dimensions.fontSizeExtraLarge+2,color: KWhite.withOpacity(0.5)),
              ),
              onTap: () => Get.to(Setting()),
            ),
           Divider(
             color: KWhite.withOpacity(0.5),
             indent: 20,
             endIndent: 20,
           ),
            ListTile(
              title: InkWell(
                onTap: () => Get.to(() => VIPUpgrade()),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    "Upgrade to VIP plan",
                    style: proximaBold.copyWith(color: KWhite.withOpacity(0.5),fontSize: Dimensions.fontSizeOverLarge-3),
                  ),
                ),
              ),
              onTap: (){},
            ),
            Expanded(child: Container()),
            ListTile(
              leading: Padding(
                padding: EdgeInsets.all(10.0),
                child: SvgPicture.asset(Images.logout,color: KWhite,)
              ),
              title: Text(
                "Logout",
                style: proximaBold.copyWith(color: KWhite),
              ),
              onTap: offlineUser,
            ),
            SizedBox(height: 35,),

            


          ],
        ),
      ),
    );
  }
  void offlineUser() async {
    await DioService.post('offline_user', {
      "userId": AppData().userdetail!.usersId
    });
    AppData().signOut();
    Get.offAll(LandingPage());
  }
}

