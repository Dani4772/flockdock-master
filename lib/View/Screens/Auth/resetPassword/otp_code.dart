import 'package:flocdock/View/Screens/Auth/resetPassword/new_password.dart';
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

class OTPCode extends StatefulWidget {
  String? email;
  OTPCode({Key? key, this.email});
  @override
  _OTPCodeState createState() => _OTPCodeState();
}

class _OTPCodeState extends State<OTPCode> {
  TextEditingController _resetCodeController = TextEditingController();

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
                            text: "Forget Password",
                            color: KWhite,
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
                    "We have sent you an email, enter the\ncode below to recover the password",
                    align: TextAlign.center,
                    fontFamily: "Proxima",
                    size: 17,
                    color: KWhite.withOpacity(0.5),
                  ),
                  spaceVertical(38),
                  MyTextField(
                    textInputType: TextInputType.emailAddress,
                    controller: _resetCodeController,
                    isObSecure: false,
                    hintText: "Code",
                  ),
                  spaceVertical(28),
                  MyButton(
                    onPressed: verifyCode,
                    fontFamily: "Proxima",
                    size: 17,
                    text: "Submit",
                    textWeight: FontWeight.w700,
                    textColor: KWhite,
                    buttonColor: KMediumBlue,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> verifyCode() async {
    if(_resetCodeController.text.trim().length!=4){
      showCustomSnackBar('Enter 4 digit code');
    }
    else{
      openLoadingDialog(context, "Loading");
      var response;
      response = await DioService.post('forgot_password', {
        "requestType":"match_code",
        "email":widget.email,
        "code":_resetCodeController.text.trim().toString()
      });
      if(response['status']=='Success'){
        Navigator.pop(context);
        showCustomSnackBar(response['message'],isError: false);
        Get.to(() => NewPassword(email: widget.email,));
      }
      else{
        Navigator.pop(context);
        print(response['message']);
        showCustomSnackBar(response['message']);
      }
    }

  }
}
