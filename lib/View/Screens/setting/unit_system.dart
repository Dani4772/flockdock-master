import 'package:flocdock/View/base/custom_snackbar.dart';
import 'package:flocdock/View/base/loading_dialog.dart';
import 'package:flocdock/View/base/simple_appbar.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flocdock/mixin/data.dart';
import 'package:flocdock/services/dio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

class UnitSystem extends StatefulWidget {
  String? unitSystem;
   UnitSystem({Key? key,this.unitSystem}) : super(key: key);

  @override
  State<UnitSystem> createState() => _UnitSystemState();
}

class _UnitSystemState extends State<UnitSystem> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KbgBlack,
      appBar: SimpleAppbar(description: "Unit System", pageName: "SETTINGS",pageTrailing: "",),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => Get.back(),
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back_ios_rounded,color: KDullBlack,size: 20,),
                      Text("BACK",style: proximaBold.copyWith(fontSize:16,color: KdullWhite)),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(height:0.5,width: MediaQuery.of(context).size.width*0.9,color: KDullBlack,),
            InkWell(
              onTap: (){
                if(widget.unitSystem=="Metrics")
                  return;
                widget.unitSystem="Metrics";
                updateUnitSystemPreference();
              },
              child: Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Metrics",style: proximaBold.copyWith(color: KBlue)),
                    widget.unitSystem=="Metrics"?SvgPicture.asset(Images.check,color: KBlue,height: 15,width: 15,):SizedBox(),
                  ],
                ),
              ),
            ),
            Container(height:0.5,width: MediaQuery.of(context).size.width*0.9,color: KDullBlack,),
            InkWell(
              onTap: () {
                if(widget.unitSystem=="Imperial")
                  return;
                widget.unitSystem="Imperial";
                updateUnitSystemPreference();
              },
              child: Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Imperial",style: proximaBold.copyWith(color: KBlue)),
                    SvgPicture.asset(Images.check,color: widget.unitSystem=="Imperial"?KBlue:Colors.transparent,height: 15,width: 15,),
                  ],
                ),
              ),
            ),
            Container(height:0.5,width: MediaQuery.of(context).size.width*0.9,color: KDullBlack,),

          ],
        ),
      ),
    );
  }
  void updateUnitSystemPreference() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('update_unit_system_preference', {
      "usersId" : AppData().userdetail!.usersId,
      "unitSystem" : widget.unitSystem
    });
    if(response['status']=='success'){
      showCustomSnackBar(response['data']);
      Navigator.pop(context);
      setState(() {});
    }
    else{
      Navigator.pop(context);
      print(response['message']);
      showCustomSnackBar(response['message']);
    }

  }
}
