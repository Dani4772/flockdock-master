import 'package:flocdock/View/Screens/AllowLocation/allow_location.dart';
import 'package:flocdock/View/Screens/Auth/Login/login_screen.dart';
import 'package:flocdock/View/Screens/Auth/SignUp/signup_screen.dart';
import 'package:flocdock/View/Screens/Auth/SocialAccounts/widget/socialButton.dart';
import 'package:flocdock/View/Widgets/my_button.dart';
import 'package:flocdock/View/Widgets/my_spacing.dart';
import 'package:flocdock/View/base/custom_snackbar.dart';
import 'package:flocdock/View/base/loading_dialog.dart';
import 'package:flocdock/api/signin_with_google.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flocdock/mixin/data.dart';
import 'package:flocdock/models/user_model/signup_model.dart';
import 'package:flocdock/services/dio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:the_apple_sign_in/scope.dart';

import '../../../../applesigninavailable.dart';
import '../../../../auth_services.dart';



class LoginWithSocial extends StatefulWidget {
  @override
  _LoginWithSocialState createState() => _LoginWithSocialState();
}

class _LoginWithSocialState extends State<LoginWithSocial> {
  Future<void> _signInWithApple(BuildContext context) async {
    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      final user = await authService.signInWithApple(
          scopes: [Scope.email, Scope.fullName]);
      print('uid: ${user.uid}');
    } catch (e) {
      // TODO: Show alert here
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final appleSignInAvailable =
    // Provider.of<AppleSignInAvailable>(context, listen: false);
    return Scaffold(
      backgroundColor: KbgBlack,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
          child: Column(
            children: [
              spaceVertical(200),
              Center(child: SvgPicture.asset(Images.logo,height: 76,width: 161,color: KWhite,)),
              spaceVertical(180),
              SocialButton(
                textWeight: FontWeight.w700,
                Img: Images.apple,
                size: 18,
                text: "Continue with Apple",
                fontFamily: "Proxima",
                textColor: KPureBlack,
                buttonColor: KWhite,
                onPressed: () {
                  _signInWithApple(context);
                },
                sizebox: 10,
              ),
              spaceVertical(14),
              SocialButton(
                Img: Images.google,
                textWeight: FontWeight.w700,
                size: 18,
                text: "Continue with Google",
                fontFamily: "Proxima",
                textColor: KWhite,
                buttonColor: KOrange,
                onPressed: signinWithGoogle,
              ),
              spaceVertical(14),
              MyButton(
                onPressed: (){
                  Get.to(() =>SignUpScreen());
                },
                buttonColor: KDullBlack,
                textColor: KWhite,
                textWeight: FontWeight.w700,
                text: "Create Account with e-mail",
                fontFamily: "Proxima",
                size: 18,
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<void> signinWithGoogle() async {

    print("getuserdetail");
    final user = await GoogleSignInApi.login();
    if(user!=null){
      print(user.toString());
      openLoadingDialog(context, "Loading");
      var response;
      response = await DioService.post('signup_with_social', {
        "userName":user.displayName,
        "userEmail":user.email,
        "accountType":"google",
        "userType":"1",
        "googleAccessToken" : user.id,
        "oneSignalId": "1234"
      });
      print(response);
      if(response['status']=='success / Signed in with Google'){
        var jsonData= response['data'];
        UserDetail userDetail   =  UserDetail.fromJson(jsonData);
        AppData().userdetail =userDetail;
        print(AppData().userdetail!.toJson());
        Navigator.pop(context);
        showCustomSnackBar(response['status'],isError: false);
        Get.to(() => AllowLocation());
      }
      else{
        Navigator.pop(context);
        print(response['message']);
        showCustomSnackBar(response['message']);
      }
    }
    else{
      showCustomSnackBar("User has canceled Login with Google");
    }


    //Get.to(() => SignInScreen());
  }
}
