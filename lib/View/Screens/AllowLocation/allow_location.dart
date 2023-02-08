import 'package:flocdock/View/Screens/getNotifications/get_notifications.dart';
import 'package:flocdock/View/Widgets/my_button.dart';
import 'package:flocdock/View/Widgets/my_spacing.dart';
import 'package:flocdock/View/Widgets/my_text.dart';
import 'package:flocdock/View/base/custom_snackbar.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';



class AllowLocation extends StatefulWidget {
  const AllowLocation({Key? key}) : super(key: key);

  @override
  _AllowLocationState createState() => _AllowLocationState();
}

class _AllowLocationState extends State<AllowLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KbgBlack,
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              spaceVertical(230),
              SvgPicture.asset(Images.location),
              spaceVertical(50),
              MyText(
                text: "Allow Location",
                color: KBlue,
                size: 24,
                fontFamily: "Proxima",
                weight: FontWeight.w700,
              ),
              spaceVertical(10),
              MyText(
                text: "To use FlockDock you have to\nallow your location",
                size: 22,
                fontFamily: "Proxima",
                color: KWhite,
                weight: FontWeight.w400,
                align: TextAlign.center,
              ),
              spaceVertical(100),
              MyButton(
                onPressed: _determinePosition,
                fontFamily: "Proxima",
                text: "Allow Location",
                buttonColor: KMediumBlue,
                size: 22,
                textWeight: FontWeight.w700,
                textColor: KWhite,
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showCustomSnackBar('Location services are disabled.');
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showCustomSnackBar('Location permissions are denied.');
        return Future.error('Location permissions are denied');

      }
    }

    if (permission == LocationPermission.deniedForever) {
      showCustomSnackBar('Location permissions are permanently denied, we cannot request permissions.');
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    if(permission == LocationPermission.always || permission == LocationPermission.whileInUse){
      Get.to(() => const RecieveNotifications());
    }
  }

}
