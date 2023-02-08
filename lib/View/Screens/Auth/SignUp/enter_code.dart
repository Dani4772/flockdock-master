import 'package:firebase_auth/firebase_auth.dart';
import 'package:flocdock/View/Screens/AllowLocation/allow_location.dart';
import 'package:flocdock/View/Widgets/my_button.dart';
import 'package:flocdock/View/Widgets/my_spacing.dart';
import 'package:flocdock/View/Widgets/my_text.dart';
import 'package:flocdock/View/Widgets/my_text_field.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flocdock/services/dio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../mixin/data.dart';
import '../../../../models/user_model/signup_model.dart';
import '../../../base/custom_snackbar.dart';
import '../../../base/loading_dialog.dart';
const _timer = 120;

class EnterCode extends StatefulWidget {
  Profile? profile;
   EnterCode({Key? key,this.profile}) : super(key: key);

  @override
  _EnterCodeState createState() => _EnterCodeState();
}

class _EnterCodeState extends State<EnterCode> {
  String? _verificationId;

  final _auth = FirebaseAuth.instance;
  TextEditingController _codeController = TextEditingController();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verifyNumber(widget.profile?.phoneNumber??"", context);
  }
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
                            text: "Sign Up",
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
                    "Enter the code we sent you on\nthe provided phone number.",
                    align: TextAlign.center,
                    fontFamily: "Proxima",
                    size: 17,
                    color: KWhite,
                  ),
                  spaceVertical(38),
                  MyTextField(
                    textInputType: TextInputType.number,
                    controller: _codeController,
                    isObSecure: false,
                    hintText: "Code",
                  ),
                  spaceVertical(28),
                  MyButton(
                    onPressed: matchOtp,
                    fontFamily: "Proxima",
                    size: 17,
                    text: "Submit",
                    textWeight: FontWeight.w700,
                    textColor: KWhite,
                    buttonColor: KMediumBlue,
                  ),
                  spaceVertical(15),
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: MyText(
                        text: "Didn’t receive code?",
                        fontFamily: "Proxima",
                        size: 17,
                        color: KWhite,
                        decoration: TextDecoration.underline,
                      )
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future verifyNumber(String phoneNumber, BuildContext context) async {
    print("hello i a here");
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
      codeSent: (String verificationId, [int? forceCodeResend])  {
        print("hey code sent");
        _verificationId = verificationId;
        showCustomSnackBar("Code Send Successfully",isError: false);
        print("hey code sent");
      },
      timeout:  Duration(seconds: _timer),
      verificationCompleted: (AuthCredential credential) async {
        FocusScope.of(context).requestFocus(FocusNode());
        Navigator.of(context).pop(true);
      },
      verificationFailed: (FirebaseAuthException exception) {
        print("shahzaib");
        showCustomSnackBar('${exception.message}');
        print('${exception.message}');
        print("shahzaib");

      },
    );
  }

  Future<bool> signInWithOTP(smsCode, verId) async {
    // showDialog(
    //   context: context,
    //   builder: (context) => WaitingDialog(message: 'Verifying Phone Number'),
    // );
    if(verId==null) return false;
    final credentials =
    PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);

    try {
      openLoadingDialog(context, "Verifying");
      final result = await _auth.signInWithCredential(credentials);
      Navigator.pop(context);
      if (result.user != null) {
        print(widget.profile!.toJson());
        openLoadingDialog(context, "Register");
        var response;
        response = await DioService.post('signup', widget.profile?.toJson());
        if(response['status']=='success'){
          var jsonData= response['data'];
          UserDetail userDetail   =  UserDetail.fromJson(jsonData);
          AppData().userdetail =userDetail;
          print(jsonData);
          print(AppData().userdetail!.toJson());
          Navigator.pop(context);
          Get.to(AllowLocation());

        }
        else{
          Navigator.pop(context);
          print("error");
          showCustomSnackBar(response['message']);

        }
      }
    } catch (e) {
      Navigator.pop(context);
      showCustomSnackBar("Failed"+e.toString());
    }
    return false;
  }

  void matchOtp() async {
    print("matching");
    if (await signInWithOTP(_codeController.text, _verificationId)) {
      /// Restore State of Guest User;
      /// ----------------------------
      ///
      FocusScope.of(context).requestFocus(FocusNode());
      Navigator.of(context).pop(true);
    }
  }
}
