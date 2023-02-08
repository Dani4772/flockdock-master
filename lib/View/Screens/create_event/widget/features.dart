import 'package:flocdock/Models/event_details/event_deatil.dart';
import 'package:flocdock/View/Screens/create_event/choose_category.dart';
import 'package:flocdock/View/Screens/create_event/widget/value_container.dart';
import 'package:flutter/material.dart';

class Features extends StatefulWidget {
  Features({Key? key,}) : super(key: key);

  @override
  _FeaturesState createState() => _FeaturesState();
}

class _FeaturesState extends State<Features> {

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      runSpacing: 8,
      children: [
        for(int i=0;i<groupDetail.features!.length;i++)
         InkWell(onTap:(){
           if(eventDetail.features!.contains(groupDetail.features![i].featureId)){
             eventDetail.features?.remove(groupDetail.features![i].featureId);
           }
           else{
             eventDetail.features?.add(groupDetail.features![i].featureId!);
           }
           setState(() {});
           },
             child: ValueContainer(value: groupDetail.features![i].feature!,isSelected: eventDetail.features!.contains(groupDetail.features![i].featureId))
         ),
      ],
    );
  }
}
