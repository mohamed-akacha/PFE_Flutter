import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe_flutter/controller/settings_controller.dart';

import '../../core/constant/routes.dart';
import '../../core/localization/changelocal.dart';
import '../../core/services/services.dart';
import '../widget/laguage/custombuttomlang.dart';

class Language extends GetView<LocaleController> {
  const Language({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyServices myServices = Get.put(MyServices()) ;
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("1".tr, style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: 20),
              CustomButtonLang(
                  textbutton: "Ar",
                  onPressed: () {
                    controller.changeLang("ar");
                    myServices.sharedPreferences.setString("step", "1");
                    if (Get.isRegistered<SettingsController>()) {
                     Get.back();
                    }
                    else {
                      Get.toNamed(AppRoute.login);
                    }
                  }),
              CustomButtonLang(
                  textbutton: "En",
                  onPressed: () {
                    controller.changeLang("en");
                    myServices.sharedPreferences.setString("step", "1");
                    if (Get.isRegistered<SettingsController>()) {
                      Get.back();
                    }
                    else {
                      Get.toNamed(AppRoute.login);
                    }
                  }),
            ],
          )),
    );
  }
}
