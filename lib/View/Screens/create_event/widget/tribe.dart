import 'package:flocdock/Models/event_details/event_deatil.dart';
import 'package:flocdock/View/Screens/create_event/choose_category.dart';
import 'package:flocdock/View/Screens/create_event/widget/value_container.dart';
import 'package:flutter/material.dart';

class TribeItems extends StatefulWidget {
  TribeItems({Key? key,}) : super(key: key);

  @override
  _TribeItemsState createState() => _TribeItemsState();
}



class _TribeItemsState extends State<TribeItems> {


  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      runSpacing: 8,
      children: [
        for(int i=0;i<groupDetail.tribes!.length;i++)
         InkWell(onTap:(){
            if(eventDetail.tribes!.contains(groupDetail.tribes![i].tribeId)){
              eventDetail.tribes?.remove(groupDetail.tribes![i].tribeId);
            }
            else{
              eventDetail.tribes?.add(groupDetail.tribes![i].tribeId!);
            }
             setState(() {});
          },
             child: ValueContainer(value: groupDetail.tribes![i].tribe!,isSelected: eventDetail.tribes!.contains(groupDetail.tribes![i].tribeId))
    ),
    ],
    );
  }
}
