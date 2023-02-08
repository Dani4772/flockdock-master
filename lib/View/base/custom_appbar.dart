import 'package:flocdock/View/Widgets/my_spacing.dart';
import 'package:flocdock/View/Widgets/my_text.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flocdock/mixin/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  String pageName;
  String description;
  String pageTrailing;
  bool isFilter;
  void Function()? onTap;
  void Function()? onTapFilter;
  CustomAppbar({Key? key,this.pageTrailing=Images.addFriends,required this.pageName,required this.description,this.onTap,this.onTapFilter,this.isFilter=false}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight+50);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent, // status bar color
    ));
    return AppBar(
      backgroundColor: KBlue,
      titleSpacing: 5,
      centerTitle: false,
      leading: InkWell(
        onTap: () => Scaffold.of(context).openDrawer(),
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0,top: 5,bottom: 5),
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(AppData().userdetail!.profilePicture??AppConstants.placeholder),
                    fit: BoxFit.cover)
            )
          ),
        ),
      ),
      title: SvgPicture.asset(
        Images.logo,
        height: 36,
        width: 77,
      ),
      actions: [
        if(isFilter)InkWell(
          onTap: onTapFilter,
          child: Row(
            children: [
              SvgPicture.asset(Images.filter),
              spaceHorizontal(5),
              MyText(
                text: "FILTERS",
                color: KbgBlack,
                size: 12,
                fontFamily: "Proxima",
                weight: FontWeight.w700,
              ),
              spaceHorizontal(5)
            ],
          ),
        ),
      ],
      bottom: PreferredSize(
        child: Container(
            color: KPureBlack,
            constraints: BoxConstraints.expand(height: 50),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_SMALL),
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
                  Expanded(child: Container()),
                  pageTrailing.isEmpty?SizedBox():Expanded(
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(onTap:onTap,child: SvgPicture.asset(pageTrailing))))
                ],
              ),
            )),
        preferredSize: Size(50, 50),
      ),
    );
  }
}
