import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/dimensions.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flutter/material.dart';

class EditField extends StatefulWidget {
  String title;
  String value;
  bool isEnabled;
  String? hinttxt;
  TextEditingController? controller=TextEditingController();
  TextInputType inputType;
  void Function(String)? onChanged;
  bool isPassword;
  EditField({Key? key,this.title="",this.value="",this.inputType=TextInputType.text,this.isEnabled=true,this.onChanged,this.controller,this.isPassword=false,this.hinttxt}) : super(key: key);

  @override
  State<EditField> createState() => _EditFieldState();
}

class _EditFieldState extends State<EditField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE,vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: KDullBlack
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title,style: proximaBold.copyWith(color: KBlue)),
          SizedBox(
            height: 25,
            child: TextFormField(
              controller: widget.controller,
              onChanged: widget.onChanged,
                keyboardType: TextInputType.emailAddress,
                cursorColor: KWhite,
                autofocus: false,
                obscureText:widget.isPassword,
                enabled: widget.isEnabled,
                style: const TextStyle(
                    color: KWhite,
                    fontFamily: "Proxima"
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: KWhite.withOpacity(0.5),fontFamily: "Proxima",fontSize: 14),
                  hintText: widget.hinttxt,
                )
            ),
          ),
        ],
      ),
    );
  }
}
