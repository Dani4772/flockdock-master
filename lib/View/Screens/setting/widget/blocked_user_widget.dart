import 'package:flocdock/View/base/custom_image.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BlockedUserCard extends StatelessWidget {
  String img;
  String title;
  String description;
  bool isLive;
  void Function()? onTapUnblock;
  BlockedUserCard({Key? key,this.isLive=false,this.title="GUY4GR",this.description="Hey man, long time no see!",this.img="",this.onTapUnblock}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width*0.9,
            margin: EdgeInsets.symmetric(vertical: 10),
            child:Row(
              children: [
              Stack(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        img.isNotEmpty?img:AppConstants.placeholder,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      )
                  ),
                  isLive?Positioned(
                    right: 0,bottom: 4,
                    child: Container(
                      margin: EdgeInsets.only(left: 5,top: 5,right: 5),
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        color: Colors.lightGreenAccent.shade400,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ):SizedBox()
                  // Positioned(
                  //   right: 0,bottom: 4,
                  //   child: Container(
                  //     margin: EdgeInsets.only(left: 5,top: 5,right: 5),
                  //     height: 20,
                  //     width: 20,
                  //     decoration: BoxDecoration(
                  //       color: KPureBlack,
                  //       shape: BoxShape.circle,
                  //     ),
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(4.0),
                  //       child: SvgPicture.asset(Images.hot),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
                SizedBox(width: MediaQuery.of(context).size.width*0.05,),
              Container(
                  width: 110,
                  child: Text(title,style: proximaBold.copyWith(color: KBlue,))),
              SizedBox(width: MediaQuery.of(context).size.width*0.1,),
              InkWell(
                onTap: onTapUnblock,
                child: Container(
                  decoration: BoxDecoration(
                      color: KdullWhite,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  padding: EdgeInsets.all(8),
                  child: Text("Unblock",style: proximaBold.copyWith(color: KWhite,)),
                ),
              ),

              // ListTile(
              //   horizontalTitleGap: 10,
              //   minLeadingWidth: 0,
              //   leading: Stack(
              //     children: [
              //       ClipRRect(
              //           borderRadius: BorderRadius.circular(10),
              //           child: Image.network(
              //             img.isNotEmpty?img:AppConstants.placeholder,
              //             height: 60,
              //             width: 60,
              //             fit: BoxFit.cover,
              //           )
              //       ),
              //       isLive?Positioned(
              //         right: 0,bottom: 4,
              //         child: Container(
              //           margin: EdgeInsets.only(left: 5,top: 5,right: 5),
              //           height: 8,
              //           width: 8,
              //           decoration: BoxDecoration(
              //             color: Colors.lightGreenAccent.shade400,
              //             shape: BoxShape.circle,
              //           ),
              //         ),
              //       ):SizedBox()
              //       // Positioned(
              //       //   right: 0,bottom: 4,
              //       //   child: Container(
              //       //     margin: EdgeInsets.only(left: 5,top: 5,right: 5),
              //       //     height: 20,
              //       //     width: 20,
              //       //     decoration: BoxDecoration(
              //       //       color: KPureBlack,
              //       //       shape: BoxShape.circle,
              //       //     ),
              //       //     child: Padding(
              //       //       padding: const EdgeInsets.all(4.0),
              //       //       child: SvgPicture.asset(Images.hot),
              //       //     ),
              //       //   ),
              //       // ),
              //     ],
              //   ),
              //   title: Text(title,style: proximaBold.copyWith(color: KBlue,)),
              //   trailing: InkWell(
              //     onTap: onTapUnblock,
              //     child: Container(
              //       decoration: BoxDecoration(
              //           color: KdullWhite,
              //           borderRadius: BorderRadius.circular(20)
              //       ),
              //       padding: EdgeInsets.all(8),
              //       child: Text("Unblock",style: proximaBold.copyWith(color: KWhite,)),
              //     ),
              //   ),
              // ),
    ],),

        ),
        Container(height:0.5,width: MediaQuery.of(context).size.width*0.9,color: KDullBlack,),
      ],
    );
  }
}
