import 'package:flocdock/View/base/bottom_navbar.dart';
import 'package:flocdock/View/Screens/Home/home_page.dart';
import 'package:flocdock/View/Widgets/my_button.dart';
import 'package:flocdock/View/Widgets/my_spacing.dart';
import 'package:flocdock/View/Widgets/my_text.dart';
import 'package:flocdock/View/base/custom_snackbar.dart';
import 'package:flocdock/View/base/loading_dialog.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flocdock/mixin/data.dart';
import 'package:flocdock/services/dio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class RecieveNotifications extends StatefulWidget {
  const RecieveNotifications({Key? key}) : super(key: key);

  @override
  _RecieveNotificationsState createState() => _RecieveNotificationsState();
}

class _RecieveNotificationsState extends State<RecieveNotifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KbgBlack,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              spaceVertical(MediaQuery.of(context).size.height*0.3),
              SvgPicture.asset(Images.notifications),
              spaceVertical(50),
              MyText(
                text: "Receive Notifications",
                color: KBlue,
                size: 24,
                weight: FontWeight.w700,
              ),
              spaceVertical(10),
              MyText(
                text: "We will notify you of new friends\nand messages",
                size: 22,
                fontFamily: "Proxima",
                color: KWhite,
                weight: FontWeight.w400,
                align: TextAlign.center,
              ),
              spaceVertical(MediaQuery.of(context).size.height*0.1),
              MyButton(
                onPressed: notify,
                fontFamily: "Proxima",
                text: "Notify Me",
                buttonColor: KMediumBlue,
                size: 22,
                textWeight: FontWeight.w700,
                textColor: KWhite,
              ),
              spaceVertical(14),
              MyButton(
                onPressed: () => Get.to(() => HomePage()),
                fontFamily: "Proxima",
                text: "Not Now",
                buttonColor: KDullBlack,
                size: 22,
                textWeight: FontWeight.w700,
                textColor: KWhite,
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> notify() async {
    print(AppData().userdetail?.usersId);
      openLoadingDialog(context, "Loading");
      var response;
      response = await DioService.post('set_notification_settings', {
        "usersId": AppData().userdetail?.usersId,
        "notificationSetting":"True"
      });
      if(response['status']=='success'){
        Navigator.pop(context);
        print(response['data'],);
        showCustomSnackBar(response['data'],isError: false);
        Get.offAll(HomePage());
      }
      else{
        Navigator.pop(context);
        print(response['message'],);
        showCustomSnackBar(response['message'],);
      }

  }
}
