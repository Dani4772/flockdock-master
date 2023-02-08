import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/constants/styles.dart';
import 'package:flutter/material.dart';
Widget container(Widget textField)

{
  return    Padding(
    padding: const EdgeInsets.all(4.0),
    child: Container(
        decoration: const BoxDecoration(
            boxShadow: [
              //  color:Colors.white
              BoxShadow(
                color:Colors.white,
                offset: Offset(0,0),
                blurRadius: 300,
                //   spreadRadius: 2
              )]
        ),
        child: textField
    ),
  );

}


openLoadingDialog(BuildContext context, String text) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    KBlue,
                    KDarkBlue,
                  ],
                  stops: [
                    0.0,
                    1.0,
                  ]),
              borderRadius: BorderRadius.circular(10),
              ),
              width: 120,
              height: 50,
              //padding: EdgeInsets.only(left:20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation(KWhite))),
              SizedBox(width: 15),
              Text(text,style: proximaBold.copyWith(color: KWhite,fontSize: 14,decoration: TextDecoration.none),)
            ]),
          ),
        );




  }
  );
}


openMessageDialog(BuildContext context, String text) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        content: Column(
          children: <Widget>[
            Text(text),
            Align(
              alignment: Alignment.topRight,
              child: MaterialButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.pop(context);
                },
                minWidth: 0,
              ),
            ),
          ],
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
        ),
      ));
}
