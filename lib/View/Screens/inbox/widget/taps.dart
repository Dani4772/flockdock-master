import 'package:flocdock/View/base/custom_image.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Tap extends StatelessWidget {
  String image;
  String title;
  String description;
  String time;
  bool isLive;
  Tap({Key? key,this.isLive=false,this.image="",this.title="",this.description="",this.time=""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width*0.2,
                height: MediaQuery.of(context).size.width*0.2,
                child: Stack(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          image.isNotEmpty?image:AppConstants.placeholder,
                          width: MediaQuery.of(context).size.width*0.2,
                          height: MediaQuery.of(context).size.width*0.2,
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
                    ):
                    Positioned(
                      right: 0,bottom: 4,
                      child: Container(
                        margin: EdgeInsets.only(left: 5,top: 5,right: 5),
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          color: KPureBlack,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SvgPicture.asset(Images.hot),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left:Dimensions.PADDING_SIZE_SMALL,top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     SizedBox(
                       width: MediaQuery.of(context).size.width*0.67,
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text(title,style: proximaBold.copyWith(color: KBlue,)),
                           //Expanded(child: SizedBox()),
                           Row(
                             crossAxisAlignment: CrossAxisAlignment.end,
                             children: [
                               Icon(Icons.access_time,size: 14, color: Colors.white.withOpacity(0.2)),
                               SizedBox(width: 5,),
                               Text(time,style: proximaRegular.copyWith(color: Colors.white.withOpacity(0.2),),),
                             ],
                           ),
                         ],
                       ),
                     ),
                     SizedBox(height: 5,),
                     Text("Sent you a Tap",style: proximaRegular.copyWith(color: KWhite.withOpacity(0.5),),),
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
}
