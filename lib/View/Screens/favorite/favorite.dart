import 'package:flocdock/View/Screens/group/group_view.dart';
import 'package:flocdock/View/Screens/menu/drawer.dart';
import 'package:flocdock/View/Screens/profile/profile_view.dart';
import 'package:flocdock/View/Widgets/advertisement_container.dart';
import 'package:flocdock/View/Widgets/profile_widget.dart';
import 'package:flocdock/View/base/bottom_navbar.dart';
import 'package:flocdock/View/base/custom_appbar.dart';
import 'package:flocdock/View/base/custom_snackbar.dart';
import 'package:flocdock/View/base/loading_dialog.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flocdock/mixin/data.dart';
import 'package:flocdock/models/profile&Group/profile_group_model.dart';
import 'package:flocdock/services/dio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);


  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  bool isSearch =false;
  TextEditingController searchController=TextEditingController();
  List<ProfileGroupDetail>? profileGroup=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getFavouriteUsersGroups();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KbgBlack,
      drawer: MyDrawer(),
      appBar: CustomAppbar(pageName: 'Favorite', description: "Groups and Profiles",pageTrailing: "",),
      bottomNavigationBar: BottomBar(pageIndex: 3,),
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  children: [
                    StaggeredGrid.count(
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      crossAxisCount: 3,
                      children: [
                        for(int i=0;i<profileGroup!.length;i++)
                          profileGroup![i].objectType=="Group"?
                          StaggeredGridTile.count(
                            crossAxisCellCount: 2,
                            mainAxisCellCount: 1,
                            child: InkWell(
                              onTap: () => Get.to(GroupView(groupId: profileGroup![i].groupId,)),
                              child: GroupWidget(
                                img: profileGroup![i].picture??'',
                                groupName: profileGroup![i].name??'',
                                distance: profileGroup![i].distanceAway!.toPrecision(2).toString(),
                                groupMembers: profileGroup![i].totalActiveMembers.toString(),
                              ),
                            ),
                          ):
                          StaggeredGridTile.count(
                              crossAxisCellCount: 1,
                              mainAxisCellCount: 1,
                              child: InkWell(
                                onTap: () => Get.to(ProfileView(userId: profileGroup![i].usersId,)),
                                child: ProfileWidget(
                                    img: profileGroup![i].picture??'',
                                    profileName: profileGroup![i].name??'',
                                    distance: profileGroup![i].distanceAway!.toPrecision(2).toString(),
                                  isOnline: profileGroup![i].isOnline
                                ),
                              )
                          ),

                        // StaggeredGridTile.count(
                        //     crossAxisCellCount: 1,
                        //     mainAxisCellCount: 1,
                        //     child: ProfileWidget(
                        //         img: profileDummyData[0].Img,
                        //         profileName: profileDummyData[0].profileName,
                        //         distance: profileDummyData[0].distance,
                        //         col: profileDummyData[0].col
                        //     )
                        // ),
                        // StaggeredGridTile.count(
                        //   crossAxisCellCount: 2,
                        //   mainAxisCellCount: 1,
                        //   child: GroupContainer(
                        //       img: groupDummyData[0].img,
                        //       groupName: groupDummyData[0].groupName,
                        //       distance: groupDummyData[0].distance,
                        //       groupMembers: groupDummyData[0].groupMember,
                        //     index: 1
                        //   ),
                        // ),
                        // StaggeredGridTile.count(
                        //     crossAxisCellCount: 1,
                        //     mainAxisCellCount: 1,
                        //     child: ProfileWidget(
                        //         img: profileDummyData[0].Img,
                        //         profileName: profileDummyData[0].profileName,
                        //         distance: profileDummyData[0].distance,
                        //         col: profileDummyData[0].col
                        //     )
                        // ),
                        // StaggeredGridTile.count(
                        //     crossAxisCellCount: 1,
                        //     mainAxisCellCount: 1,
                        //     child: ProfileWidget(
                        //         img: profileDummyData[0].Img,
                        //         profileName: profileDummyData[0].profileName,
                        //         distance: profileDummyData[0].distance,
                        //         col: profileDummyData[0].col
                        //     )
                        // ),
                        // StaggeredGridTile.count(
                        //     crossAxisCellCount: 1,
                        //     mainAxisCellCount: 1,
                        //     child: ProfileWidget(
                        //         img: profileDummyData[0].Img,
                        //         profileName: profileDummyData[0].profileName,
                        //         distance: profileDummyData[0].distance,
                        //         col: profileDummyData[0].col
                        //     )
                        // ),
                        // StaggeredGridTile.count(
                        //     crossAxisCellCount: 1,
                        //     mainAxisCellCount: 1,
                        //     child: ProfileWidget(
                        //         img: profileDummyData[0].Img,
                        //         profileName: profileDummyData[0].profileName,
                        //         distance: profileDummyData[0].distance,
                        //         col: profileDummyData[0].col
                        //     )
                        // ),
                        // StaggeredGridTile.count(
                        //     crossAxisCellCount: 1,
                        //     mainAxisCellCount: 1,
                        //     child: ProfileWidget(
                        //         img: profileDummyData[0].Img,
                        //         profileName: profileDummyData[0].profileName,
                        //         distance: profileDummyData[0].distance,
                        //         col: profileDummyData[0].col
                        //     )
                        // ),
                        // StaggeredGridTile.count(
                        //     crossAxisCellCount: 1,
                        //     mainAxisCellCount: 1,
                        //     child: ProfileWidget(
                        //         img: profileDummyData[0].Img,
                        //         profileName: profileDummyData[0].profileName,
                        //         distance: profileDummyData[0].distance,
                        //         col: profileDummyData[0].col
                        //     )
                        // ),
                        // StaggeredGridTile.count(
                        //     crossAxisCellCount: 1,
                        //     mainAxisCellCount: 1,
                        //     child: ProfileWidget(
                        //         img: profileDummyData[0].Img,
                        //         profileName: profileDummyData[0].profileName,
                        //         distance: profileDummyData[0].distance,
                        //         col: profileDummyData[0].col
                        //     )
                        // ),
                        // StaggeredGridTile.count(
                        //   crossAxisCellCount: 2,
                        //   mainAxisCellCount: 1,
                        //   child: GroupContainer(
                        //       img: groupDummyData[0].img,
                        //       groupName: groupDummyData[0].groupName,
                        //       distance: groupDummyData[0].distance,
                        //       groupMembers: groupDummyData[0].groupMember,
                        //     index: 1
                        //   ),
                        // ),
                      ],
                    ),
                    //             StaggeredGrid.count(
                    //               mainAxisSpacing: 4,
                    //               crossAxisSpacing: 4,
                    //               crossAxisCount: 3,
                    //               children: [
                    //                 for(int index=0;index<6;index++)
                    //                   mixDummyData[index].isProfile?
                    //                     StaggeredGridTile.count(
                    //                         crossAxisCellCount: 1,
                    //                         mainAxisCellCount: 1,
                    //                         child: ProfileContainer(
                    //                             img: profileDummyData[index].Img,
                    //                             profileName: profileDummyData[index].profileName,
                    //                             distance: profileDummyData[index].distance,
                    //                             col: profileDummyData[index].col
                    //                         )
                    //                     ):
                    //                     StaggeredGridTile.count(
                    //                       crossAxisCellCount: 2,
                    //                       mainAxisCellCount: 1,
                    //                       child: GroupContainer(
                    //                           img: groupDummyData[index].img,
                    //                           groupName: groupDummyData[index].groupName,
                    //                           distance: groupDummyData[index].distance,
                    //                           groupMembers: groupDummyData[index].groupMember),
                    //                     )
                    //               ],
                    // ),
                  ],
                ),
              ),
            ),
            AdvertisementContainer(context: context)
          ],
        ),
      ),
    );
  }

  void getFavouriteUsersGroups() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('get_favourite_users_groups', {
      "usersId":AppData().userdetail!.usersId.toString(),
      "userLat":AppData().userdetail!.latitude.toString(),
      "userLong":AppData().userdetail!.longitude.toString()
    });
    if(response['status']=='success'){
      var jsonData= response['data'] as List;
      profileGroup=jsonData.map((e) => ProfileGroupDetail.fromJson(e)).toList();
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
