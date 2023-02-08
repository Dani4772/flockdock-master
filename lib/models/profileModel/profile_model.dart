import 'package:flocdock/constants/images.dart';
import 'package:flutter/material.dart';

class ProfileModel{
  String Img;
  String profileName;
  String distance;
  Color col;
  bool isSelected;
ProfileModel({required this.col,required this.distance,required this.profileName,required  this.Img,this.isSelected=false});
}
 List<ProfileModel> profileDummyData = [
   ProfileModel(
       col: Colors.green,
       distance: "2.7 km",
       profileName: "Daniel25",
       Img: Images.showProfile
   ),
   ProfileModel(
       col: Colors.green,
       distance: "2.7 km",
       profileName: "Kyle",
       Img: Images.showProfile1
   ),
   ProfileModel(
       col: Colors.green,
       distance: "5.6 km",
       profileName: "Da Dreamer",
       Img: Images.showProfile2
   ),
   ProfileModel(
       col: Colors.grey,
       distance: "1.7 km",
       profileName: "Maurice",
       Img: Images.showProfile3
   ),
   ProfileModel(
       col: Colors.green,
       distance: "2.1 km",
       profileName: "Nauisera",
       Img: Images.showProfile
   ),
   ProfileModel(
       col: Colors.grey,
       distance: "2.4 km",
       profileName: "Cz Beatzz",
       Img: Images.showProfile1
   ),

 ];