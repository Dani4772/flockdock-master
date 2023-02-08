import 'package:flocdock/View/Screens/chat/pictures_view.dart';
import 'package:flocdock/View/base/custom_snackbar.dart';
import 'package:flocdock/View/base/loading_dialog.dart';
import 'package:flocdock/View/base/simple_appbar.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flocdock/mixin/data.dart';
import 'package:flocdock/models/message/phrase_model.dart';
import 'package:flocdock/models/message/picture_model.dart';
import 'package:flocdock/services/dio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavedPhrase extends StatefulWidget {
  Function(String message)? sendPhrase;
  SavedPhrase({Key? key,this.sendPhrase}) : super(key: key);
  @override
  _SavedPhraseState createState() => _SavedPhraseState();
}

class _SavedPhraseState extends State<SavedPhrase> {
  List<PhraseDetail> phrases=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getPhrase();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KbgBlack,
      appBar: SimpleAppbar(description: "Messages", pageName: "INBOX",pageTrailing: "",),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                Text("Saved Phrases",style: proximaBold.copyWith(color: KWhite)),
                SizedBox()
              ],
            ),
            SizedBox(height: 10,),
            Container(height:1,color: KDullBlack,),
            SizedBox(height: 10,),
            ListView.builder(
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                //padding: EdgeInsetsGeometry.infinity,
                itemCount: phrases.length,
                itemBuilder: (context,index){
                  return GestureDetector(
                    onTap: (){
                      widget.sendPhrase!(phrases[index].phrase??'');
                      Get.back();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.9,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(phrases[index].phrase??'',style: proximaBold.copyWith(color: KBlue,fontSize: Dimensions.fontSizeExtraLarge)),
                          Container(height:1,color: KDullBlack,margin: EdgeInsets.symmetric(vertical: 10),),                      ],
                      ),
                    ),
                  );
                }
            ),
          ],
        ),
      ),
    );
  }
  void getPhrase() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.get('get_saved_phrases');
    if(response['status']=='success'){
      var jsonData= response['data'] as List;
      phrases=jsonData.map((e) => PhraseDetail.fromJson(e)).toList();
      setState(() {});
      Navigator.pop(context);
    }
    else{
      Navigator.pop(context);
      print(response['message']);
      showCustomSnackBar(response['message']);
    }
  }
}
