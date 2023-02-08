import 'package:flocdock/Models/event_details/event_deatil.dart';
import 'package:flocdock/View/Screens/create_event/widget/value_container.dart';
import 'package:flocdock/View/Screens/edit_profile/profile_picture.dart';
import 'package:flocdock/View/Screens/edit_profile/widget/mytribe.dart';
import 'package:flocdock/View/Widgets/edit_field.dart';
import 'package:flocdock/View/base/custom_snackbar.dart';
import 'package:flocdock/View/base/loading_dialog.dart';
import 'package:flocdock/View/base/simple_appbar.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flocdock/mixin/data.dart';
import 'package:flocdock/models/user_model/profile_model.dart';
import 'package:flocdock/models/user_model/signup_model.dart';
import 'package:flocdock/services/dio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Widgets/edit_field_socials.dart';
import '../../Widgets/my_button.dart';
import '../../Widgets/my_spacing.dart';
import '../../Widgets/my_text.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  ProfileDetail profileDetail=
  ProfileDetail(ethnicities: [],bodyTypes: [],positions: [],relationships: [],seeking: [],tribes: []);
  UserDetail userDetail=UserDetail(userSeeking: [],userTribes: []);
  TextEditingController descriptionController=TextEditingController();
  List<String> genders=['Male','Female','Other','Unspecified'];
  List<String> hiv_status=['Do not show','Negative','Negative - on PrEP','Positive','Positive-Undetectable'];
  String val="";
  List<String> tribetxt =[];
  DateTime? selectedDate; //=DateTime.now();
  DateTime vaccinationDate=DateTime.now();
  String vaccination=DateFormat("dd MMM, yyyy").format(DateTime.now());
  String DOB=DateFormat("dd MMM, yyyy").format(DateTime.now());
  bool showAge=true;
  bool hive=true;
  bool covid=true;
  bool isLoading=true;
  TextEditingController birthdayText_Controller = TextEditingController();
  List<int>? _selectedItems ;
  bool isSelected = false;

  late List<String> tribe_tosent;
  int selectedId=1;
  int i = 100;
  DetailItem detailItem=DetailItem();
  List<String> hightInFeet=["4","4:1","4:2","4:3","4:4","4:5","4:6","4:7","4:8","4:9","4:10","4:11","5",
    "5:1","5:2","5:3","5:4","5:5","5:6","5:7","5:8","5:9","5:10","5:11","6","6:1","6:2","6:3","6:4",
    "6:5","6:6","6:7","6:8","6:9","6:10","6:11","7",];
  //List<String> hightInCentimeter=List.generate(50, (index) => index.toString());
  List<String> weightInKg=List.generate(200, (index) => index.toString());
  //List<String> hightInCentimeter =['100','101','102','103','104','105','106','107'];
  List<String> hightInCentimeter = [for(var i=100; i<231; i+=1) i.toString()];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getUserProfileDetail();
      getPredefinedProfileDetail();
      //selectedDate = DateTime.parse(userDetail.birthday.toString());
     // DOB = userDetail.birthday.toString();
      print(profileDetail.tribes!.length);
      print("Data");
      print(profileDetail.tribes![0].tribe!);
      // for(int i=0;i<profileDetail.tribes!.length;i++)
      //   {
      //     print("Length");
      //     print(profileDetail.tribes!.length);
      //     print("Data");
      //     print(profileDetail.tribes![i].tribe!);
      //   }
    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: KbgBlack,
        appBar: SimpleAppbar(description: "Edit Profile", pageName: "MY PROFILE",pageTrailing: Images.close,),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: updateProfileDetail,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0,top: 10),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text("SAVE",style: proximaBold.copyWith(color: KWhite)),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.03),
              Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(1),
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              color: KBlue,
                              shape: BoxShape.circle
                          ),
                          child: ClipOval(
                              child: Image.network(
                                AppData().userdetail!.profilePicture??AppConstants.placeholder,
                                height: 90,
                                width: 90,
                                fit: BoxFit.cover,
                              )
                          ),
                        ),
                        Positioned(
                          bottom: 2,right: 2,
                          child: InkWell(
                            onTap: () => Get.to(EditProfilePicture()),
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: KBlue
                              ),
                              child: Icon(Icons.edit,size: 15,),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(AppData().userdetail!.userName??'', style: proximaBold.copyWith(color: KBlue),),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.03),
              Container(
                height: 100,
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                    vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: KDullBlack
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Description",style: proximaBold.copyWith(color: KBlue)),
                    Expanded(
                      child: TextFormField(
                          controller: descriptionController,
                          keyboardType: TextInputType.multiline,
                          cursorColor: KWhite,
                          maxLines: 3,
                          minLines: 3,
                          autofocus: false,
                          maxLength: 100,
                          style: const TextStyle(
                              color: KWhite,
                              fontFamily: "Proxima"
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            counterStyle: TextStyle(color: KWhite),
                            hintStyle: TextStyle(color: KWhite,fontFamily: "Proxima"),
                          )
                      ),
                    ),
                  ],
                ),
              ),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE,vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              //   margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(40),
              //       color: KDullBlack
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text("Gender",style: proximaBold.copyWith(color: KBlue)),
              //       SizedBox(
              //         height: 25,
              //         child: DropdownButton<String>(
              //           underline: const SizedBox(),
              //           isExpanded: true,
              //           dropdownColor: KDullBlack,
              //           icon: const Icon(Icons.arrow_drop_down_rounded,color: KWhite,),
              //           items: genders.map((value) {
              //             return DropdownMenuItem<String>(
              //               value: value,
              //               child: Text(value,style: proximaBold.copyWith(color: KWhite)),
              //             );
              //           }).toList(),
              //           onChanged: (String? newValue){
              //             print(newValue);
              //             //gender=newValue!;
              //             userDetail.gender=newValue;
              //             setState(() {});
              //           },
              //           value: userDetail.gender,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE,vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: KDullBlack
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Gender",style: proximaBold.copyWith(color: KBlue)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(userDetail.gender??'',style: proximaBold.copyWith(color: KWhite)),
                        SizedBox(
                          height: 30,
                          child: CupertinoButton(
                            alignment: Alignment.topRight,
                            padding: EdgeInsets.zero,
                              child: const Icon(Icons.arrow_drop_down_rounded,color: KWhite,),
                              onPressed: () {
                              val=userDetail.gender!;
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        color: KWhite,
                                        height: 400,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            CupertinoButton(
                                              child: Text("Cancel",style: proximaBold.copyWith(color: KBlue)),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            Expanded(
                                              child: CupertinoPicker(
                                                  scrollController: FixedExtentScrollController(
                                                    initialItem: genders.indexWhere((element) => userDetail.gender==element),
                                                  ),
                                                  itemExtent: 50.0,
                                                  onSelectedItemChanged: (int index) {
                                                    val = genders[index];
                                                  },
                                                  children:  genders.map((e) => Center(child: Text(e,style: proximaBold.copyWith(color: KPureBlack,fontSize: 24)),),).toList()
                                              ),
                                            ),
                                            CupertinoButton(
                                              child: Text("Ok",style: proximaBold.copyWith(color: KBlue)),
                                              onPressed: () {
                                                userDetail.gender=val;
                                                setState(() {

                                                });
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),


              GestureDetector(
                onTap: () async{
                  DateTime? selected;
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          color: KWhite,
                          height: 400,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                    child: CupertinoDatePicker(
                                      onDateTimeChanged: (DateTime date) {
                                        selected=date;
                                      },
                                      mode: CupertinoDatePickerMode.date,
                                      initialDateTime: selectedDate,//DateTime.parse(userDetail.birthday.toString()),
                                      minimumDate: DateTime(1970),
                                      maximumDate: DateTime.now(),
                                    ),
                                ),
                              CupertinoButton(
                                child: Text("OK",style: proximaBold.copyWith(color: KBlue)),
                                onPressed: () {
                                  selectedDate=DateTime.parse(userDetail.birthday.toString());
                                  print(DateTime.parse(userDetail.birthday.toString()));
                                  if (selected!=null && selected != selectedDate) {
                                    print(selected);
                                    selectedDate = selected!;
                                    print('Selected Date');
                                    print(selectedDate);
                                    DOB=DateFormat("dd MMM, yyyy").format(selectedDate!);
                                    print('user Detail.birthday');
                                    print(userDetail.birthday);
                                    userDetail.birthday=DateFormat("yyyy-MM-dd").format(selectedDate!);
                                    print(DOB);
                                    setState(() {});
                                  }
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      });

                  // final DateTime? selected = await showDatePicker(
                  //   context: context,
                  //   builder: (context, child)=>Theme(data: ThemeData().copyWith(
                  //       colorScheme: const ColorScheme.dark(
                  //         surface: KDullBlack,
                  //         primary: KBlue,
                  //         onSurface: KWhite,
                  //         secondary: KWhite,
                  //       ),
                  //       indicatorColor: KWhite,
                  //       dialogBackgroundColor: KDullBlack
                  //   ), child: child!,
                  //   ),
                  //   initialDate: selectedDate,
                  //   firstDate: DateTime(1970),
                  //   lastDate: DateTime.now(),
                  // );
                  // if (selected != null && selected != selectedDate) {
                  //   print(selected);
                  //   selectedDate = selected;
                  //   DOB=DateFormat("dd MMM, yyyy").format(selectedDate);
                  //   userDetail.birthday=DateFormat("yyyy-MM-dd").format(selectedDate);
                  //   print(DOB);
                  //   setState(() {});
                  // }
                },
                child: EditField(
                  title: "Birthday",
                  isEnabled: false,
                  controller: TextEditingController(
                      text: DOB
                  )
                  ,
                ),
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE,vertical: 8),
                  margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: KDullBlack
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Show Age",style: proximaBold.copyWith(color: KBlue,fontSize: Dimensions.fontSizeDefault),),
                          SizedBox(height: 4,),
                          Text(showAge?"Yes":"No",style: proximaBold.copyWith(color: KWhite,fontSize: Dimensions.fontSizeDefault),),
                        ],
                      ),
                      FlutterSwitch(
                        height: 25,
                        width: 45,
                        padding: 1,
                        toggleSize: 24,
                        activeColor: KBlue,
                        inactiveToggleColor: KDullBlack,
                        value: showAge,
                        onToggle: (value) {
                          setState(() {
                            showAge = value;
                            userDetail.showAge=showAge?"True":"False";
                          });
                        },
                      ),
                    ],
                  )
              ),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE,vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              //   margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(40),
              //       color: KDullBlack
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text("Hight",style: proximaBold.copyWith(color: KBlue)),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: <Widget>[
              //           Row(
              //             children: [
              //               Text(userDetail.height??"",style: proximaBold.copyWith(color: KWhite)),
              //               Text(" Feet",style: proximaBold.copyWith(color: KWhite)),
              //             ],
              //           ),
              //           SizedBox(
              //             height: 30,
              //             child: CupertinoButton(
              //                 alignment: Alignment.topRight,
              //                 padding: EdgeInsets.zero,
              //                 child: const Icon(Icons.arrow_drop_down_rounded,color: KWhite,),
              //                 onPressed: () {
              //                   val=userDetail.height??"";
              //                   showModalBottomSheet(
              //                       context: context,
              //                       builder: (BuildContext context) {
              //                         return Container(
              //                           color: KDullBlack,
              //                           height: 200,
              //                           child: Row(
              //                             crossAxisAlignment: CrossAxisAlignment.start,
              //                             children: <Widget>[
              //                               CupertinoButton(
              //                                 child: Text("Cancel",style: proximaBold.copyWith(color: KBlue)),
              //                                 onPressed: () {
              //                                   Navigator.pop(context);
              //                                 },
              //                               ),
              //                               Expanded(
              //                                 child: CupertinoPicker(
              //                                     scrollController: FixedExtentScrollController(
              //                                       initialItem: hightInFeet.indexWhere((element) => userDetail.height==element),
              //                                     ),
              //                                     itemExtent: 50.0,
              //                                     onSelectedItemChanged: (int index) {
              //                                       val = hightInFeet[index];
              //                                     },
              //                                     children:  hightInFeet.map((e) => Center(child: Text(e+" Feet",style: proximaBold.copyWith(color: KWhite)),),).toList()
              //                                 ),
              //                               ),
              //                               CupertinoButton(
              //                                 child: Text("Ok",style: proximaBold.copyWith(color: KBlue)),
              //                                 onPressed: () {
              //                                   userDetail.height=val;
              //                                   setState(() {
              //
              //                                   });
              //                                   Navigator.pop(context);
              //                                 },
              //                               ),
              //                             ],
              //                           ),
              //                         );
              //                       });
              //                 }),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE,vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: KDullBlack
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Height",style: proximaBold.copyWith(color: KBlue)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Text(userDetail.height??"",style: proximaBold.copyWith(color: KWhite)),
                            if(userDetail.height!=null)Text(" cm",style: proximaBold.copyWith(color: KWhite)),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                          child: CupertinoButton(
                              alignment: Alignment.topRight,
                              padding: EdgeInsets.zero,
                              child: const Icon(Icons.arrow_drop_down_rounded,color: KWhite,),
                              onPressed: () {
                                val=userDetail.height??"";
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        color: KWhite,
                                        height: 400,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            CupertinoButton(
                                              child: Text("Cancel",style: proximaBold.copyWith(color: KBlue)),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            Expanded(
                                              child: CupertinoPicker(
                                                  scrollController: FixedExtentScrollController(
                                                    initialItem: hightInCentimeter.indexOf(150.toString()),
                                                    //hightInCentimeter.indexWhere((element) => userDetail.height==element),
                                                  ),
                                                  itemExtent: 50.0,
                                                  onSelectedItemChanged: (int index) {
                                                    val = hightInCentimeter[index];
                                                  },
                                                  children:  hightInCentimeter.map((e) => Center(child: Text(e+" cm",style: proximaBold.copyWith(color: KPureBlack,fontSize: 24)),),).toList()
                                              ),
                                            ),
                                            CupertinoButton(
                                              child: Text("Ok",style: proximaBold.copyWith(color: KBlue)),
                                              onPressed: () {
                                                userDetail.height=val;
                                                setState(() {

                                                });
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE,vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: KDullBlack
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Weight",style: proximaBold.copyWith(color: KBlue)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Text(userDetail.weight??"",style: proximaBold.copyWith(color: KWhite)),
                            if(userDetail.weight!=null)Text(" kg",style: proximaBold.copyWith(color: KWhite)),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                          child: CupertinoButton(
                              alignment: Alignment.topRight,
                              padding: EdgeInsets.zero,
                              child: const Icon(Icons.arrow_drop_down_rounded,color: KWhite,),
                              onPressed: () {
                                val=userDetail.weight??"";
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        color: KWhite,
                                        height: 400,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            CupertinoButton(
                                              child: Text("Cancel",style: proximaBold.copyWith(color: KBlue)),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            Expanded(
                                              child: CupertinoPicker(
                                                  scrollController: FixedExtentScrollController(
                                                    initialItem: weightInKg.indexOf(50.toString()),
                                                    //weightInKg.indexWhere((element) => userDetail.weight==element),
                                                  ),
                                                  itemExtent: 50.0,
                                                  onSelectedItemChanged: (int index) {
                                                    val = weightInKg[index];
                                                  },
                                                  children:  weightInKg.map((e) => Center(child: Text(e+" kg",style: proximaBold.copyWith(color: KPureBlack,fontSize: 24)),),).toList()
                                              ),
                                            ),
                                            CupertinoButton(
                                              child: Text("Ok",style: proximaBold.copyWith(color: KBlue)),
                                              onPressed: () {
                                                userDetail.weight=val;
                                                setState(() {

                                                });
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //EditField(title: "Hight",value: userDetail.height??'',onChanged: (val) => userDetail.height=val,controller: TextEditingController(text: userDetail.height??''),),
              //EditField(title: "Weight",value: userDetail.weight??'',onChanged: (val) => userDetail.weight=val,controller: TextEditingController(text: userDetail.weight??''),),
              isLoading?const SizedBox():Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE,vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: KDullBlack
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Ethnicity",style: proximaBold.copyWith(color: KBlue)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(profileDetail.ethnicities!.where((element) => element.ethnicityId==userDetail.ethnicityId).first.ethnicity??'',style: proximaBold.copyWith(color: KWhite)),
                            SizedBox(
                              height: 30,
                              child: CupertinoButton(
                                  alignment: Alignment.topRight,
                                  padding: EdgeInsets.zero,
                                  child: const Icon(Icons.arrow_drop_down_rounded,color: KWhite,),
                                  onPressed: () {
                                    selectedId=userDetail.ethnicityId!;
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                            color: KWhite,
                                            height: 400,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                CupertinoButton(
                                                  child: Text("Cancel",style: proximaBold.copyWith(color: KBlue)),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                Expanded(
                                                  child: CupertinoPicker(
                                                      scrollController: FixedExtentScrollController(
                                                        initialItem: profileDetail.ethnicities!.indexWhere((element) => selectedId==element.ethnicityId),
                                                      ),
                                                      itemExtent: 50.0,
                                                      onSelectedItemChanged: (int index) {
                                                        selectedId = profileDetail.ethnicities![index].ethnicityId!;
                                                      },
                                                      children:  profileDetail.ethnicities!.map((e) => Center(child: Text(e.ethnicity??'',style: proximaBold.copyWith(color: KPureBlack,fontSize: 24)),),).toList()
                                                  ),
                                                ),
                                                CupertinoButton(
                                                  child: Text("Ok",style: proximaBold.copyWith(color: KBlue)),
                                                  onPressed: () {
                                                    userDetail.ethnicityId=selectedId;
                                                    setState(() {

                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE,vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  //   margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(40),
                  //       color: KDullBlack
                  //   ),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text("Ethnicity",style: proximaBold.copyWith(color: KBlue)),
                  //       SizedBox(
                  //         height: 25,
                  //         child: DropdownButton<Ethnicity>(
                  //           underline: const SizedBox(),
                  //           isExpanded: true,
                  //           dropdownColor: KDullBlack,
                  //           iconEnabledColor: Colors.red,
                  //           focusColor: Colors.green,
                  //           icon: const Icon(Icons.arrow_drop_down_rounded,color: KWhite,size: 20,),
                  //           items: profileDetail.ethnicities!.map((value) {
                  //             return DropdownMenuItem<Ethnicity>(
                  //               value: value,
                  //               child: Text(value.ethnicity??'',style: proximaBold.copyWith(color: KWhite)),
                  //             );
                  //           }).toList(),
                  //           onChanged: (newValue){
                  //             print(newValue);
                  //             userDetail.ethnicityId=newValue!.ethnicityId;
                  //             setState(() {});
                  //           },
                  //           value: profileDetail.ethnicities!.where((element) => element.ethnicityId==userDetail.ethnicityId).first,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE,vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: KDullBlack
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Body Type",style: proximaBold.copyWith(color: KBlue)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(profileDetail.bodyTypes!.where((element) => element.bodyTypeId==userDetail.bodyTypeId).first.bodyType??'',style: proximaBold.copyWith(color: KWhite)),
                            SizedBox(
                              height: 30,
                              child: CupertinoButton(
                                  alignment: Alignment.topRight,
                                  padding: EdgeInsets.zero,
                                  child: const Icon(Icons.arrow_drop_down_rounded,color: KWhite,),
                                  onPressed: () {
                                    selectedId=userDetail.bodyTypeId!;
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                            color: KWhite,
                                            height: 400,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                CupertinoButton(
                                                  child: Text("Cancel",style: proximaBold.copyWith(color: KBlue)),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                Expanded(
                                                  child: CupertinoPicker(
                                                      scrollController: FixedExtentScrollController(
                                                        initialItem: profileDetail.bodyTypes!.indexWhere((element) => selectedId==element.bodyTypeId),
                                                      ),
                                                      itemExtent: 50.0,
                                                      onSelectedItemChanged: (int index) {
                                                        selectedId = profileDetail.bodyTypes![index].bodyTypeId!;
                                                      },
                                                      children:  profileDetail.bodyTypes!.map((e) => Center(child: Text(e.bodyType??'',style: proximaBold.copyWith(color: KPureBlack,fontSize: 24)),),).toList()
                                                  ),
                                                ),
                                                CupertinoButton(
                                                  child: Text("Ok",style: proximaBold.copyWith(color: KBlue)),
                                                  onPressed: () {
                                                    userDetail.bodyTypeId=selectedId;
                                                    setState(() {

                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE,vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  //   margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(40),
                  //       color: KDullBlack
                  //   ),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text("Body Type",style: proximaBold.copyWith(color: KBlue)),
                  //       SizedBox(
                  //         height: 25,
                  //         child: DropdownButton<BodyType>(
                  //           underline: const SizedBox(),
                  //           isExpanded: true,
                  //           dropdownColor: KDullBlack,
                  //           icon: const Icon(Icons.arrow_drop_down_rounded,color: KWhite,size: 20,),
                  //           items: profileDetail.bodyTypes!.map((value) {
                  //             return DropdownMenuItem<BodyType>(
                  //               value: value,
                  //               child: Text(value.bodyType??'',style: proximaBold.copyWith(color: KWhite)),
                  //             );
                  //           }).toList(),
                  //           onChanged: (value){
                  //             print(value);
                  //             userDetail.bodyTypeId=value!.bodyTypeId;
                  //             setState(() {});
                  //           },
                  //           value: profileDetail.bodyTypes!.where((element) => element.bodyTypeId==userDetail.bodyTypeId).first,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE,vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: KDullBlack
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Position",style: proximaBold.copyWith(color: KBlue)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(profileDetail.positions!.where((element) => element.positionId==userDetail.positionId).first.position??'',style: proximaBold.copyWith(color: KWhite)),
                            SizedBox(
                              height: 30,
                              child: CupertinoButton(
                                  alignment: Alignment.topRight,
                                  padding: EdgeInsets.zero,
                                  child: const Icon(Icons.arrow_drop_down_rounded,color: KWhite,),
                                  onPressed: () {
                                    selectedId=userDetail.positionId!;
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                            color: KWhite,
                                            height: 400,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                CupertinoButton(
                                                  child: Text("Cancel",style: proximaBold.copyWith(color: KBlue)),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                Expanded(
                                                  child: CupertinoPicker(
                                                      scrollController: FixedExtentScrollController(
                                                        initialItem: profileDetail.positions!.indexWhere((element) => selectedId==element.positionId),
                                                      ),
                                                      itemExtent: 50.0,
                                                      onSelectedItemChanged: (int index) {
                                                        selectedId = profileDetail.positions![index].positionId!;
                                                      },
                                                      children:  profileDetail.positions!.map((e) => Center(child: Text(e.position??'',style: proximaBold.copyWith(color: KPureBlack,fontSize: 24)),),).toList()
                                                  ),
                                                ),
                                                CupertinoButton(
                                                  child: Text("Ok",style: proximaBold.copyWith(color: KBlue)),
                                                  onPressed: () {
                                                    userDetail.positionId=selectedId;
                                                    setState(() {

                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE,vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  //   margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(40),
                  //       color: KDullBlack
                  //   ),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text("Position",style: proximaBold.copyWith(color: KBlue)),
                  //       SizedBox(
                  //         height: 25,
                  //         child: DropdownButton<Position>(
                  //           underline: const SizedBox(),
                  //           isExpanded: true,
                  //           dropdownColor: KDullBlack,
                  //           icon: const Icon(Icons.arrow_drop_down_rounded,color: KWhite,size: 20,),
                  //           items: profileDetail.positions!.map((value) {
                  //             return DropdownMenuItem<Position>(
                  //               value: value,
                  //               child: Text(value.position??"",style: proximaBold.copyWith(color: KWhite)),
                  //             );
                  //           }).toList(),
                  //           onChanged: (value){
                  //             userDetail.positionId=value!.positionId;
                  //             setState(() {});
                  //           },
                  //           value: profileDetail.positions!.where((element) => element.positionId==userDetail.positionId).first,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE,vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: KDullBlack
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Relationship",style: proximaBold.copyWith(color: KBlue)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(profileDetail.relationships!.where((element) => element.relationshipId==userDetail.relationshipId).first.relationship??'',style: proximaBold.copyWith(color: KWhite)),
                            SizedBox(
                              height: 30,
                              child: CupertinoButton(
                                  alignment: Alignment.topRight,
                                  padding: EdgeInsets.zero,
                                  child: const Icon(Icons.arrow_drop_down_rounded,color: KWhite,),
                                  onPressed: () {
                                    selectedId=userDetail.relationshipId!;
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                            color: KWhite,
                                            height: 400,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                CupertinoButton(
                                                  child: Text("Cancel",style: proximaBold.copyWith(color: KBlue)),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                Expanded(
                                                  child: CupertinoPicker(
                                                      scrollController: FixedExtentScrollController(
                                                        initialItem: profileDetail.relationships!.indexWhere((element) => selectedId==element.relationshipId),
                                                      ),
                                                      itemExtent: 50.0,
                                                      onSelectedItemChanged: (int index) {
                                                        selectedId = profileDetail.relationships![index].relationshipId!;
                                                      },
                                                      children:  profileDetail.relationships!.map((e) => Center(child: Text(e.relationship??'',style: proximaBold.copyWith(color: KPureBlack,fontSize: 24)),),).toList()
                                                  ),
                                                ),
                                                CupertinoButton(
                                                  child: Text("Ok",style: proximaBold.copyWith(color: KBlue)),
                                                  onPressed: () {
                                                    userDetail.relationshipId=selectedId;
                                                    setState(() {

                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE,vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  //   margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(40),
                  //       color: KDullBlack
                  //   ),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text("Relationship",style: proximaBold.copyWith(color: KBlue)),
                  //       SizedBox(
                  //         height: 25,
                  //         child: DropdownButton<RelationShip>(
                  //           underline: const SizedBox(),
                  //           isExpanded: true,
                  //           dropdownColor: KDullBlack,
                  //           icon: const Icon(Icons.arrow_drop_down_rounded,color: KWhite,size: 20,),
                  //           items: profileDetail.relationships!.map((value) {
                  //             return DropdownMenuItem<RelationShip>(
                  //               value: value,
                  //               child: Text(value.relationship??'',style: proximaBold.copyWith(color: KWhite)),
                  //             );
                  //           }).toList(),
                  //           onChanged: (value){
                  //             userDetail.relationshipId=value!.relationshipId;
                  //             setState(() {});
                  //           },
                  //           value: profileDetail.relationships!.where((element) => element.relationshipId==userDetail.relationshipId).first,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),



                  GestureDetector(
                    onTap: (){
                      print('dilof opening');
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              titlePadding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.25,top: 10),
                              backgroundColor: KfilterDialog,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              title: Text('Looking For',style: TextStyle(color: KWhite),),
                              content: Container(
                                width: MediaQuery.of(context).size.width*1,
                                height: MediaQuery.of(context).size.height*0.7,// Change as per your requirement
                                child: ListView.builder(
                                  shrinkWrap: true,

                                  itemCount: profileDetail.seeking!.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: (){
                                        setState(() {
                                          if(userDetail.userSeeking!.contains(profileDetail.seeking![index].seekingId)){
                                            userDetail.userSeeking?.remove(profileDetail.seeking![index].seekingId);
                                          }
                                          else{
                                            userDetail.userSeeking?.add(profileDetail.seeking![index].seekingId!);
                                          }
                                        });
                                        print('result');
                                        print(userDetail.userSeeking!.toString());
                                      },
                                      child: ListTile(
                                          title: Text(profileDetail.seeking![index].seeking!,style: TextStyle(color: userDetail.userSeeking!.contains(profileDetail.seeking![index].seekingId)? KBlue:KWhite),),
                                          trailing: Icon(userDetail.userSeeking!.contains(profileDetail.seeking![index].seekingId)? Icons.check: null, color: KBlue,)
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          });
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width*0.8,
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE,vertical: 8),
                      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: KDullBlack
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Looking For",style: proximaBold.copyWith(color: KBlue)),
                          SizedBox(height: 5,),

                        ],
                      ),
                    ),
                  ),
























                  // Container(
                  //   width: MediaQuery.of(context).size.width*0.8,
                  //   padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE,vertical: 8),
                  //   margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(20),
                  //       color: KDullBlack
                  //   ),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text("Looking For",style: proximaBold.copyWith(color: KBlue)),
                  //       SizedBox(height: 5,),
                  //       Wrap(
                  //         spacing: 5,
                  //         runSpacing: 8,
                  //         children: [
                  //           for(int i=0;i<profileDetail.seeking!.length;i++)
                  //             InkWell(onTap:(){
                  //               if(userDetail.userSeeking!.contains(profileDetail.seeking![i].seekingId)){
                  //                 userDetail.userSeeking?.remove(profileDetail.seeking![i].seekingId);
                  //               }
                  //               else{
                  //                 userDetail.userSeeking?.add(profileDetail.seeking![i].seekingId!);
                  //               }
                  //               setState(() {});
                  //             },
                  //                 child: ValueContainer(value: profileDetail.seeking![i].seeking!,isSelected: userDetail.userSeeking!.contains(profileDetail.seeking![i].seekingId))
                  //             ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),



                  GestureDetector(
                      onTap: (){
                      print('dilog opening');
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              titlePadding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.25,top: 10),
                              backgroundColor: KfilterDialog,
                              shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                  ),
                              title: Text('My Tribes',style: TextStyle(color: KWhite),),

                              content: Container(
                                width: MediaQuery.of(context).size.width*1,
                                height: MediaQuery.of(context).size.height*0.7,// Change as per your requirement
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: profileDetail.tribes!.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: (){
                                        setState(() {
                                          if(userDetail.userTribes!.contains(profileDetail.tribes![index].tribeId)){
                                              userDetail.userTribes?.remove(profileDetail.tribes![index].tribeId);
                                           }
                                           else{
                                              userDetail.userTribes?.add(profileDetail.tribes![index].tribeId!);
                                           }
                                        });
                                        print('result');
                                        print(userDetail.userTribes!.toString());
                                      },
                                      child: ListTile(
                                        title: Text(profileDetail.tribes![index].tribe!,style: TextStyle(color: userDetail.userTribes!.contains(profileDetail.tribes![index].tribeId)? KBlue:KWhite),),
                                        trailing: Icon(userDetail.userTribes!.contains(profileDetail.tribes![index].tribeId)? Icons.check: null, color: KBlue,)
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          });

                      // Dialog tribeDialog = Dialog(
                      //   backgroundColor: KfilterDialog,
                      //   shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(12.0),
                      //   ), //this right here
                      //   child: Container(
                      //     width: MediaQuery.of(context).size.width*1,
                      //     height: MediaQuery.of(context).size.height*1,
                      //    // color: ,
                      //
                      //     child: SingleChildScrollView(
                      //       physics: BouncingScrollPhysics(),
                      //       child: Padding(
                      //         padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT,horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                      //         child: Column(
                      //           mainAxisAlignment: MainAxisAlignment.start,
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: <Widget>[
                      //             Row(
                      //               children: [
                      //                 Expanded(
                      //                   child: Center(
                      //                       child: MyText(
                      //                         text: "MY TRIBES",
                      //                         color: KWhite,
                      //                         fontFamily: "Proxima",
                      //                         size: 20,
                      //                         weight: FontWeight.w700,
                      //                       )),
                      //                 ),
                      //                 InkWell(
                      //                   onTap: () {
                      //                     Navigator.pop(context);
                      //                   },
                      //                   child: SvgPicture.asset(Images.Cancel),
                      //                 )
                      //               ],
                      //             ),
                      //             spaceVertical(20),
                      //             Text("Select My Tribes",style: proximaExtraBold.copyWith(color: KWhite,),),
                      //
                      //               Wrap(
                      //                   spacing: 5,
                      //                   runSpacing: 8,
                      //                   children: [
                      //                   for(int i=0;i<profileDetail.tribes!.length;i++)
                      //                     InkWell(onTap:(){
                      //                       print('profileDetail.tribes!.length');
                      //                       print(profileDetail.tribes!.length);
                      //                       print('profileDetail.tribes![i].tribe!');
                      //                       print(profileDetail.tribes![i].tribe!);
                      //                       if(userDetail.userTribes!.contains(profileDetail.tribes![i].tribeId)){
                      //                           userDetail.userTribes?.remove(profileDetail.tribes![i].tribeId);
                      //                       }
                      //                       else{
                      //                         userDetail.userTribes?.add(profileDetail.tribes![i].tribeId!);
                      //                       }
                      //                       print('userDetail.userTribes!.contains(profileDetail.tribes![i].tribeId)');
                      //                       print(userDetail.userTribes!.contains(profileDetail.tribes![i].tribeId));
                      //                       tribetxt[i] = profileDetail.tribes![i].tribe!;
                      //                       setState(() {});
                      //                       },
                      //                       child: ValueContainer(value: profileDetail.tribes![i].tribe!,isSelected: userDetail.userTribes!.contains(profileDetail.tribes![i].tribeId))
                      //                     ),
                      //                   ],
                      //               ),
                      //             SizedBox(height: 30,),
                      //             Center(
                      //               child: Container(
                      //                 height: 35,
                      //                 width: MediaQuery.of(context).size.width/3.5,
                      //                 child: MyButton(
                      //                   onPressed: () {
                      //                     Navigator.of(context).pop();
                      //                     print('list');
                      //                     print(tribetxt);
                      //                     //tribetxt =
                      //                     setState(() {});
                      //                   },
                      //                   buttonColor: KMediumBlue,
                      //                   text: "OK",
                      //                   textColor: KWhite,
                      //                   textWeight: FontWeight.w700,
                      //                   fontFamily: "Proxima",
                      //                   size: 16,
                      //                 ),
                      //
                      //               ),
                      //             ),
                      //
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // );
                      // showDialog(context: context, builder: (BuildContext context) => tribeDialog);
                    },
                    child: Container(
                     height: 50,
                      width: MediaQuery.of(context).size.width*0.8,
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE,vertical: 8),
                      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: KDullBlack
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("My Tribes",style: proximaBold.copyWith(color: KBlue)),
                          SizedBox(height: 5,),
                          //Text(tribetxt[i]),
                          // Wrap(
                          //   spacing: 5,
                          //   runSpacing: 8,
                          //   children: [
                          //     for(int i=0;i<profileDetail.tribes!.length;i++)
                          //       InkWell(onTap:(){
                          //         if(userDetail.userTribes!.contains(profileDetail.tribes![i].tribeId)){
                          //           userDetail.userTribes?.remove(profileDetail.tribes![i].tribeId);
                          //         }
                          //         else{
                          //           userDetail.userTribes?.add(profileDetail.tribes![i].tribeId!);
                          //         }
                          //         print('userDetail.userTribes!.contains(profileDetail.tribes![i].tribeId)');
                          //         print(userDetail.userTribes!.contains(profileDetail.tribes![i].tribeId));
                          //         setState(() {});
                          //       },
                          //         child: ValueContainer(value: profileDetail.tribes![i].tribe!,isSelected: userDetail.userTribes!.contains(profileDetail.tribes![i].tribeId))
                          //       ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE,vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: KDullBlack
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("HIV Status",style: proximaBold.copyWith(color: KBlue)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(userDetail.hivStatus??'',style: proximaBold.copyWith(color: KWhite)),
                        //Text(profileDetail.relationships!.where((element) => element.relationshipId==userDetail.relationshipId).first.relationship??'',style: proximaBold.copyWith(color: KWhite)),
                        SizedBox(
                          height: 30,
                          child: CupertinoButton(
                              alignment: Alignment.topRight,
                              padding: EdgeInsets.zero,
                              child: const Icon(Icons.arrow_drop_down_rounded,color: KWhite,),
                              onPressed: () {
                                selectedId=userDetail.relationshipId!;
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        color: KWhite,
                                        height: 400,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            CupertinoButton(
                                              child: Text("Cancel",style: proximaBold.copyWith(color: KBlue)),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            Expanded(
                                              child: CupertinoPicker(
                                                  scrollController: FixedExtentScrollController(
                                                    initialItem: hiv_status.indexWhere((element) => userDetail.hivStatus==element),
                                                  ),
                                                  itemExtent: 50.0,
                                                  onSelectedItemChanged: (int index) {
                                                    val = hiv_status[index];
                                                  },
                                                  children:  hiv_status.map((e) => Center(child: Text(e,style: proximaBold.copyWith(color: KPureBlack,fontSize: 24)),),).toList()
                                              ),
                                            ),
                                            CupertinoButton(
                                              child: Text("Ok",style: proximaBold.copyWith(color: KBlue)),
                                              onPressed: () {
                                                userDetail.hivStatus=val;
                                                setState(() {

                                                });
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Container(
              //     padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE,vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              //     margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(40),
              //         color: KDullBlack
              //     ),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text("HIV Status",style: proximaBold.copyWith(color: KBlue,fontSize: Dimensions.fontSizeDefault),),
              //             SizedBox(height: 4,),
              //             //Text(hive?"Yes":"No",style: proximaBold.copyWith(color: KWhite,fontSize: Dimensions.fontSizeDefault),),
              //
              //           ],
              //         ),
              //         // FlutterSwitch(
              //         //   height: 25,
              //         //   width: 45,
              //         //   padding: 1,
              //         //   toggleSize: 24,
              //         //   activeColor: KBlue,
              //         //   inactiveToggleColor: KDullBlack,
              //         //   value: hive,
              //         //   onToggle: (value) {
              //         //     setState(() {
              //         //       hive = value;
              //         //       userDetail.hivStatus=hive?"True":"False";
              //         //     });
              //         //   },
              //         // ),
              //       ],
              //     )
              // ),

              GestureDetector(
                onTap: () async{
                  DateTime? selected;
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          color: KWhite,
                          height: 200,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: CupertinoDatePicker(
                                  onDateTimeChanged: (DateTime date) {
                                    selected=date;
                                  },
                                  mode: CupertinoDatePickerMode.date,
                                  initialDateTime: vaccinationDate,
                                  minimumDate: DateTime(2000),
                                  maximumDate: DateTime.now(),
                                ),
                              ),
                              CupertinoButton(
                                child: Text("OK",style: proximaBold.copyWith(color: KBlue)),
                                onPressed: () {
                                  if (selected != null && selected != vaccinationDate) {
                                    print(selected);
                                    setState(() {
                                      vaccinationDate = selected!;
                                      vaccination=DateFormat("dd MMM, yyyy").format(vaccinationDate);
                                      userDetail.dateOfLastTest=DateFormat("yyyy-MM-dd").format(vaccinationDate);
                                    });
                                  }
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      });

                  // final DateTime? selected = await showDatePicker(
                  //   context: context,
                  //   builder: (context, child)=>Theme(data: ThemeData().copyWith(
                  //       colorScheme: const ColorScheme.dark(
                  //         surface: KDullBlack,
                  //         primary: KBlue,
                  //         onSurface: KWhite,
                  //         secondary: KWhite,
                  //       ),
                  //       indicatorColor: KWhite,
                  //       dialogBackgroundColor: KDullBlack
                  //   ), child: child!,
                  //   ),
                  //   initialDate: selectedDate,
                  //   firstDate: DateTime(1970),
                  //   lastDate: DateTime.now(),
                  // );
                  // if (selected != null && selected != selectedDate) {
                  //   print(selected);
                  //   selectedDate = selected;
                  //   DOB=DateFormat("dd MMM, yyyy").format(selectedDate);
                  //   userDetail.birthday=DateFormat("yyyy-MM-dd").format(selectedDate);
                  //   print(DOB);
                  //   setState(() {});
                  // }
                },
                child: EditField(title: "Date of Last Test",value: vaccination,isEnabled: false,controller: TextEditingController(text: vaccination),),
              ),

              // GestureDetector(
              //   onTap: () async{
              //     final DateTime? selected = await showDatePicker(
              //       context: context,
              //       builder: (context, child)=>Theme(data: ThemeData().copyWith(
              //           colorScheme: const ColorScheme.dark(
              //             surface: KDullBlack,
              //             primary: KBlue,
              //             onSurface: KWhite,
              //             secondary: KWhite,
              //           ),
              //           indicatorColor: KWhite,
              //           dialogBackgroundColor: KDullBlack
              //       ), child: child!,
              //       ),
              //       initialDate: vaccinationDate,
              //       firstDate: DateTime(2000),
              //       lastDate: DateTime.now(),
              //     );
              //     if (selected != null && selected != vaccinationDate) {
              //       print(selected);
              //       setState(() {
              //         vaccinationDate = selected;
              //         vaccination=DateFormat("dd MMM, yyyy").format(vaccinationDate);
              //         userDetail.dateOfLastTest=DateFormat("yyyy-MM-dd").format(vaccinationDate);
              //       });
              //     }
              //   },
              //   child: EditField(title: "Date of Last Test",value: vaccination,isEnabled: false,controller: TextEditingController(text: vaccination),),
              // ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE,vertical: 8),
                  margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: KDullBlack
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("COVID 19 vaccine",style: proximaBold.copyWith(color: KBlue,fontSize: Dimensions.fontSizeDefault),),
                          SizedBox(height: 4,),
                          Text(covid?"Yes":"No",style: proximaBold.copyWith(color: KWhite,fontSize: Dimensions.fontSizeDefault),),
                        ],
                      ),
                      FlutterSwitch(
                        height: 25,
                        width: 45,
                        padding: 1,
                        toggleSize: 24,
                        activeColor: KBlue,
                        inactiveToggleColor: KDullBlack,
                        value: covid,
                        onToggle: (value) {
                          setState(() {
                            covid = value;
                            userDetail.covidVaccine=covid?"True":"False";
                          });
                        },
                      ),
                    ],
                  )
              ),
              EditField(title:"Instagram",value: userDetail.instagramLink??'',onChanged: (val) => userDetail.instagramLink=val,controller: TextEditingController(text: userDetail.instagramLink),),
              EditField(title:"Twitter",value: userDetail.twitterLink??'',onChanged: (val) => userDetail.twitterLink=val,controller: TextEditingController(text: userDetail.twitterLink),),
              EditField(title:"Facebook",value: userDetail.facebookLink??'',onChanged: (val) => userDetail.facebookLink=val,controller: TextEditingController(text: userDetail.facebookLink),)


              //EditFieldSocials(title: "Instagram",value: userDetail.instagramLink??'',onChanged: (val) => userDetail.instagramLink=val,controller: TextEditingController(text: userDetail.instagramLink),hinttxt: 'Enter your Instagram username', img: 'assets/images/instagram.png',),
              //EditFieldSocials(title: "Twitter",value: userDetail.twitterLink??'',onChanged: (val) => userDetail.twitterLink=val,controller: TextEditingController(text: userDetail.twitterLink),hinttxt: 'Enter your Twitter handle', img: 'assets/images/twitter.png',),
              //EditFieldSocials(title: "Facebook",value: userDetail.facebookLink??'',onChanged: (val) => userDetail.facebookLink=val,controller: TextEditingController(text: userDetail.facebookLink),hinttxt: 'Enter your Facebook username', img: 'assets/images/facebook.png',),

            ],
          ),
        ),
      ),
    );
  }
  void getPredefinedProfileDetail() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.get('get_predefined_profile_details');
    if(response['status']=='success'){
      var jsonData= response['data'];
      profileDetail=ProfileDetail.fromJson(jsonData);
      Navigator.pop(context);
      isLoading=false;
      setState(() {});

    }
    else{
      Navigator.pop(context);
      print(response['message']);
      showCustomSnackBar(response['message']);
    }

  }

  // void checkingapi() async {
  //   print('checking api method');
  //   var response;
  //   response = await DioService.get('https://microwd.eigix.net/api/system_settings');
  //   if(response['status']=='success'){
  //     print('here is the response');
  //     print(response.toString());
  //     print(response);
  //     setState(() {});
  //
  //   }
  //   else{
  //     //Navigator.pop(context);
  //     print(response['message']);
  //     print('error is printing the result');
  //     showCustomSnackBar(response['message']);
  //   }
  //
  // }


  void getUserProfileDetail() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('get_user_profile_details', {
      "usersId" : AppData().userdetail!.usersId
    });
    if(response['status']=='success'){
      var jsonData= response['data'];
      userDetail=UserDetail.fromJson(jsonData);
      print(userDetail.toJson());
      showAge=userDetail.showAge=="True";
      covid=userDetail.covidVaccine=="True";
      hive=userDetail.hivStatus=="True";
      descriptionController.text=userDetail.description??"";
      selectedDate=DateTime.tryParse(userDetail.birthday??'')??selectedDate;
      DOB=userDetail.birthday==null?"":DateFormat("dd MMM, yyyy").format(selectedDate!);
      vaccinationDate= DateTime.tryParse(userDetail.dateOfLastTest??'')??vaccinationDate;
      vaccination=DateFormat("dd MMM, yyyy").format(vaccinationDate);
      vaccination=userDetail.dateOfLastTest==null?'':vaccination;
      Navigator.pop(context);
      setState(() {});
    }
    else{
      Navigator.pop(context);
      print(response['message']);
      showCustomSnackBar(response['message']);
    }

  }

  void updateProfileDetail() async {
    print(userDetail.toJson());
    userDetail.description=descriptionController.text;
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('update_profile_details', {
      "usersId":AppData().userdetail!.usersId.toString(),
      "description": userDetail.description,
      "gender": userDetail.gender,
      "birthday":userDetail.birthday,
      "showAge":userDetail.showAge,
      "height":userDetail.height,
      "weight":userDetail.weight,
      "ethnicityId":userDetail.ethnicityId.toString(),
      "bodyTypeId":userDetail.bodyTypeId.toString(),
      "positionId":userDetail.positionId.toString(),
      "relationshipId":userDetail.relationshipId.toString(),
      "seekingIds":userDetail.userSeeking,
      "tribeIds":userDetail.userTribes,
      "hivStatus":userDetail.hivStatus,
      "dateOfLastTest":userDetail.dateOfLastTest,
      "covidVaccine":userDetail.covidVaccine,
      "facebookLink":userDetail.facebookLink,
      "instagramLink":userDetail.instagramLink,
      "twitterLink":userDetail.twitterLink
    });
    if(response['status']=='success'){
      showCustomSnackBar(response['data'],isError: false);
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
