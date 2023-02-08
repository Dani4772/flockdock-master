import 'package:flocdock/View/Screens/Auth/SignUp/signup_screen.dart';
import 'package:flocdock/View/Screens/Auth/resetPassword/enter_email.dart';
import 'package:flocdock/View/Screens/Home/home_page.dart';
import 'package:flocdock/View/Widgets/my_button.dart';
import 'package:flocdock/View/Widgets/my_spacing.dart';
import 'package:flocdock/View/Widgets/my_text.dart';
import 'package:flocdock/View/Widgets/my_text_field.dart';
import 'package:flocdock/View/base/custom_snackbar.dart';
import 'package:flocdock/View/base/loading_dialog.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flocdock/mixin/data.dart';
import 'package:flocdock/models/user_model/signup_model.dart';
import 'package:flocdock/services/dio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  Profile profile=Profile();
  bool isLoading=false;
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
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
            child: Column(
              children: [
                spaceVertical(104),
                Center(child: SvgPicture.asset(Images.logo,height: 76,width: 161,color: KWhite,)),
                spaceVertical(101),
                MyText(
                  size: 24,
                  fontFamily: "Proxima",
                  text: "Log In",
                  color: KWhite,
                weight: FontWeight.w700,
                ),
                spaceVertical(35),
                MyTextField(
                  textInputType: TextInputType.emailAddress,
                  controller: _emailController,
                  isObSecure: false,
                  hintText: "Username or Email",
                ),
                spaceVertical(14),
                MyTextField(
                  textInputType: TextInputType.emailAddress,
                  controller: _passwordController,
                  isObSecure: true,
                  hintText: "Password",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EnterEmail()));
                      },
                      child: MyText(
                        text: "Forgot Password?",
                        color: KBlue,
                        decoration: TextDecoration.underline,
                        weight: FontWeight.w700,
                        fontFamily: "Proxima",
                        size: 15,
                      ),
                    )
                  ],
                ),
                spaceVertical(28),
                MyButton(
                  onPressed: _login,
                  text: "Log In",
                  textWeight: FontWeight.w700,
                  fontFamily: "Proxima",
                  buttonColor: KMediumBlue,
                  textColor: KWhite,
                  size: 22,
                ),
                spaceVertical(70),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(
                        text: "Don't have an account?",
                        size: 15,
                        fontFamily: "Proxima",
                        color: KMediumBlue,
                        weight: FontWeight.w700,
                      ),
                    TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                      },
                      child: MyText(
                        text: "Register Now",
                        weight: FontWeight.w700,
                        size: 15,
                        color: KWhite,
                        fontFamily: "Proxima",
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _login() async {
    if (_emailController.text.isEmpty) {
      showCustomSnackBar('Enter User Name or Email');
    }
    else if (_passwordController.text.isEmpty) {
      showCustomSnackBar('Enter Password');
    }else if (_passwordController.text.length < 6) {
      showCustomSnackBar('Password should be 6 digit');
    }
    else {
      profile.usernameOrEmail=_emailController.text;
      profile.userPassword=_passwordController.text;
      profile.oneSignalId="";
      openLoadingDialog(context, "Loading");
      var response;
      response = await DioService.post('login', profile.toJson());
      if(response['status']=='success'){
        var jsonData= response['data'];
        UserDetail userDetail   =  UserDetail.fromJson(jsonData);
        AppData().userdetail =userDetail;
        print(AppData().userdetail!.toJson());
        Navigator.pop(context);
        Get.offAll(HomePage());
      }
      else{
        Navigator.pop(context);
        print(response['message']);
        showCustomSnackBar(response['message']);
      }

    }

  }
}
