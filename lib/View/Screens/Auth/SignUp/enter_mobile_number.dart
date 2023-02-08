import 'dart:core';
import 'dart:core';
import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flocdock/View/Screens/Auth/SignUp/enter_code.dart';
import 'package:flocdock/View/Widgets/my_button.dart';
import 'package:flocdock/View/Widgets/my_spacing.dart';
import 'package:flocdock/View/Widgets/my_text.dart';
import 'package:flocdock/View/Widgets/my_text_field.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flocdock/models/user_model/signup_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EnterMobileNumber extends StatefulWidget {
  Profile? profile;
  EnterMobileNumber({Key? key,this.profile}) : super(key: key);

  @override
  _EnterMobileNumberState createState() => _EnterMobileNumberState();
}

class _EnterMobileNumberState extends State<EnterMobileNumber> {

  TextEditingController _mobileNumberController = TextEditingController();




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
                    "Mobile Number Verification. We’ll\nSend you a code.",
                    align: TextAlign.center,
                    fontFamily: "Proxima",
                    size: 17,
                    color: KWhite.withOpacity(0.5),
                  ),
                  spaceVertical(38),
                  MyTextField(
                    textInputType: TextInputType.text,
                    controller: _mobileNumberController,
                    isObSecure: false,
                    hintText: "+13017995969",
                  ),
                  spaceVertical(28),
                  MyButton(
                    onPressed: () {
                      widget.profile?.phoneNumber=_mobileNumberController.text;
                      print(widget.profile!.phoneNumber);
                      print(_mobileNumberController.text);
                   Get.to(EnterCode(profile: widget.profile,));
                    },
                    fontFamily: "Proxima",
                    size: 17,
                    text: "Send",
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
}
