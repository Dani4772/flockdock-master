import 'package:flocdock/View/Widgets/my_spacing.dart';
import 'package:flocdock/View/Widgets/my_text.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
Widget ProfileWidget({
  required String img,required String profileName,required String distance, required bool isOnline
})
{
  return Stack(children: <Widget>[
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          fit: BoxFit.cover,
          
          image: NetworkImage(
              img.isNotEmpty?img:AppConstants.placeholder,
            
          ),
        ),
      ),
    ),
    Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.center,
              colors: [
                Colors.black.withOpacity(1),
                Colors.transparent,
              ],
              stops: [
                0.0,
                1.0
              ]),

      ),
       child: Container(
         decoration: BoxDecoration(
         //color: Colors.transparent,
           borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.center,
            colors: [
              Colors.black.withOpacity(1),
              Colors.transparent,
            ],
                //tileMode: TileMode.mirror,
              stops: [
                0.0,
                1.0
            ]),

          ),

        child: Padding(
          padding:  EdgeInsets.symmetric(vertical:2,horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
          child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            MyText(
              text: profileName,
              size: 13,
              weight: FontWeight.w800,
              color: KWhite,
              fontFamily: "Proxima",
            ),
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                        Images.locationIcon),
                    spaceHorizontal(4),
                    MyText(
                      size: 12,
                      text: distance.length>6?distance:distance+" km",
                      color: KWhite,
                      fontFamily: "Proxima",
                    ),
                  ],
                ),
                isOnline?Container(
                  height: 12,
                  width: 12,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                  ),
                ):SizedBox()
              ],
            )
          ],
        ),
      ),
    ),
    )
  ]);
}
Widget GroupWidget({double? width, required String img, required String groupName, required String distance, required String groupMembers,}) {
  return Stack(
    children: [
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(image: NetworkImage(img), fit: BoxFit.cover)
        ),
      ),
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: [
                  Colors.black.withOpacity(1),
                  Colors.transparent,
                ],
                stops: [
                  0.0,
                  1.0
                ])),

        child: Container(
                  decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.center,
                colors: [
                  Colors.black.withOpacity(1),
                  Colors.transparent,
                ],
                stops: [
                    0.0,
                    1.0
                ])),
          child: Padding(
          padding: const EdgeInsets.only(right: 5, left: 5, bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 15,),
              MyText(
                text: groupName,
                fontFamily: "Proxima",
                color: KWhite,
                weight: FontWeight.w800,
                size: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        SvgPicture.asset(Images.locationIcon),
                        spaceHorizontal(5),
                        MyText(
                          text: distance+" km",
                          size: 12,
                          weight: FontWeight.w400,
                          color: KWhite,
                          fontFamily: "Proxima",
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        SvgPicture.asset(Images.GroupIcon),
                        spaceHorizontal(5),
                        MyText(
                          text: groupMembers,
                          size: 12,
                          weight: FontWeight.w400,
                          color: KWhite,
                          fontFamily: "Proxima",
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      ),
    ],
  );
}
Widget ProfileContainer({required String img,required String profileName,
  required String distance,required bool isSelected,}){
  return Stack(children: <Widget>[
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
              img.isNotEmpty?img:AppConstants.placeholder
          ),
        ),
      ),
    ),
    Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.7),
                Colors.grey.withOpacity(0.0),
              ],
              stops: [
                0.0,
                1.0
              ])
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical:2,horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            MyText(
              text: profileName,
              size: 14,
              weight: FontWeight.w800,
              color: KWhite,
              fontFamily: "Proxima",
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                        Images.locationIcon),
                    spaceHorizontal(4),
                    MyText(
                      size: 12,
                      text: distance,
                      weight: FontWeight.w700,
                      color: KWhite,
                      fontFamily: "Proxima",
                    ),
                  ],
                ),
                Container(
                  height: 18,
                  width: 18,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected?KBlue:null,
                      border: Border.all(width:2,color: KWhite)
                  ),
                  child: Center(child: isSelected?Icon(Icons.check,color: KWhite,size: 12,):SizedBox()),
                )
              ],
            )
          ],
        ),
      ),
    )
  ]);
}

