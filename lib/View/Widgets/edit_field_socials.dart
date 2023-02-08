import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flocdock/main.dart';
import 'package:flutter/material.dart';

class EditFieldSocials extends StatefulWidget {
  String title;
  String value;
  bool isEnabled;
  String? hinttxt;
  String img;
  TextEditingController? controller=TextEditingController();
  TextInputType inputType;
  void Function(String)? onChanged;
  bool isPassword;
  EditFieldSocials({Key? key,this.title="",this.value="",this.inputType=TextInputType.text,this.isEnabled=true,this.onChanged,this.controller,this.isPassword=false,this.hinttxt, required this.img}) : super(key: key);

  @override
  State<EditFieldSocials> createState() => _EditFieldSocialsState();
}

class _EditFieldSocialsState extends State<EditFieldSocials> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10,top: 5),
      child: Container(
        height: 60,
       //padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE,vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: KDullBlack
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(widget.img,height: 30,width: 30,),
            //Icon(Icons.facebook, color: Colors.white,size: 40,),
            Padding(
              padding: EdgeInsets.only(left:10.0,top: 5),
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title,style: proximaBold.copyWith(color: KBlue)),
                    //SizedBox(height: 2,),
                    SizedBox(
                      width: 200,
                      height: 30,
                      child: TextFormField(

                        controller: widget.controller,
                        onChanged: widget.onChanged,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: KWhite,
                        autofocus: false,

                        obscureText:widget.isPassword,
                        enabled: widget.isEnabled,
                        style: TextStyle(
                            color: KWhite,
                            fontFamily: "Proxima"
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: KWhite.withOpacity(0.5),fontFamily: "Proxima",fontSize: 14),
                          hintText: widget.hinttxt,
                        )

                      ),
                    )

                  ],
                ),
              ),
            )
          ],
        )
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Text(widget.title,style: proximaBold.copyWith(color: KBlue)),
        //     SizedBox(
        //       height: 25,
        //       child: TextFormField(
        //           controller: widget.controller,
        //           onChanged: widget.onChanged,
        //           keyboardType: TextInputType.emailAddress,
        //           cursorColor: KWhite,
        //           autofocus: false,
        //           obscureText:widget.isPassword,
        //           enabled: widget.isEnabled,
        //           style: const TextStyle(
        //               color: KWhite,
        //               fontFamily: "Proxima"
        //           ),
        //           decoration: InputDecoration(
        //             border: InputBorder.none,
        //             hintStyle: TextStyle(color: KWhite.withOpacity(0.5),fontFamily: "Proxima",fontSize: 14),
        //             hintText: widget.hinttxt,
        //           )
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}