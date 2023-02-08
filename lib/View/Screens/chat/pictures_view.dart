import 'package:flocdock/View/base/custom_snackbar.dart';
import 'package:flocdock/View/base/loading_dialog.dart';
import 'package:flocdock/View/base/simple_appbar.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flocdock/mixin/data.dart';
import 'package:flocdock/models/message/picture_model.dart';
import 'package:flocdock/services/dio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PictureView extends StatefulWidget {
  PictureDetail? pictureDetail;
  PictureView({Key? key,this.pictureDetail}) : super(key: key);

  @override
  _PictureViewState createState() => _PictureViewState();
}

class _PictureViewState extends State<PictureView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KbgBlack,
      appBar: SimpleAppbar(description: "Messages", pageName: "INBOX",pageTrailing: "",),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => Get.back(),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back_ios_rounded,color: KDullBlack,size: 20,),
                      Text("Back",style: proximaBold.copyWith(color: KdullWhite)),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(widget.pictureDetail!.userName??'',style: proximaBold.copyWith(color: KWhite,fontSize: Dimensions.fontSizeLarge)),
                    Text(widget.pictureDetail!.formattedDatetime??'',style: proximaRegular.copyWith(color: KWhite,fontSize: Dimensions.fontSizeSmall)),
                  ],
                ),
                SizedBox()
              ],
            ),
          ),
          Container(height:1,color: KDullBlack,),
          SizedBox(height: 15,),
          Expanded(child: SingleChildScrollView(child: Image.network(widget.pictureDetail!.picture??AppConstants.placeholder))),
        ],
      ),
    );
  }
}
