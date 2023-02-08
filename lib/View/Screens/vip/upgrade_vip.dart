import 'package:flocdock/View/Screens/vip/widget/vip_feature.dart';
import 'package:flocdock/View/Widgets/my_button.dart';
import 'package:flocdock/View/base/simple_appbar.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flutter/material.dart';

class VIPUpgrade extends StatefulWidget {
  const VIPUpgrade({Key? key}) : super(key: key);

  @override
  State<VIPUpgrade> createState() => _VIPUpgradeState();
}

class _VIPUpgradeState extends State<VIPUpgrade> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KbgBlack,
      appBar: SimpleAppbar(description: "", pageName: "Upgrade to VIP plan",pageTrailing: Images.close,),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical :Dimensions.PADDING_SIZE_EXTRA_SMALL,horizontal: Dimensions.PADDING_SIZE_SMALL),
              decoration: BoxDecoration(
                color: KDullBlack,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: KdullWhite,width: 1)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text("VIP Membership",style: proximaBold.copyWith(color: KBlue,fontSize: Dimensions.fontSizeLarge),),
                          SizedBox(height: 2,),
                          Container(color: KBlue,height: 2,width: 115,),
                        ],
                      ),
                      Icon(Icons.keyboard_arrow_up,color: KWhite,size: 30,)
                    ],
                  ),
                  VIPFeature(feature: "No 3rd party ads"),
                  VIPFeature(feature: "All filters activated"),
                  VIPFeature(feature: "See unlimited guys / groups in Nearby page"),
                  VIPFeature(feature: "Can use saved phrases"),
                  VIPFeature(feature: "Can tap/chat with users in Discover page"),
                  VIPFeature(feature: "Can interact with groups in Discover page"),
                  VIPFeature(feature: "Can hide events you are participating in"),
                  VIPFeature(feature: "Can block unlimited number of profiles "),
                  VIPFeature(feature: "Can unblock blocked users 1 by 1"),
                  VIPFeature(feature: "Unlimited private pics requests"),
                  VIPFeature(feature: "Can upload more pictures in the album (6 public / 6 private)"),
                  VIPFeature(feature: "Can see if messages have been read in chat"),
                  SizedBox(height: 15,),
                  Text("To be discussed/optional:",style: proximaBold.copyWith(color: KBlue,fontSize: Dimensions.fontSizeExtraLarge),),
                  SizedBox(height: 5,),
                  VIPFeature(feature: "Can apply to a unlimited number of groups "),
                  VIPFeature(feature: "Can see who has viewed the profile "),
                  SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 30),
                    child: MyButton(
                      buttonColor: KMediumBlue,
                      textColor: KWhite,
                      text: "Upgrade",
                      size: Dimensions.fontSizeLarge,
                      buttonHight: 45.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.symmetric(vertical :Dimensions.PADDING_SIZE_EXTRA_SMALL,horizontal: Dimensions.PADDING_SIZE_SMALL),
              decoration: BoxDecoration(
                  color: KDullBlack,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: KdullWhite,width: 1)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text("Regular Membership",style: proximaBold.copyWith(color: KBlue,fontSize: Dimensions.fontSizeLarge),),
                          SizedBox(height: 2,),
                          Container(color: KBlue,height: 2,width: 145,),
                        ],
                      ),
                      Icon(Icons.keyboard_arrow_up,color: KWhite,size: 30,)
                    ],
                  ),
                  VIPFeature(feature: "All sort of ads"),
                  VIPFeature(feature: "Only use some of them (needs to still be determined)"),
                  VIPFeature(feature: "Can only see a limited number of profiles / groups"),
                  VIPFeature(feature: "Can use saved phrases",isAllow: false),
                  VIPFeature(feature: "Can only view"),
                  VIPFeature(feature: "Can hide events you are participating in",isAllow: false),
                  VIPFeature(feature: "Can only block a limited number per day"),
                  VIPFeature(feature: "Can only unlock all"),
                  VIPFeature(feature: "Can only request a limited number per day"),
                  VIPFeature(feature: "Can only upload 3 public / 3 private pictures"),
                  VIPFeature(feature: "Can see if messages have been read in chat",isAllow: false),
                  SizedBox(height: 15,),
                  Text("To be discussed/optional:",style: proximaBold.copyWith(color: KBlue,fontSize: Dimensions.fontSizeExtraLarge),),
                  SizedBox(height: 5,),
                  VIPFeature(feature: "Can apply to a limited number of groups per day"),
                  VIPFeature(feature: "Can see who has viewed the profile ",isAllow: false),
                  SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 30),
                    child: MyButton(
                      buttonColor: KMediumBlue,
                      textColor: KWhite,
                      text: "Upgrade",
                      size: Dimensions.fontSizeLarge,
                      buttonHight: 45.0,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
