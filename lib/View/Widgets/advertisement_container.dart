
import 'package:flocdock/constants/styles.dart';
import 'package:flutter/material.dart';

Widget AdvertisementContainer({
  required BuildContext context,String name="", double height=90,
})
{
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      decoration: BoxDecoration(
          color: const Color(0XFFC4C4C4),
          borderRadius: BorderRadius.circular(10)
      ),
      height: height,
      width: double.infinity,
      child:  Center(child: Text("Advertisement",style: proximaBold.copyWith(color: Colors.black,),)),
    ),
  );
}