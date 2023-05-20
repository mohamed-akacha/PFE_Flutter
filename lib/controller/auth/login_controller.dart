import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pfe_flutter/core/services/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../core/class/statusrequest.dart';
import '../../core/constant/routes.dart';
import '../../core/functions/handingdatacontroller.dart';
import '../../data/datasource/remote/auth/login.dart';

abstract class LoginController extends GetxController {
  login();
  goToForgetPassword();
}

class LoginControllerImp extends LoginController {
  LoginData loginData = LoginData(Get.find());
  MyServices myServices = Get.find() ;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController email;
  late TextEditingController password;

  bool isshowpassword = true;

  StatusRequest statusRequest = StatusRequest.none;

  showPassword() {
    isshowpassword = isshowpassword == true ? false : true;
    update();
  }

  @override
  login() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      final response = await loginData.postdata(email.text, password.text);
      print("=============================== Controller $response ");

      if (response is StatusRequest) {
        String message;
        switch (response) {
          case StatusRequest.serverfailure:
            message = "Email Or Password Not Correct";
            break;
          case StatusRequest.serverException:
            message = "Server Exception Occurred";
            break;
          case StatusRequest.offlinefailure:
            message = "No Internet Connection";
            break;
          case StatusRequest.timeout:
            message = "Server Timeout Occurred"; // add this line
            break;
          default:
            message = "An error occurred";
        }
        Get.defaultDialog(title: "Warning", middleText: message);
        statusRequest = StatusRequest.failure;
      }
      else if (response is Map) {
        if (response.containsKey('access_token') && response['access_token'] != null) {
          var token = response['access_token'];
          myServices.sharedPreferences.setString('token', token);
          myServices.sharedPreferences.setString("step", "2");
          Get.offNamed(AppRoute.homepage);
        } else {
          Get.defaultDialog(title: "Warning", middleText: "Email Or Password Not Correct");
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    }
  }






  @override
  void onInit() {
    FirebaseMessaging.instance.getToken().then((value) {
      print(value);
      String? token = value;
    });
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  goToForgetPassword() {
    Get.toNamed(AppRoute.forgetPassword);
  }
}