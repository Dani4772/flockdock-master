import 'package:dio/dio.dart';
import 'package:flocdock/View/base/custom_snackbar.dart';
import 'package:flocdock/models/user_model/signup_model.dart';

class Auth{

  Future<void> signup(String action,Profile profile) async {
    try {
      var response = await Dio().post(action,data: {
        "userName":profile.userName,
        "userEmail":profile.userEmail,
        "userPassword": profile.userPassword,
        "confirmPassword": profile.confirmPassword
      });
      print("------------"+response.data);
      if(response.data["status"]=="success"){
        //   Get.to(() => DashboardScreen(pageIndex: 0));
      }
      else{
        showCustomSnackBar(response.data["message"]);
      }
    } catch (e) {
      print("---------------------");
      print(e.toString());
     // showCustomSnackBar(e.toString());
    }
  }
}

