import 'package:flocdock/View/Screens/Home/home_page.dart';
import 'package:flocdock/View/Widgets/my_spacing.dart';
import 'package:flocdock/View/Widgets/my_text.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SimpleAppbar extends StatelessWidget implements PreferredSizeWidget {

  String pageName;
  String description;
  String pageTrailing;
  bool isEvent;
  SimpleAppbar({Key? key,this.pageTrailing=Images.addFriends,required this.pageName,required this.description,this.isEvent=false}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: PreferredSize(
        child: Container(
            color: KPureBlack,
            constraints: BoxConstraints.expand(height: 50),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT),
              child: Row(
                children: [
                  MyText(
                    text: pageName,
                    color: KWhite,
                    fontFamily: "Proxima",
                    size: 30,
                    weight: FontWeight.w800,
                  ),
                  spaceHorizontal(8),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: MyText(
                      text: description,
                      fontFamily: "Proxima",
                      color: KdullWhite,
                      align: TextAlign.center,
                      size: 14,
                      weight: FontWeight.w700,
                    ),
                  ),
                  pageTrailing.isEmpty?SizedBox():
                      Expanded(child: Container()),
                  GestureDetector(
                    onTap: () => isEvent?Get.to(() => HomePage()):Get.back(),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: SvgPicture.asset(pageTrailing)
                    ),
                  )
                ],
              ),
            )),
        preferredSize: Size(50, 50),
      ),
    );
  }
}
