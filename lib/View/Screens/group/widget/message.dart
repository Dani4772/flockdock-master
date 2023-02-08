import 'package:flocdock/Models/profileModel/profile_model.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flocdock/models/message/message_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget Message({required Messages message})
{
  return Column(
    children: [
      ListTile(
        leading: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                  message.profilePicture??'https://th.bing.com/th/id/R.f70716a016d050b36d53b140cfcefce5?rik=nHI2ixAxPcXyMQ&riu=http%3a%2f%2fsumprop.com%2fsites%2fdefault%2ffiles%2fOur+Work+Icon.jpg&ehk=e6KzrPqL8uZWbVkxhSb%2fjY%2fvr1jLONs96WxhfGtl8Fg%3d&risl=&pid=ImgRaw&r=0'
              ),
            ),
          ),
        ),
        title: Text(message.userName??'',style: proximaBold.copyWith(color: KWhite,fontSize: Dimensions.fontSizeSmall)),
        subtitle: Text(message.content??'',
            style: proximaBold.copyWith(color: KWhite.withOpacity(0.5),fontSize: Dimensions.fontSizeSmall)
        ),
      ),
      Container(
        color: Colors.white.withOpacity(0.2),
        margin: EdgeInsets.symmetric(horizontal: 15),
        width: double.infinity,
        height: 1,
      ),
    ],
  );
}