import 'package:flocdock/View/Screens/chat/pictures_view.dart';
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

class PicturesPage extends StatefulWidget {
  int id;
  PicturesPage({Key? key,required this.id}) : super(key: key);

  @override
  _PicturesPageState createState() => _PicturesPageState();
}

class _PicturesPageState extends State<PicturesPage> {
  Pictures pictures=Pictures(recentImages: [],lastWeekImages: [],lastMonthImages: []);
  int recent=0,week=0,month=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getPictures();
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
                Text("Pictures",style: proximaBold.copyWith(color: KWhite)),
                SizedBox()
              ],
            ),
            SizedBox(height: 10,),
            Container(height:1,color: KDullBlack,),
            SizedBox(height: 10,),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    pictures.recentImages!.isNotEmpty?Container(
                      height: recent%3==0?recent/3*110:(recent+1)%3==0?(recent+1)/3*110:(recent+2)/3*110,
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 100,
                              crossAxisSpacing: 13,
                              mainAxisSpacing: 10
                          ),
                          itemCount: pictures.recentImages!.length,
                          itemBuilder: (BuildContext ctx, index){
                            return GestureDetector(
                              onTap: () => Get.to(PictureView(pictureDetail: pictures.recentImages![index],)),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        pictures.recentImages![index].picture??AppConstants.placeholder
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                      ),
                    ):SizedBox(),
                    SizedBox(height: week>0?5:0,),
                    week>0?Text("Last Week",style: proximaBold.copyWith(color: KDullBlack),):SizedBox(),
                    SizedBox(height: week>0?5:0,),
                    pictures.lastWeekImages!.isNotEmpty?Container(
                      height: week%3==0?week/3*110:(week+1)%3==0?(week+1)/3*110:(week+2)/3*110,
                      child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 100,
                              crossAxisSpacing: 13,
                              mainAxisSpacing: 10
                          ),
                          itemCount: pictures.lastWeekImages!.length,
                          itemBuilder: (BuildContext ctx, index){
                            return GestureDetector(
                              onTap: () => Get.to(PictureView(pictureDetail: pictures.lastWeekImages![index],)),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        pictures.lastWeekImages![index].picture??AppConstants.placeholder
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                      ),
                    ):SizedBox(),
                    SizedBox(height: month>0?5:0,),
                    month>0?Text("Last Month",style: proximaBold.copyWith(color: KDullBlack),):SizedBox(),
                    SizedBox(height: month>0?5:0,),
                    pictures.lastMonthImages!.isNotEmpty?Container(
                      height: month%3==0?month/3*110:(month+1)%3==0?(month+1)/3*110:(month+2)/3*110,
                      child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 100,
                              crossAxisSpacing: 13,
                              mainAxisSpacing: 10
                          ),
                          itemCount: pictures.lastMonthImages!.length,
                          itemBuilder: (BuildContext ctx, index){
                            return GestureDetector(
                              onTap: () => Get.to(PictureView(pictureDetail: pictures.lastMonthImages![index],)),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        pictures.lastMonthImages![1].picture??AppConstants.placeholder
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                      ),
                    ):SizedBox(),
                  ],
                ),
              ),
            ),
            // SizedBox(height: 5,),
            // Expanded(
            //   child: GridView.builder(
            //       physics: NeverScrollableScrollPhysics(),
            //       gridDelegate:
            //       const SliverGridDelegateWithMaxCrossAxisExtent(
            //           maxCrossAxisExtent: 100,
            //           crossAxisSpacing: 13,
            //           mainAxisSpacing: 13
            //       ),
            //       itemCount: pictures.recentImages!.length,
            //       itemBuilder: (BuildContext ctx, index){
            //         return GestureDetector(
            //           child: Container(
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(10),
            //               image: DecorationImage(
            //                 fit: BoxFit.cover,
            //                 image: NetworkImage(
            //                     pictures.recentImages![index].picture??AppConstants.placeholder
            //                 ),
            //               ),
            //             ),
            //           ),
            //         );
            //       }
            //   ),
            // ),
            // SizedBox(height: 10,),
            // Text("Last Month",style: proximaBold.copyWith(color: KDullBlack),),
            // SizedBox(height: 5,),
            // Expanded(
            //   child: GridView.builder(
            //       physics: NeverScrollableScrollPhysics(),
            //       gridDelegate:
            //       const SliverGridDelegateWithMaxCrossAxisExtent(
            //           maxCrossAxisExtent: 100,
            //           crossAxisSpacing: 13,
            //           mainAxisSpacing: 13
            //       ),
            //       itemCount: pictures.recentImages!.length,
            //       itemBuilder: (BuildContext ctx, index){
            //         return GestureDetector(
            //           child: Container(
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(10),
            //               image: DecorationImage(
            //                 fit: BoxFit.cover,
            //                 image: NetworkImage(
            //                     pictures.recentImages![index].picture??AppConstants.placeholder
            //                 ),
            //               ),
            //             ),
            //           ),
            //         );
            //       }
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
  void getPictures() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('chat_images_gallery', {
      "usersId" : AppData().userdetail!.usersId.toString(),
      "senderId" : widget.id.toString()
    });
    if(response['status']=='success'){
      var jsonData= response['data'];
      pictures=Pictures.fromJson(jsonData);
      recent=pictures.recentImages!.length;
      week=pictures.lastWeekImages!.length;
      month=pictures.lastMonthImages!.length;
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
