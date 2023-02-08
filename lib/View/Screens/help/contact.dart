import 'package:flocdock/View/Widgets/my_button.dart';
import 'package:flocdock/View/Widgets/my_text_field.dart';
import 'package:flocdock/View/base/custom_snackbar.dart';
import 'package:flocdock/View/base/loading_dialog.dart';
import 'package:flocdock/View/base/simple_appbar.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flocdock/services/dio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Contact extends StatefulWidget {
   const Contact({Key? key,}) : super(key: key);

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KbgBlack,
      appBar: SimpleAppbar(description: "", pageName: "Contact",pageTrailing: "",),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => Get.back(),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_ios_rounded,color: KDullBlack,size: 20,),
                    Text("Back",style: proximaBold.copyWith(color: KdullWhite)),
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width*0.15,),
            Container(
              decoration: const BoxDecoration(
                color: KBlue,
                shape: BoxShape.circle
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SvgPicture.asset(Images.message),
              ),
            ),
            SizedBox(height: 8,),
            Text("Send us message",style: proximaExtraBold.copyWith(color: KWhite)),
            SizedBox(height: 5,),
            Text("Flock Dock  help you with your questions!",
                //textAlign: TextAlign.center,
                style: proximaSemiBold.copyWith(color: KDullBlack)
            ),
            SizedBox(height: MediaQuery.of(context).size.width*0.07,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyTextField(
                  verticalPadding: 1.0,
                  hight: 50.0,
                  width: MediaQuery.of(context).size.width*0.43,
                  textInputType: TextInputType.name,
                  controller: firstNameController,
                  isObSecure: false,
                  hintText: "First Name",
                ),
                MyTextField(
                  verticalPadding: 1.0,
                  hight: 50.0,
                  width: MediaQuery.of(context).size.width*0.43,
                  textInputType: TextInputType.name,
                  controller: lastNameController,
                  isObSecure: false,
                  hintText: "Last Name",
                ),
              ],
            ),
            SizedBox(height: 10,),
            MyTextField(
              verticalPadding: 1.0,
              hight: 50.0,
              textInputType: TextInputType.emailAddress,
              controller: emailController,
              isObSecure: false,
              hintText: "Email Address",
            ),
            SizedBox(height: 10,),
            MyTextField(
              radius: 10.0,
              minLines: 8,
              maxLines: 8,
              verticalPadding: 0.0,
              hight: 150.0,
              textInputType: TextInputType.multiline,
              controller: messageController,
              isObSecure: false,
              hintText: "Your Message....",
            ),
            SizedBox(height: MediaQuery.of(context).size.width*0.10,),
            MyButton(
              text: "Submit",
              textColor: KWhite,
              buttonColor: KMediumBlue,
              buttonHight: 50.0,
              onPressed: contactQueries,
            ),
          ],
        ),
      ),
    );
  }
  void contactQueries() async {
    if(firstNameController.text.trim().isEmpty)
      showCustomSnackBar("Enter first name");
    else if(lastNameController.text.trim().isEmpty)
      showCustomSnackBar("Enter last name");
    else if(emailController.text.trim().isEmpty)
      showCustomSnackBar("Enter Email");
    else if(messageController.text.trim().isEmpty)
      showCustomSnackBar("Enter message");
    else{
      openLoadingDialog(context, "Loading");
      var response;
      response = await DioService.post('contact_queries', {
        "firstName": firstNameController.text.toString(),
        "lastName": lastNameController.text.toString(),
        "email": emailController.text.toString(),
        "message": messageController.text.toString()
      });
      if(response['status']=='success'){
        showCustomSnackBar(response['data'],isError: false);
        Navigator.pop(context);
        firstNameController.clear();
        lastNameController.clear();
        emailController.clear();
        messageController.clear();
        setState(() {});
      }
      else{
        Navigator.pop(context);
        print("error");
        showCustomSnackBar(response['message']);
      }
    }
  }
}
