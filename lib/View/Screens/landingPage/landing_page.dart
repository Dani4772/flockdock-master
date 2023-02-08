import 'package:flocdock/View/Screens/Auth/Login/login_screen.dart';
import 'package:flocdock/View/Screens/Auth/SignUp/signup_screen.dart';
import 'package:flocdock/View/Screens/Auth/SocialAccounts/loginSocialAccounts.dart';
import 'package:flocdock/View/Widgets/my_button.dart';
import 'package:flocdock/View/Widgets/my_spacing.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: KbgBlack, // status bar color
    ));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KbgBlack,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
          child: Column(
            children: [
              spaceVertical(200),
              Center(
                  child: SvgPicture.asset(Images.logo,height: 76,width: 161,color: KWhite,)
              ),
              spaceVertical(180),
              SizedBox(
                height: 49,
                width: double.infinity,
                child: MyButton(
                  text: "Log In",
                  textWeight: FontWeight.w700,
                  size: 20,
                  fontFamily: "Proxima",
                  textColor: KWhite,
                  onPressed: () => Get.to(LoginScreen()),
                  buttonColor: KMediumBlue,
                ),
              ),
              spaceVertical(14),
              SizedBox(
                height: 49,
                width: double.infinity,
                child: MyButton(
                  textWeight: FontWeight.w700,
                  text: "Create Account",
                  fontFamily: "Proxima",
                  size: 20,
                  textColor: KWhite,
                  onPressed: () => Get.to(LoginWithSocial()),
                  buttonColor: KDullBlack,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
