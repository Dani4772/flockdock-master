import 'dart:async';
import 'package:flocdock/View/Screens/Home/home_page.dart';
import 'package:flocdock/View/Screens/landingPage/landing_page.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flocdock/mixin/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        Duration(seconds: 3),
            () => AppData().isAuthenticated?Get.offAll(HomePage()):Get.offAll(LandingPage())
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: KBlue,
        body: Center(child: SvgPicture.asset(Images.logo,
          height: 110,
          width: 110,
          color: Colors.black,
        )),
          // fit: BoxFit.cover,
          // height: MediaQuery.of(context).size.height,
          // width: MediaQuery.of(context).size.width,
        );
  }
}
