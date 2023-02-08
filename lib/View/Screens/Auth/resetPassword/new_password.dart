import 'package:flocdock/View/Screens/Auth/Login/login_screen.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class NewPassword extends StatefulWidget {
  String? email;
  NewPassword({Key? key,this.email}) : super(key: key);

  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {

  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

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
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
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
                    "Create new Password",
                    align: TextAlign.center,
                    fontFamily: "Proxima",
                    size: 17,
                    color: KWhite,
                  ),
                  spaceVertical(38),
                  MyTextField(
                    textInputType: TextInputType.visiblePassword,
                    controller: _newPasswordController,
                    isObSecure: true,
                    hintText: "Password",
                  ),
                  spaceVertical(12),
                  MyTextField(
                    textInputType: TextInputType.visiblePassword,
                    controller: _confirmPasswordController,
                    isObSecure: true,
                    hintText: "Confirm Password",
                  ),
                  spaceVertical(28),
                  MyButton(
                    onPressed: _resetPassword,
                    fontFamily: "Proxima",
                    size: 17,
                    text: "Save",
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
  Future<void> _resetPassword() async {
    String _password = _newPasswordController.text.trim();
    String _confirmPassword = _confirmPasswordController.text.trim();
    if (_password.isEmpty) {
      showCustomSnackBar('Enter Password');
    }else if (_password.length < 6) {
      showCustomSnackBar('Password shoud be 6 digit');
    }else if(_password != _confirmPassword) {
      showCustomSnackBar('Confirm password does not matched');
    }else {
      openLoadingDialog(context, "Loading");
      var response;
      response = await DioService.post('forgot_password', {
        "requestType":"reset_password",
        "email":widget.email,
        "password":_password,
        "confirmPassword":_confirmPassword,
      });
      if(response['status']=='Success'){
        Navigator.pop(context);
        showCustomSnackBar(response['message'],isError: false);
        Get.offAll(LoginScreen());
      }
      else{
        Navigator.pop(context);
        print(response['message']);
        showCustomSnackBar(response['message']);
      }

    }
  }
}
