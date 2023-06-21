import 'package:get/get.dart';
import 'package:pfe_flutter/core/constant/routes.dart';
import 'package:pfe_flutter/core/services/services.dart';
import 'package:pfe_flutter/view/screen/language.dart';

class SettingsController extends GetxController {
  MyServices myServices = Get.find();

  logout() {
    myServices.sharedPreferences.clear();
    Get.offAllNamed(AppRoute.login) ;
  }

  changeLanguage() {
    Get.to(() => Language());
  }
  changePassword() {
    Get.toNamed(AppRoute.forgetPassword) ;
  }
}