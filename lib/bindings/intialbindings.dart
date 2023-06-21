import 'package:pfe_flutter/controller/calander_controller.dart';
import 'package:pfe_flutter/controller/notification_controller.dart';
import 'package:pfe_flutter/core/class/crud.dart';
import 'package:get/get.dart';
import 'package:pfe_flutter/core/services/services.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud(myServices: Get.find<MyServices>()));
    /*Get.put(CalanderController());
    Get.put(NotificationController());*/
   Get.lazyPut(()=>NotificationController());
   Get.lazyPut(()=>CalanderController());
  }
}
