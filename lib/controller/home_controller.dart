import 'package:get/get.dart';
import 'package:pfe_flutter/core/services/services.dart';

class HomeController extends GetxController {}


class HomeControllerImp extends HomeController {
  MyServices myServices = Get.find();

  String? username;
  String? email;
  String? role;

  initialData() {
    Map<String, dynamic>? payload = myServices.decodeToken();
    if (payload != null) {
      username = payload['username'];
       email = payload['email'];
       role = payload['role'];
      // ... autres attributs


      print('Username: $username');
      print('email: $email');
      print('role: $role');
      // ... autres informations
    } else {
      // Le token n'est pas disponible ou ne peut pas être décodé
    }
  }

  @override
  void onInit() {
    initialData();
    super.onInit();
  }
}
