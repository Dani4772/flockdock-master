import 'package:flocdock/View/Widgets/my_button.dart';
import 'package:flocdock/View/Widgets/my_spacing.dart';
import 'package:flocdock/View/Widgets/my_text.dart';
import 'package:flocdock/View/Widgets/my_text_field.dart';
import 'package:flocdock/View/base/custom_snackbar.dart';
import 'package:flocdock/View/base/loading_dialog.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flocdock/services/dio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'otp_code.dart';


class EnterEmail extends StatefulWidget {
  @override
  _EnterEmailState createState() => _EnterEmailState();
}

class _EnterEmailState extends State<EnterEmail> {
  TextEditingController _resetEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: KbgBlack,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
              child: Column(
                children: [
                  spaceVertical(104),
                  Center(child: SvgPicture.asset(Images.logo,height: 76,width: 161,color: KWhite,)),
                  spaceVertical(101),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset(
                          Images.arrowBack,
                          height: 15,
                          width: 15,
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: MyText(
                            text: "Forgot Password",
                            color: KWhite,
                            weight: FontWeight.w700,
                            size: 22,
                            fontFamily: "Proxima",
                          ),
                        ),
                      )
                    ],
                  ),
                  spaceVertical(28),
                  MyText(
                    text:
                        "Enter your email address, we will send\nyou a link to recover",
                    align: TextAlign.center,
                    fontFamily: "Proxima",
                    size: 17,
                    color: KWhite,
                  ),
                  spaceVertical(38),
                  MyTextField(
                    textInputType: TextInputType.emailAddress,
                    controller: _resetEmailController,
                    isObSecure: false,
                    hintText: "Email address",
                  ),
                  spaceVertical(28),
                  MyButton(
                    onPressed: _forgetPass,
                    fontFamily: "Proxima",
                    size: 17,
                    text: "Send",
                    textColor: KWhite,
                    buttonColor: KMediumBlue,
                    textWeight: FontWeight.w700,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _forgetPass() async {

    String _email = _resetEmailController.text.trim();
    if (_email.isEmpty) {
      showCustomSnackBar('Enter Email');
    }
    else {
      openLoadingDialog(context, "Loading");
      var response;
      response = await DioService.post('forgot_password', {
        "requestType":"forgot_password",
        "email":_email,
      });
      if(response['status']=='Success'){
        Navigator.pop(context);
        showCustomSnackBar(response['message'],isError: false);
        Get.to(() => OTPCode(email: _email,));
      }
      else{
        Navigator.pop(context);
        print(response['message']);
        showCustomSnackBar(response['message']);

      }

    }


  }
}
