import 'package:flocdock/View/Screens/Auth/Login/login_screen.dart';
import 'package:flocdock/View/Screens/Auth/SignUp/enter_mobile_number.dart';
import 'package:flocdock/View/Widgets/my_button.dart';
import 'package:flocdock/View/Widgets/my_spacing.dart';
import 'package:flocdock/View/Widgets/my_text.dart';
import 'package:flocdock/View/Widgets/my_text_field.dart';
import 'package:flocdock/View/base/custom_snackbar.dart';
import 'package:flocdock/View/base/loading_dialog.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flocdock/models/user_model/signup_model.dart';
import 'package:flocdock/services/dio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../constants/styles.dart';
//import '../../../Widgets/edit_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  Profile profile=Profile();
  bool _value = false;
  final gender = ['Male','Female','Other','Unspecified'];
  String value = "Gender";
  String birthday="Birthday";
  String date="";
  DateTime selectedDate=DateTime.now();
  String DOB=DateFormat("dd MMM, yyyy").format(DateTime.now());
  UserDetail userDetail=UserDetail(userSeeking: [],userTribes: []);
  static List<String> genders=['Male','Female','Other','Unspecified'];
  String val="Gender";
  int index = 0;


  DateTime checkInDate = DateTime.now();

  Future<Null> selectTimePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        builder: (context, child)=>Theme(data: ThemeData().copyWith(
          colorScheme: const ColorScheme.dark(
            surface: KDullBlack,
            primary: KBlue,
            onSurface: KWhite,
            secondary: KWhite,
          ),
          indicatorColor: KWhite,
          dialogBackgroundColor: KDullBlack
        ), child: child!,
        ),
        initialDate: checkInDate,
        firstDate: DateTime(1970),
        lastDate: DateTime.now(),
    );
    if (picked != null || picked != checkInDate) {
      setState(() {
        checkInDate = picked!;
        birthday=DateFormat("dd MMM, yyyy").format(checkInDate);
        print(checkInDate.toString());
      });
    }
  }

  DateTime CheckOutdate = DateTime(DateTime.now().year - 15, DateTime.now().month, DateTime.now().day);

  Future<Null> selectTimePicker2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: CheckOutdate,
        firstDate: DateTime(1998),
        lastDate: DateTime(2030));
    if (picked != null || picked != CheckOutdate) {
      setState(() {
        CheckOutdate = picked!;
        print(CheckOutdate.toString());
      });
    }
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: MyText(
        text: item,
        fontFamily: "Proxima",
        size: 16,
        color: KWhite,
      ));
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: KbgBlack,
        body: Scrollbar(
          isAlwaysShown: false,
          hoverThickness: 0.01,
          thickness: 0.01,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  spaceVertical(70),
                  Center(child: SvgPicture.asset(Images.logo,height: 76,width: 161,color: KWhite,)),
                  spaceVertical(50),
                  Center(
                    child: MyText(
                      size: 24,
                      fontFamily: "Proxima",
                      text: "Sign Up",
                      color: KWhite,
                      weight: FontWeight.w700,
                    ),
                  ),
                  spaceVertical(50),
                  MyTextField(
                    textInputType: TextInputType.text,
                    controller: _userNameController,
                    isObSecure: false,
                    hintText: "Username",
                  ),
                  spaceVertical(14),
                  MyTextField(
                    textInputType: TextInputType.emailAddress,
                    controller: _emailController,
                    isObSecure: false,
                    hintText: "Email address",
                  ),
                  spaceVertical(14),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,

                          decoration: BoxDecoration(
                              color: KDullBlack,
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.PADDING_SIZE_SMALL+1),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () async{
                                    DateTime? selected;
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                            color: KWhite,
                                            height: 400,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Expanded(
                                                  child: CupertinoDatePicker(
                                                    onDateTimeChanged: (DateTime date) {
                                                      selected=date;
                                                    },
                                                    mode: CupertinoDatePickerMode.date,
                                                    initialDateTime: selectedDate,
                                                    //backgroundColor: Colors.grey,

                                                    minimumDate: DateTime(1970),
                                                    maximumDate: DateTime.now(),
                                                  ),
                                                ),
                                                CupertinoButton(
                                                  child: Text("Ok",style: proximaBold.copyWith(color: KBlue)),
                                                 // child: Text("OK",style: proximaBold.copyWith(color: KBlue)),
                                                  onPressed: () {
                                                    if (selected!=null && selected != selectedDate) {
                                                      print(selected);
                                                      selectedDate = selected!;
                                                      DOB=DateFormat("dd MMM, yyyy").format(selectedDate);
                                                      userDetail.birthday=DateFormat("yyyy-MM-dd").format(selectedDate);
                                                      //birthday = selected;
                                                      print(DOB);
                                                      print(userDetail.birthday);
                                                      birthday = userDetail.birthday.toString();
                                                      setState(() {});
                                                    }
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  child: Container(
                                    height: 25,
                                    width: 125,
                                  //color: Colors.white,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: KDullBlack,
                                    ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left:5.0),
                                        child: Text(DOB,

                                          style: TextStyle(
                                            color: KWhite.withOpacity(0.5),
                                            fontFamily: "Proxima",
                                            fontSize: 16
                                        ),
                                        ),
                                      ),
                                      spaceHorizontal(10),
                                      Container(
                                        height: 30,
                                        width: 13,
                                        child:SvgPicture.asset(
                                        Images.calendar,
                                        color: KWhite.withOpacity(0.5),
                                      ),),
                                    ],
                                  ),
                                  ),
                                  //child: EditField(isEnabled: false,controller: TextEditingController(text: DOB),),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      spaceHorizontal(12),
                      // Expanded(
                      //     child: Container(
                      //   height: 50,
                      //   decoration: BoxDecoration(
                      //       color: KDullBlack,
                      //       borderRadius: BorderRadius.circular(30)),
                      //   child: Padding(
                      //       padding: const EdgeInsets.symmetric(
                      //           horizontal: Dimensions.PADDING_SIZE_SMALL+10),
                      //       child: DropdownButtonHideUnderline(
                      //         child: DropdownButton<String>(
                      //             value: value,
                      //             icon: SvgPicture.asset(
                      //               Images.arrowDown,
                      //               height: 9,
                      //               width: 9,
                      //               color: KWhite.withOpacity(0.5),
                      //             ),
                      //             dropdownColor: KDullBlack,
                      //             hint: MyText(
                      //               text: "Gender",
                      //               color: KWhite.withOpacity(0.5),
                      //               size: 16,
                      //               fontFamily: "Proxima",
                      //             ),
                      //             isExpanded: true,
                      //             items: gender.map(buildMenuItem).toList(),
                      //             onChanged: (value) => setState(() {
                      //                   this.value = value;
                      //                 })),
                      //       )),
                      // )),

                      Expanded(
                        child: Container(
                          height: 50,

                          decoration: BoxDecoration(
                              color: KDullBlack,
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.PADDING_SIZE_SMALL+1),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () async{
                                    //DateTime? selected;
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context){
                                          return Container (
                                            color:KWhite,
                                            height: 400,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                CupertinoButton(
                                                  child: Text("Cancel",style: proximaBold.copyWith(color: KBlue)),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                Expanded(

                                                  child: CupertinoPicker(
                                                      scrollController: FixedExtentScrollController(
                                                        initialItem: genders.indexWhere((element) => userDetail.gender==element),
                                                      ),
                                                      itemExtent: 50.0,
                                                      onSelectedItemChanged: (int index) {
                                                        value = genders[index];
                                                      },
                                                      children:  genders.map((e) => Center(child: Text(e,style: proximaBold.copyWith(color: KPureBlack,fontSize: 24),),),).toList()
                                                  ),
                                                ),
                                                CupertinoButton(
                                                  child: Text("Ok",style: proximaBold.copyWith(color: KBlue)),
                                                  onPressed: () {
                                                    userDetail.gender=value;
                                                    setState(() {

                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                    );
                                  },
                                  child: Container(
                                    height: 25,
                                    width: 125,
                                    //color: Colors.white,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: KDullBlack,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left:5.0),
                                          child: Text(value.toString(),style: TextStyle(color: KWhite.withOpacity(0.5),
                                              fontFamily: "Proxima",
                                              fontSize: 16)),


                                        ),
                                        spaceHorizontal(10),
                                        Icon(Icons.arrow_drop_down_rounded,color: KWhite.withOpacity(0.5),),
                                        // Container(
                                        //   height: 30,
                                        //   width: 15,
                                        //   child:SvgPicture.asset(
                                        //     Images.calendar,
                                        //     color: KWhite.withOpacity(0.5),
                                        //   ),),
                                      ],
                                    ),
                                  ),
                                  //child: EditField(isEnabled: false,controller: TextEditingController(text: DOB),),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  spaceVertical(12),
                  MyTextField(
                    textInputType: TextInputType.visiblePassword,
                    controller: _passwordController,
                    isObSecure: true,
                    hintText: "Password",
                  ),
                  spaceVertical(12),
                  MyTextField(
                    textInputType: TextInputType.visiblePassword,
                    controller: _confirmPasswordController,
                    isObSecure: true,
                    hintText: "Confirm password",
                  ),
                  spaceVertical(20),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _value = !_value;
                                });
                              },
                              child: Container(
                                height: 22,
                                width: 22,
                                decoration: BoxDecoration(
                                    color: KDullBlack,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: _value
                                      ? SvgPicture.asset(
                                          Images.check,
                                    color: KBlue,
                                        )
                                      : SizedBox()
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                        spaceHorizontal(Dimensions.PADDING_SIZE_LARGE),
                        Expanded(
                          child: MyText(
                            text:
                                "I accept the terms, privacy policy, and conditions of cookies policy.",
                            color: KWhite,
                            weight: FontWeight.w400,
                            fontFamily: "Proxima",
                            size: 16,
                            maxLines: 2,
                          ),
                        )
                      ],
                    ),
                  ),
                  spaceVertical(20),
                  MyButton(
                    text: "Register",
                    size: 22,
                    fontFamily: "Proxima",
                    textWeight: FontWeight.w700,
                    onPressed: _register,
                    buttonColor: KMediumBlue,
                    textColor: KWhite,
                  ),
                  spaceVertical(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText(
                        text: "Already have an account?",
                        size: 16,
                        fontFamily: "Proxima",
                        color: KBlue,
                        weight: FontWeight.w700,
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(LoginScreen());
                        },
                        child: MyText(
                          text: "Log In",
                          weight: FontWeight.w700,
                          size: 16,
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
      ),
    );
  }
  void _register() async {
    if (_userNameController.text.isEmpty) {
      showCustomSnackBar('Enter User Name');
    }
    else if (_emailController.text.isEmpty) {
      showCustomSnackBar('Enter Email');
    }
    else if (birthday.isEmpty) {
      showCustomSnackBar('Select Birthday');
    }
    // else if (DateTime.now().difference(checkInDate).inDays<6574) {
    //   showCustomSnackBar('You are UnderAge');
    // }
    else if (value==null) {
      showCustomSnackBar('Select Gender');
    }
    else if (_passwordController.text.isEmpty) {
      showCustomSnackBar('Enter Password');
    }else if (_passwordController.text.length < 6) {
      showCustomSnackBar('Password should be 6 digit');
    }
    else if (_passwordController.text!=_confirmPasswordController.text) {
      showCustomSnackBar('Confirm password does not matched');
    }
    else if (!_value) {
      showCustomSnackBar('Accept term and conditions');
    }
    else{
      profile.userName=_userNameController.text;
      profile.userEmail=_emailController.text;
      profile.birthday=DateFormat("yyyy-MM-dd").format(checkInDate);
      profile.gender=value;
      profile.userPassword=_passwordController.text;
      profile.confirmPassword=_confirmPasswordController.text;
      profile.oneSignalId="123";
      print(profile.toJson());
      openLoadingDialog(context, "Loading");
      var response;
      response = await DioService.post('check_already_registered', {
        "userName":profile.userName,
        "userEmail":profile.userEmail,
      });
      if(response['status']=='success'){
        Navigator.pop(context);
        Get.to(EnterMobileNumber(profile: profile,));
      }
      else{
        Navigator.pop(context);
        print("error");
        showCustomSnackBar(response['message']);
      }
    }

  }
}
