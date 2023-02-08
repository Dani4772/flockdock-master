import 'package:flocdock/View/Screens/create_event/choose_category.dart';
import 'package:flocdock/View/Widgets/my_text.dart';
import 'package:flocdock/View/Widgets/my_text_field.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cover extends StatefulWidget {
  final void Function(int,int)? selected;
  bool isSelected;
  Cover({Key? key,this.selected,this.isSelected=true}) : super(key: key);

  @override
  _CoverState createState() => _CoverState();
}

class _CoverState extends State<Cover> {

  String dropdownvalue = 'USD';

  // List of items in our dropdown menu
  var items = [
    'USD',
    'EUR',
    'DIRHAM',
    'PKR',
  ];


  TextEditingController costController=TextEditingController();
  bool isSelected=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSelected=eventDetail.cover!="Per Guest";
    if(eventDetail.cost!=null)
      costController.text=eventDetail.cost.toString();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: (){
                isSelected=!isSelected;
                widget.selected!(1,0);
                setState(() {

                });
              },
              child: Container(
                height: 20,
                width: 20,
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: KDullBlack,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      color:isSelected?KBlue:KDullBlack,
                      shape: BoxShape.circle
                    ),
                  ),
                ),
              ),
            ),
            Text("Free admittance",style: proximaBold.copyWith(color: KWhite),),
            SizedBox(width: 10,),
            GestureDetector(
              onTap: (){
                isSelected=!isSelected;
                widget.selected!(2,1);
                setState(() {

                });
              },
              child: Container(
                height: 20,
                width: 20,
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: KDullBlack,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                        color:!isSelected?KBlue:KDullBlack,
                        shape: BoxShape.circle
                    ),
                  ),
                ),
              ),
            ),
            Text("Per Guest",style: proximaBold.copyWith(color: KWhite),),
          ],
        ),
        SizedBox(height: 10,),
        Row(
          children: [
            if(!isSelected)MyTextField(
              textInputType: TextInputType.number,
              verticalPadding: 0.0,
              hight: 50.0,
              width: 120.0,
              controller: costController,
              onChanged: (val) => eventDetail.cost=int.tryParse(costController.text),
            ),
            SizedBox(width: 5,),

            if(!isSelected)Container(
              height: 50,
                width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: KDullBlack,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left:10.0),
                child: DropdownButton(
                  underline: SizedBox(),
                  value: dropdownvalue,
                  icon: const Icon(Icons.keyboard_arrow_down,color: KWhite,),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items,style: TextStyle(color: KbgBlack,fontFamily: "Proxima"),),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
              ),
            )

          ],
        )


      ],
    );
  }
}