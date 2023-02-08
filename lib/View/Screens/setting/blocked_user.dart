import 'package:flocdock/View/Screens/setting/widget/blocked_user_widget.dart';
import 'package:flocdock/View/base/custom_snackbar.dart';
import 'package:flocdock/View/base/loading_dialog.dart';
import 'package:flocdock/View/base/simple_appbar.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flocdock/mixin/data.dart';
import 'package:flocdock/models/user_model/block_user_model.dart';
import 'package:flocdock/services/dio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlockedUser extends StatefulWidget {
  const BlockedUser({Key? key}) : super(key: key);

  @override
  State<BlockedUser> createState() => _BlockedUserState();
}

class _BlockedUserState extends State<BlockedUser> {

  List<BlockUser> blockUser=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getBlockList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KbgBlack,
      appBar: SimpleAppbar(description: "Blocked Users", pageName: "SETTINGS",pageTrailing: "",),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => Get.back(),
              child: Padding(
                padding: const EdgeInsets.only(top: 10,left: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back_ios_rounded,color: KDullBlack,size: 20,),
                      Text("BACK",style: proximaBold.copyWith(color: KdullWhite,fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            ListView.builder(
                reverse: true,
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: blockUser.length,
                itemBuilder: (context,index){
                  return BlockedUserCard(
                    img:blockUser[index].profilePicture??'',
                    title: blockUser[index].userName??'',
                    isLive: blockUser[index].isOnline,
                    onTapUnblock: () => unblockUser(index),
                  );
                }
            ),

          ],
        ),
      ),
    );
  }

  void unblockUser(int index) async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('unblock_user', {
      "blockedByUserId" : AppData().userdetail!.usersId,
      "blockedUserId" : blockUser[index].blockedUserId
    });
    if(response['status']=='success'){
      showCustomSnackBar(response['data']);
      Navigator.pop(context);
      blockUser.removeAt(index);
      setState(() {});
    }
    else{
      Navigator.pop(context);
      print(response['message']);
      showCustomSnackBar(response['message']);
    }

  }

  void getBlockList() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('get_block_list', {
      "blockByUserId" : AppData().userdetail!.usersId
    });
    if(response['status']=='success'){
      var jsonData= response['data'] as List;
      blockUser=jsonData.map((e) => BlockUser.fromJson(e)).toList();
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
