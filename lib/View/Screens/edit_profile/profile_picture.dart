
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flocdock/View/Screens/edit_profile/widget/update_dialog.dart';
import 'package:flocdock/View/base/custom_snackbar.dart';
import 'package:flocdock/View/base/loading_dialog.dart';
import 'package:flocdock/View/base/simple_appbar.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flocdock/mixin/data.dart';
import 'package:flocdock/models/user_model/picture_model.dart';
import 'package:flocdock/services/dio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePicture extends StatefulWidget {
  const EditProfilePicture({Key? key}) : super(key: key);

  @override
  State<EditProfilePicture> createState() => _EditProfilePictureState();
}

class _EditProfilePictureState extends State<EditProfilePicture> {

  //
  // File? _image;
  //
  // Future _pickedImage(ImageSource source) async{
  //
  //   try{
  //     final image = await ImagePicker().pickImage(source: source);
  //     if(image == null) return;
  //     File? img = File(image.path);
  //    // img = await _cropImage(imageFile: img);
  //     setState(() {
  //       _image = img;
  //     });
  //   }
  //   on PlatformException catch (e){
  //     print(e);
  //   }
  // }


  // Future<File?> _cropImage({required File imageFile}) async{
  //   CroppedFile? croppedImage =
  //       await ImageCropper().cropImage(sourcePath:imageFile.path);
  //   if(croppedImage ==null) return null;
  //   return File(croppedImage.path);
  // }

  final picker = ImagePicker();
  String imagePath = "";
  PickedFile pickedFile=PickedFile("");
  String image="";
  PictureData pictureData=PictureData(visiblePictures: [],privatePictures: []);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getUserPictures();
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KbgBlack,
      appBar: SimpleAppbar(description: "Upload/Edit", pageName: "PICTURES",pageTrailing: Images.close,),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_LARGE),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.03),
            Text("PROFILE PICTURES", style: proximaBold.copyWith(color: KBlue),),
            SizedBox(height: MediaQuery.of(context).size.height*0.02),
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(1),
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      color: KBlue,
                      shape: BoxShape.circle
                  ),
                  child: ClipOval(
                      child: Image.network(
                        AppData().userdetail!.profilePicture??AppConstants.placeholder,
                        fit: BoxFit.cover,
                      )
                  ),
                ),
                Positioned(
                  bottom: 3,right: 3,
                  child: InkWell(
                    onTap: () => Get.dialog(EditDelete(
                      onEditTap: () async {
                        // _pickedImage(ImageSource.gallery);
                        pickedFile = await ImagePicker().getImage(source: ImageSource.gallery) as PickedFile ;
                        // image = await _cropImage(pickedFile);
                        CroppedFile? croppedFile = await ImageCropper().cropImage(
                          sourcePath: pickedFile.path,
                          aspectRatioPresets: [
                            CropAspectRatioPreset.square,
                            CropAspectRatioPreset.ratio3x2,
                            CropAspectRatioPreset.original,
                            CropAspectRatioPreset.ratio4x3,
                            CropAspectRatioPreset.ratio16x9
                          ],
                          uiSettings: [
                            AndroidUiSettings(
                                toolbarTitle: 'Cropper',
                                toolbarColor: Colors.deepOrange,
                                toolbarWidgetColor: Colors.white,
                                initAspectRatio: CropAspectRatioPreset.original,
                                lockAspectRatio: false),
                            IOSUiSettings(
                              title: 'Cropper',
                            ),
                            WebUiSettings(
                              context: context,
                            ),
                          ],
                        );
                        if (croppedFile != null) {
                          setState(() {
                            imagePath = croppedFile.path;
                          });
                        }
                        Navigator.pop(context);
                        uploadProfilePicture();
                      },
                      onDeleteTap: (){
                        Get.back();
                        deleteProfilePicture();
                      },
                    )),
                    child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: KBlue
                        ),
                        child: SvgPicture.asset(Images.edit,height: 12,width: 12,color: KPureBlack,)
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.03),
            Text("VISIBLE", style: proximaBold.copyWith(color: KBlue),),
            SizedBox(height: 15),
            Row(
              children: [
                pictureData.visiblePictures!.isNotEmpty?Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width*0.9,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: pictureData.visiblePictures!.length,
                      itemBuilder: (context,index){
                        return index+1==pictureData.visiblePictures!.length?Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Stack(
                                children: [
                                  ClipOval(
                                    child: Image.network(
                                      pictureData.visiblePictures![index].picture??'',
                                      height: 60,
                                      width: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,right: 0,
                                    child: InkWell(
                                      onTap: () => deleteUserPicture(pictureData.visiblePictures![index].userPictureId.toString()),
                                      child: Container(
                                          padding: EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: KBlue
                                          ),
                                          child: SvgPicture.asset(Images.delete,height: 10,width: 10,)
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                pickedFile = await ImagePicker().getImage(source: ImageSource.gallery) as PickedFile ;
                                uploadUserPicture("Visible");
                              },
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: KBlue
                                ),
                                child: Center(child: SvgPicture.asset(Images.add,height: 25,width: 25,color: KPureBlack,)),
                              ),
                            ),
                          ],
                        ):
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Stack(
                            children: [
                              ClipOval(
                                child: Image.network(
                                  pictureData.visiblePictures![index].picture??'',
                                  height: 60,
                                  width: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                bottom: 5,right: 5,
                                child: InkWell(
                                  onTap: () => deleteUserPicture(pictureData.visiblePictures![index].userPictureId.toString()),
                                  child: Container(
                                      padding: EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: KBlue
                                      ),
                                      child: SvgPicture.asset(Images.delete,height: 10,width: 10,)
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }
                  ),
                ):
                GestureDetector(
                  onTap: () async {
                    pickedFile = await ImagePicker().getImage(source: ImageSource.gallery) as PickedFile ;
                    uploadUserPicture("Visible");
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    margin: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: KBlue
                    ),
                    child: Center(child: SvgPicture.asset(Images.add,height: 25,width: 25,color: KPureBlack,)),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.03),
            Text("PRIVATE", style: proximaBold.copyWith(color: KBlue),),
            SizedBox(height: 15),
            Row(
              children: [
                pictureData.privatePictures!.isNotEmpty?Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width*0.9,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: pictureData.privatePictures!.length,
                      itemBuilder: (context,index){
                        return index+1==pictureData.privatePictures!.length?Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Stack(
                                children: [
                                  ClipOval(
                                    child: Image.network(
                                      pictureData.privatePictures![index].picture??'',
                                      height: 60,
                                      width: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,right: 0,
                                    child: InkWell(
                                      onTap: () => deleteUserPicture(pictureData.privatePictures![index].userPictureId.toString()),
                                      child: Container(
                                          padding: EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: KBlue
                                          ),
                                          child: SvgPicture.asset(Images.delete,height: 10,width: 10,)
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                pickedFile = await ImagePicker().getImage(source: ImageSource.gallery) as PickedFile ;
                                uploadUserPicture("Private");
                              },
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: KBlue
                                ),
                                child: Center(child: SvgPicture.asset(Images.add,height: 25,width: 25,color: KPureBlack,)),
                              ),
                            ),
                          ],
                        ):
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Stack(
                            children: [
                              ClipOval(
                                child: Image.network(
                                  pictureData.privatePictures![index].picture??'',
                                  height: 60,
                                  width: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                bottom: 5,right: 5,
                                child: InkWell(
                                  onTap: () => deleteUserPicture(pictureData.privatePictures![index].userPictureId.toString()),
                                  child: Container(
                                      padding: EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: KBlue
                                      ),
                                      child: SvgPicture.asset(Images.delete,height: 10,width: 10,)
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }
                  ),
                ):
                GestureDetector(
                  onTap: () async {
                    pickedFile = await ImagePicker().getImage(source: ImageSource.gallery) as PickedFile ;
                    uploadUserPicture("Private");
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    margin: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: KBlue
                    ),
                    child: Center(child: SvgPicture.asset(Images.add,height: 25,width: 25,color: KPureBlack,)),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
  Future<void> uploadUserPicture(String type) async {

    FormData data=FormData.fromMap({
      'user_picture': await MultipartFile.fromFile(pickedFile.path)
    });
    openLoadingDialog(context, "Loading");
    var response;

    response = await DioService.post('upload_user_picture', data);
    if(response['status']=='success'){
      image=response['data'];
      Navigator.pop(context);
      uploadUserPictureDetail(type);
      //showCustomSnackBar(response['data']);
    }
    else{
      Navigator.pop(context);
      //showCustomSnackBar(response['message']);
    }
  }
  void uploadUserPictureDetail(String type) async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('upload_user_picture_details', {
      "usersId" : AppData().userdetail!.usersId,
      "picture" : image,
      "pictureType" : type
    });
    if(response['status']=='success'){
      Navigator.pop(context);
      getUserPictures();
      //showCustomSnackBar(response['data']);
    }
    else{
      Navigator.pop(context);
      print(response['message']);
      //showCustomSnackBar(response['message']);
    }

  }
  void deleteUserPicture(String pictureId) async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('delete_user_picture', {
      "userPictureId" : pictureId,
    });
    if(response['status']=='success'){
      Navigator.pop(context);
      getUserPictures();
      //showCustomSnackBar(response['data']);
    }
    else{
      Navigator.pop(context);
      print(response['message']);
      //showCustomSnackBar(response['message']);
    }

  }

  void getUserPictures() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('get_user_pictures', {
      "usersId" : AppData().userdetail!.usersId
    });
    if(response['status']=='success'){
      var jsonData= response['data'];
      pictureData=PictureData.fromJson(jsonData);
      Navigator.pop(context);
      setState(() {});
    }
    else{
      Navigator.pop(context);
      print(response['message']);
      //showCustomSnackBar(response['message']);
    }

  }

  Future<void> uploadProfilePicture() async {

    FormData data=FormData.fromMap({
      'user_profile_picture': await MultipartFile.fromFile(pickedFile.path)
    });
    openLoadingDialog(context, "Loading");
    var response;

    response = await DioService.post('upload_user_profile_picture', data);
    if(response['status']=='success'){
      image=response['data'];
      Navigator.pop(context);
      uploadProfilePictureDetail();
      //showCustomSnackBar(response['data']);
    }
    else{
      Navigator.pop(context);
      //showCustomSnackBar(response['message']);
    }
  }
  void uploadProfilePictureDetail() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('upload_user_profile_picture_details', {
      "usersId":AppData().userdetail!.usersId,
      "profilePicture" : image
    });
    if(response['status']=='success'){
      AppData().userdetail!.profilePicture=response['data'];
      AppData().update();
      Navigator.pop(context);
      //showCustomSnackBar(response['data']);
      setState(() {});
    }
    else{
      Navigator.pop(context);
      print(response['message']);
      //showCustomSnackBar(response['message']);
    }

  }
  void deleteProfilePicture() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('delete_user_profile_picture', {
      "usersId":AppData().userdetail!.usersId,
    });
    if(response['status']=='success'){
      AppData().userdetail!.profilePicture="";
      AppData().update();
      Navigator.pop(context);
      //showCustomSnackBar(response['data']);
      setState(() {});
    }
    else{
      Navigator.pop(context);
      print(response['message']);
      //showCustomSnackBar(response['message']);
    }

  }
}
