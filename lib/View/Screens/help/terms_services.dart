import 'package:flocdock/View/Widgets/my_button.dart';
import 'package:flocdock/View/base/simple_appbar.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsServices extends StatefulWidget {
   const TermsServices({Key? key,}) : super(key: key);

  @override
  State<TermsServices> createState() => _TermsServicesState();
}

class _TermsServicesState extends State<TermsServices> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KbgBlack,
      appBar: SimpleAppbar(description: "", pageName: "Terms of Services",pageTrailing: "",),
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
            Text("1. Terms",style: proximaExtraBold.copyWith(color: KWhite)),
            SizedBox(height: 8,),
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
                "Nisi, morbi fringilla tristique urna nibh vel id iaculis egestas.",
                style: proximaSemiBold.copyWith(color: KWhite.withOpacity(0.8))
            ),
            SizedBox(height: 15,),
            Text("2. Use License",style: proximaExtraBold.copyWith(color: KWhite)),
            SizedBox(height: 8,),
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
                "Nisi, morbi fringilla tristique urna nibh vel id iaculis egestas.",
                style: proximaSemiBold.copyWith(color: KWhite.withOpacity(0.8))
            ),
            SizedBox(height: 20,),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyButton(
                    text: "Decline",
                    textColor: KWhite,
                    buttonColor: KDullBlack,
                    buttonHight: 30.0,
                    buttonWidth: 80.0,
                    onPressed: (){},
                  ),
                  SizedBox(width: 10,),
                  MyButton(
                    text: "Accept",
                    textColor: KWhite,
                    buttonColor: KMediumBlue,
                    buttonHight: 30.0,
                    buttonWidth: 80.0,
                    onPressed: (){},
                  )
                ],
              ),
            ),
            SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }
}
