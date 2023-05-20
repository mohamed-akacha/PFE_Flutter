import 'package:get/get.dart';
import 'package:pfe_flutter/core/class/statusrequest.dart';
import 'package:pfe_flutter/core/functions/handingdatacontroller.dart';
import 'package:pfe_flutter/data/datasource/remote/forgetpassword/verifycode.dart';

import '../../core/constant/routes.dart';

abstract class VerifyCodeController extends GetxController {
  checkCode();
  goToResetPassword(String verifycode);
}

class VerifyCodeControllerImp extends VerifyCodeController {
  String? email;

  VerifyCodeForgetPasswordData verifyCodeForgetPasswordData =
  VerifyCodeForgetPasswordData(Get.find());

  StatusRequest statusRequest = StatusRequest.none;

  @override
  checkCode() {}

  @override
  goToResetPassword(verifycode) async {
    statusRequest = StatusRequest.loading;
    print("verifycode ++++++++ $verifycode");
    update();
    var response = await verifyCodeForgetPasswordData.postdata(email!, verifycode);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['success'] == true) {
        Get.offNamed(AppRoute.resetPassword , arguments: {
          "email" : email
        });
      } else {
        Get.defaultDialog(
            title: "ُWarning", middleText: "Verify Code Not Correct");
        statusRequest = StatusRequest.failure;
      }
    }else if(StatusRequest.serverfailure == statusRequest){
      Get.defaultDialog(
          title: "ُWarning", middleText: "Verify Code Not Correct");
      statusRequest = StatusRequest.failure;
    }else if(StatusRequest.offlinefailure == statusRequest) {
      Get.defaultDialog(
          title: "ُWarning", middleText: "No Internet Connection");
      statusRequest = StatusRequest.failure;
    }

    update();
  }

  @override
  void onInit() {
    email = Get.arguments['email'];
    super.onInit();
  }
}

