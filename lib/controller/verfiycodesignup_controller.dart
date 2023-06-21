import 'package:get/get.dart';
import 'package:pfe_flutter/core/constant/routes.dart';

abstract class VerifyCodeSignUpController extends GetxController {
  checkCode();
  goToSuccessSignUp();
}

class VerifyCodeSignUpControllerImp extends VerifyCodeSignUpController {  

  late String verifycode  ; 

  @override
  checkCode() {}

  @override
  goToSuccessSignUp() {
    //Get.offNamed(AppRoute.successSignUp);
  }


 
}