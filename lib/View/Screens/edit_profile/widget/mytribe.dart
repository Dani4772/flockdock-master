import 'package:flocdock/models/groupModel/category_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../Models/event_details/event_deatil.dart';
import '../../../../constants/constants.dart';
import '../../../../mixin/data.dart';
import '../../../../models/user_model/profile_model.dart';
import '../../../../models/user_model/signup_model.dart';
import '../../../../services/dio_service.dart';
import '../../../base/custom_snackbar.dart';
import '../../../base/loading_dialog.dart';
import '../../create_event/widget/value_container.dart';

class mytribe extends StatefulWidget {
  //var names;
  mytribe(
      {Key? key,}
      ) : super(key: key);

  @override
  State<mytribe> createState() => _mytribeState();
}

class _mytribeState extends State<mytribe> {
  TextEditingController descriptionController=TextEditingController();
  List<String> trib =['Leather','Bears','Otters','Muscle','Ribbed','GuysNextDoor','Jocks (Sportler)','Geeks (Nerds)','Daddies','Military (Soldaten)','Twinks','Poz','Chubs Chubbies','Uniform','Clean-Cut','Uncut','BB','Pathan','Santa','Punjabi'];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KbgBlack,
      appBar: AppBar(title: Text(
        'My Tribes',
        style: TextStyle(color: KWhite),
      ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black54,
      ),
      body: ListView.builder(
          itemCount: trib.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                trailing: Icon(Icons.check,color: Colors.white,),
                title: Text(trib[index],style: TextStyle(color: Colors.white),));
          }),
    );
  }
}
