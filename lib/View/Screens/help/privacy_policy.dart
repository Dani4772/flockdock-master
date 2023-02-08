import 'package:flocdock/View/base/simple_appbar.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacyPolicy extends StatefulWidget {
   const PrivacyPolicy({Key? key,}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KbgBlack,
      appBar: SimpleAppbar(description: "", pageName: "Privacy Policy",pageTrailing: "",),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            SizedBox(height: 15,),
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Viverra sed nibh "
                "lacus, arcu. Nisl vel tellus tempus maecenas. Mi arcu rhoncus, "
                "mi elit mi ut ornarequam.Condimentum accumsan leo tincidunt in enim. "
                "Quis aliquam et elementum sed mauris lorem. A, cursus blandit risus ultrices."
                " Vulputate nisl ullamcorper sed ut orci, turpis. Mauris id proin eget rhoncus."
                " Amet fames et etiam facilisi tempor nisl. Amet, a aliquet pretium vel. "
                "Nisl, purus odio tellus vulputate ornare nam. Aliquam ac ullamcorper odio sit. "
                "Sodales amet sit pretium ante molestie enim donec facilisis. "
                "Magna cursus aliquet nibh mauris risus.Sit duis sit pharetra elementum mi sodales id. "
                "Sollicitudin odio ante pellentesque ac non arcu. Quisque tortor id nisl malesuada "
                "morbi sed in. Commodo, tincidunt convallis condimentum pellentesque. "
                "Tellus dui velit, ullamcorper aliquet ut feugiat nunc faucibus elit. "
                "Neque dolor, enim tristique et nulla cras. Hac leo at adipiscing posuere integer luctus. "
                "Nisi, morbi fringilla tristique urna nibh vel id iaculis egestas. \nCras enim, "
                "enim dolor vitae nibh etiam non id. Non odio adipiscing nibh pharetra elementum "
                "pretium erat id quis.Cras nec nec purus ut sed. Erat lectus in augue tempus massa "
                "egestas vel, enim. Nibh vitae odio a consectetur ipsum at condimentum malesuada nunc. "
                "Magna dictum elementum enim venenatis sit amet adipiscing quis. Tellus senectus purus "
                "quis enim eu pellentesque. Mi nibh consectetur pulvinar leo nunc. Egestas pellentesque"
                " suscipit volutpat scelerisque id adipiscing amet. Eu senectus aliquam volutpat aliquam "
                "sed lectus sit. Eget in quam sit risus. Nullam nunc arcu at vitae enim eget risus et. "
                "Eget id at rutrum ut sed non.Cras ut erat vitae habitasse leo urna tristique mollis "
                "ultrices. Ipsum id gravida justo condimentum. Et id sapien, senectus luctus",
                style: proximaSemiBold.copyWith(color: KWhite.withOpacity(0.8))),

          ],
        ),
      ),
    );
  }
}
