import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pfe_flutter/core/class/statusrequest.dart';
import 'package:pfe_flutter/core/functions/handingdatacontroller.dart';
import 'package:pfe_flutter/data/datasource/remote/forgetpassword/checkemail.dart';

import '../../core/constant/routes.dart';

abstract class ForgetPasswordController extends GetxController {
  checkemail();
}

class ForgetPasswordControllerImp extends ForgetPasswordController {

  CheckEmailData checkEmailData  = CheckEmailData(Get.find()) ;

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  StatusRequest statusRequest  = StatusRequest.none ;

  late TextEditingController email;

  @override
  checkemail() async  {
    if (formstate.currentState!.validate()){
      statusRequest = StatusRequest.loading;
      update() ;
      var response = await checkEmailData.postdata(email.text);
      print("=============================== Controller $response ");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['success'] == true) {
          // data.addAll(response['data']);
          Get.offNamed(AppRoute.verfiyCode , arguments: {
            "email" : email.text
          });
        } else {
          Get.defaultDialog(title: "ُWarning" , middleText: "Email Not Found");
          statusRequest = StatusRequest.failure;
        }
      }else if(StatusRequest.serverfailure == statusRequest){
      Get.defaultDialog(
          title: "ُWarning", middleText: "Email Not Found");
      statusRequest = StatusRequest.failure;
    }else if(StatusRequest.offlinefailure == statusRequest) {
      Get.defaultDialog(
          title: "ُWarning", middleText: "No Internet Connection");
      statusRequest = StatusRequest.failure;
    }
      update();
    }
  }


  @override
  void onInit() {
    email = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }
}

