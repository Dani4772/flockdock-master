import 'package:flocdock/View/Screens/create_event/widget/cover.dart';
import 'package:flocdock/View/Screens/create_event/widget/value_container.dart';
import 'package:flocdock/View/Widgets/my_button.dart';
import 'package:flocdock/View/Widgets/my_spacing.dart';
import 'package:flocdock/View/Widgets/my_text.dart';
import 'package:flocdock/View/base/custom_snackbar.dart';
import 'package:flocdock/View/base/loading_dialog.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/images.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flocdock/models/groupModel/category_model.dart';
import 'package:flocdock/models/groupModel/event_model.dart';
import 'package:flocdock/services/dio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:places_service/places_service.dart';

GroupDetail filterData=GroupDetail(groupCategories: [],tribes: [],features: [],importantRules: []);

class FilterDialog extends StatefulWidget {
  void Function(EventDetail)? applyFilter;
  void Function()? cancelFilter;
  EventDetail filterDetail=EventDetail(categories: [],tribes: [],features: [],rules: [],);
  FilterDialog({Key? key,required this.filterDetail,this.applyFilter,this.cancelFilter}) : super(key: key);

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  TextEditingController _dateController = TextEditingController();
  double _currentSliderValue = 20;
  TextEditingController addressController = TextEditingController();
  String radioButtonItem = 'ONE';
  int id = 1;
  List<String> tribeList=[];
  List<String> importantRules=[];
  List<String> features=[];
  int selected=1;
  int cost=0;
  DateTime selectedDate=DateTime.now();
  String date="";
  int show=0;
  PlacesService  placesService = PlacesService();
  List<PlacesAutoCompleteResult>  _autoCompleteResult=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    placesService.initialize(apiKey: AppConstants.apiKey);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      filterData.tribes!.isEmpty?getCategories():null;
    });
    selectedDate=DateTime.tryParse(widget.filterDetail.date??'')??selectedDate;
    date= DateFormat("dd MMM, yyyy").format(selectedDate);
    widget.filterDetail.cover=="Free Admittance"?selected=1:selected=2;
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Dialog(
          insetPadding: EdgeInsets.symmetric(vertical: 50,horizontal:13),
          elevation: 10,
          backgroundColor: KfilterDialog,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
            ),
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT,horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Center(
                                child: MyText(
                              text: "FILTERS",
                              color: KWhite,
                              fontFamily: "Proxima",
                              size: 20,
                              weight: FontWeight.w700,
                            )),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset(Images.Cancel),
                          )
                        ],
                      ),
                      spaceVertical(10),
                      Text("Date",style: proximaExtraBold.copyWith(color: KWhite,),),
                      spaceVertical(3),
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
                                          initialDateTime: selectedDate,
                                          minimumDate: DateTime(1970),
                                          maximumDate: DateTime.now(),
                                        ),
                                      ),
                                      CupertinoButton(
                                        child: Text("OK",style: proximaBold.copyWith(color: KBlue)),
                                        onPressed: () {
                                          if (selected != null && selected != selectedDate) {
                                            print(selected);
                                            selectedDate = selected!;
                                            date=DateFormat("dd MMM, yyyy").format(selectedDate);
                                            widget.filterDetail.date=DateFormat("yyyy-MM-dd").format(selectedDate);
                                            setState(() {});
                                          }
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              });

                        },
                        child: Container(
                          height: 49,
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE,),
                          //margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: KDullBlack
                          ),
                          child: TextFormField(
                              controller: TextEditingController(text: date),
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: KWhite,
                              autofocus: false,
                              enabled: false,
                              style:  TextStyle(
                                  color: KWhite.withOpacity(0.5),
                                  fontFamily: "Proxima"
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: KWhite,fontFamily: "Proxima"),
                              )
                          ),
                        ),
                      ),
                      spaceVertical(10),
                      Text("Location",style: proximaExtraBold.copyWith(color: KWhite,),),
                      spaceVertical(3),
                      Container(
                        height: 49,
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE,),
                        //margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: KDullBlack
                        ),
                        child: TextFormField(
                            controller: addressController,
                            keyboardType: TextInputType.streetAddress,
                            onChanged: (value) async {
                              if(value==""){
                                setState(() {
                                  _autoCompleteResult.clear();
                                });
                              }
                              else{
                                print(value);
                                print(addressController.text);
                                final autoCompleteSuggestions = await placesService.getAutoComplete(value);
                                _autoCompleteResult = autoCompleteSuggestions;
                                setState(() {});
                              }
                              //print(_autoCompleteResult.first.mainText);
                            },
                            cursorColor: KWhite,
                            autofocus: false,
                            enabled: true,
                            style:  TextStyle(
                                color: KWhite.withOpacity(0.5),
                                fontFamily: "Proxima"
                            ),
                            decoration:  InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: KWhite.withOpacity(0.5),fontFamily: "Proxima"),
                            )
                        ),
                      ),
                      if (_autoCompleteResult.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.9,
                            decoration: const BoxDecoration(
                              color: KDullBlack,
                              //: Border.all(color: Colors.black)
                            ),
                            height: 140,
                            child: ListView.builder(
                              itemCount: _autoCompleteResult.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(_autoCompleteResult[index].mainText ?? "",style: proximaBold.copyWith(color: KWhite),),
                                  //subtitle: Text(_autoCompleteResult[index].description ?? ""),
                                  onTap: () async {
                                    var id = _autoCompleteResult[index].placeId;
                                    final placeDetails = await placesService.getPlaceDetails(id!);
                                    print(placeDetails);
                                    addressController.text="${_autoCompleteResult[index].mainText??''}${_autoCompleteResult[index].secondaryText??''}";
                                    widget.filterDetail.address=addressController.text;
                                    _autoCompleteResult.clear();
                                    setState(() {});
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      spaceVertical(13),
                      GestureDetector(onTap: () => setState(() {show=1;}),child: Text("Type of Group",style: proximaExtraBold.copyWith(color: KWhite,),)),
                      spaceVertical(12),
                      if(show==1)Wrap(
                        spacing: 5,
                        runSpacing: 12,
                        children: [
                          for(int i=0;i<filterData.groupCategories!.length;i++)
                            InkWell(onTap:(){
                              if(widget.filterDetail.categories!.contains(filterData.groupCategories![i].categoryId)){
                                widget.filterDetail.categories?.remove(filterData.groupCategories![i].categoryId);
                              }
                              else{
                                widget.filterDetail.categories?.add(filterData.groupCategories![i].categoryId!);
                              }
                              setState(() {});
                            },
                                child: ValueContainer(value: filterData.groupCategories![i].category!,isSelected: widget.filterDetail.categories!.contains(filterData.groupCategories![i].categoryId))
                            ),
                        ],
                      ),
                      spaceVertical(13),
                      GestureDetector(onTap: () => setState(() {show=2;}),child: Text("Tribe",style: proximaExtraBold.copyWith(color: KWhite,),)),
                      spaceVertical(12),
                      if(show==2)Wrap(
                        spacing: 5,
                        runSpacing: 12,
                        children: [
                          for(int i=0;i<filterData.tribes!.length;i++)
                            InkWell(onTap:(){
                              if(widget.filterDetail.tribes!.contains(filterData.tribes![i].tribeId)){
                                widget.filterDetail.tribes?.remove(filterData.tribes![i].tribeId);
                              }
                              else{
                                widget.filterDetail.tribes?.add(filterData.tribes![i].tribeId!);
                              }
                              setState(() {});
                            },
                                child: ValueContainer(value: filterData.tribes![i].tribe!,isSelected: widget.filterDetail.tribes!.contains(filterData.tribes![i].tribeId))
                            ),
                        ],
                      ),
                      spaceVertical(13),
                      GestureDetector(onTap: () => setState(() {show=3;}),child: Text("Important Rules",style: proximaExtraBold.copyWith(color: KWhite,),)),
                      spaceVertical(12),
                      if(show==3)Wrap(
                        spacing: 5,
                        runSpacing: 12,
                        children: [
                          for(int i=0;i<filterData.importantRules!.length;i++)
                            InkWell(onTap:(){
                              if(widget.filterDetail.rules!.contains(filterData.importantRules![i].importantRuleId)){
                                widget.filterDetail.rules?.remove(filterData.importantRules![i].importantRuleId);
                              }
                              else{
                                widget.filterDetail.rules?.add(filterData.importantRules![i].importantRuleId!);
                              }
                              setState(() {});
                            },
                                child: ValueContainer(value: filterData.importantRules![i].importantRule!,isSelected: widget.filterDetail.rules!.contains(filterData.importantRules![i].importantRuleId))
                            ),
                        ],
                      ),
                      spaceVertical(13),
                      GestureDetector(onTap: () => setState(() {show=4;}),child: Text("Features",style: proximaExtraBold.copyWith(color: KWhite,),)),
                      spaceVertical(12),
                      if(show==4)Wrap(
                        spacing: 5,
                        runSpacing: 12,
                        children: [
                          for(int i=0;i<filterData.features!.length;i++)
                            InkWell(onTap:(){
                              if(widget.filterDetail.features!.contains(filterData.features![i].featureId)){
                                widget.filterDetail.features?.remove(filterData.features![i].featureId);
                              }
                              else{
                                widget.filterDetail.features?.add(filterData.features![i].featureId!);
                              }
                              setState(() {});
                            },
                                child: ValueContainer(value: filterData.features![i].feature!,isSelected: widget.filterDetail.features!.contains(filterData.features![i].featureId))
                            ),
                        ],
                      ),
                      spaceVertical(13),
                      // MyText(
                      //   text: "Top-to-Bottom Ratio",
                      //   color: KWhite,
                      //   weight: FontWeight.w400,
                      //   size: 112,
                      //   fontFamily: "Proxima",
                      // ),
                      // spaceVertical(10),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Container(
                      //       height: 29,
                      //       width: 29,
                      //       decoration: BoxDecoration(
                      //           color: KDullBlack, shape: BoxShape.circle),
                      //       child: Center(
                      //           child: MyText(
                      //         text: "Icon",
                      //         size: 12,
                      //         color: KWhite,
                      //       )),
                      //     ),
                      //     Slider(
                      //       value: _currentSliderValue,
                      //       max: 100,
                      //       activeColor: KBlue,
                      //       inactiveColor: KDullBlack,
                      //       label: _currentSliderValue.round().toString(),
                      //       onChanged: (double value) {
                      //         setState(() {
                      //           _currentSliderValue = value;
                      //         });
                      //       },
                      //     ),
                      //     Container(
                      //       height: 29,
                      //       width: 29,
                      //       decoration: BoxDecoration(
                      //           color: KDullBlack, shape: BoxShape.circle),
                      //       child: Center(
                      //           child: MyText(
                      //         text: "Icon",
                      //         color: KWhite,
                      //             size: 12,
                      //       )),
                      //     ),
                      //   ],
                      // ),
                      // spaceVertical(20),
                      Text("Cover",style: proximaExtraBold.copyWith(color: KWhite,),),
                      spaceVertical(13),
                      Cover(isSelected:selected==1,selected: (select,val){
                        selected=select;
                        cost=val;
                        widget.filterDetail.cover=selected==1?"Free Admittance":"Per Guest";
                      },
                      ),
                      spaceVertical(13),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 35,
                            width: MediaQuery.of(context).size.width/3.5,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(KDullBlack),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),)),
                              onPressed: widget.cancelFilter,
                              child: Text("Cancel",style: proximaExtraBold.copyWith(color: KWhite,),),

                            ),
                          ),
                          SizedBox(width: 10,),
                          Container(
                            height: 35,
                            width: MediaQuery.of(context).size.width/3.5,
                            child: MyButton(
                               onPressed: () => widget.applyFilter!(widget.filterDetail),
                              buttonColor: KMediumBlue,
                              text: "Apply",
                              textColor: KWhite,
                              textWeight: FontWeight.w700,
                              fontFamily: "Proxima",
                              size: 16,
                                    ),

                            ),

                        ],
                      )
                    ])),
          ),
        ),
      ),
    );
  }
  void getCategories() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.get('get_predefined_group_details');
    if(response['status']=='success'){
      var jsonData= response['data'];
      filterData =  GroupDetail.fromJson(jsonData);
      setState(() {});
      Navigator.pop(context);
    }
    else{
      Navigator.pop(context);
      print(response['message']);
      showCustomSnackBar(response['message']);
    }
  }
}
