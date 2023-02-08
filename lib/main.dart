import 'package:firebase_core/firebase_core.dart';
import 'package:flocdock/View/Screens/state_library.dart';
import 'package:flocdock/constants/constants.dart';
import 'package:flocdock/mixin/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'View/Screens/splash/splash.dart';
import 'package:provider/provider.dart';
import 'applesigninavailable.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AppData.initiate();
  // final appleSignInAvailable = await AppleSignInAvailable.check();
  // MyLibrary();
  // runApp(Provider<AppleSignInAvailable>.value(
  //   value: appleSignInAvailable,
  //   child: MyApp(),
  // ));
 runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      onDispose: (){
        for(int i=0;i<10;i++)
          print("ONDISPOSE");
      },
      onInit: (){
        for(int i=0;i<10;i++)
          print("ONINIT");
      },
      onReady: (){
        for(int i=0;i<10;i++)
          print("ONREADY");
      },
      debugShowCheckedModeBanner: false,
      title: 'FlocDoc',
      theme: ThemeData(primaryColor: KDullBlack,
          appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.dark,
                statusBarColor: Colors.black
              )
          )
      ),
      home: SplashScreen(),
    );
  }
}
