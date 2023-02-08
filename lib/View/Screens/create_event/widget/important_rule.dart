import 'package:flocdock/Models/event_details/event_deatil.dart';
import 'package:flocdock/View/Screens/create_event/widget/value_container.dart';
import 'package:flocdock/models/groupModel/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flocdock/View/Screens/create_event/choose_category.dart';


class ImportantRule extends StatefulWidget {
  ImportantRule({Key? key,}) : super(key: key);

  @override
  _ImportantRuleState createState() => _ImportantRuleState();
}

class _ImportantRuleState extends State<ImportantRule> {
  @override
  Widget build(BuildContext context) {
    groupDetail.importantRules!.toList();
    return Wrap(
      spacing: 5,
      runSpacing: 8,
      children: [
        for(int i=0;i<groupDetail.importantRules!.length;i++)
          InkWell(onTap:(){
            print(groupDetail.importantRules![i].importantRuleId);
            print(eventDetail.importantRules![i].importantRuleId);
            if(eventDetail.importantRules![i].answer=="Yes"){
              eventDetail.importantRules?[i].answer="No";
            }
            else{
              eventDetail.importantRules?[i].answer="Yes";
            }
            for(int l=0;l<eventDetail.importantRules!.length;l++)
              print(eventDetail.importantRules![l].toJson());
            print(eventDetail.importantRules![i].answer);
            setState(() {});
          },
              child: ValueContainer(value: groupDetail.importantRules![i].importantRule!,isSelected: eventDetail.importantRules![i].answer=="Yes")
          ),
      ],
    );
  }
}
