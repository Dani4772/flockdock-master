import 'package:flocdock/constants/images.dart';

class GroupModel{
  String img;
  String groupName;
  String distance;
  String groupMember;
  GroupModel({required this.img,required this.distance, required this.groupMember,required this.groupName});
}

List<GroupModel> groupDummyData = [
  GroupModel(
      img: Images.Group,
      distance: "2.7 km",
      groupMember: "26 km",
      groupName: "Movie Group"
  ),
  GroupModel(
      img: Images.Group2,
      distance: "2.0 km",
      groupMember: "26",
      groupName: "CHILL OUT"
  ),
  GroupModel(
      img: Images.Group3,
      distance: "2.4 km",
      groupMember: "26",
      groupName: "XYZ GROUP"
  ),
  GroupModel(
      img: Images.Group4,
      distance: "3.0 km",
      groupMember: "26",
      groupName: "OFFICE GROUP"
  ),
  GroupModel(
      img: Images.Group5,
      distance: "1.7 km",
      groupMember: "26",
      groupName: "GYM BUDDIES"
  ),
  GroupModel(
      img: Images.Group6,
      distance: "2.4 km",
      groupMember: "26",
      groupName: "CHILL OUT"
  ),

  GroupModel(
      img: Images.Group7,
      distance: "3.0 km",
      groupMember: "26",
      groupName: "XYZ GROUP"
  ),

  GroupModel(
      img: Images.Group8,
      distance: "3.0 km",
      groupMember: "26",
      groupName: "XYZ GROUP"
  ),
  GroupModel(
      img: Images.Group9,
      distance: "3.0 km",
      groupMember: "26",
      groupName: "CHILL OUT"
  ),
  GroupModel(
      img: Images.Group,
      distance: "3.0 km",
      groupMember: "26",
      groupName: "GYM BUDDIES"
  ),

];