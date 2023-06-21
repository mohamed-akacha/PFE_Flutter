import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pfe_flutter/controller/calander_controller.dart';
import 'package:pfe_flutter/controller/homescreen_controller.dart';
import 'package:pfe_flutter/controller/inspectiondetails_controller.dart';
import 'package:pfe_flutter/core/class/statusrequest.dart';
import 'package:pfe_flutter/core/constant/routes.dart';
import 'package:pfe_flutter/core/functions/handingdatacontroller.dart';
import 'package:pfe_flutter/core/services/services.dart';
import 'package:pfe_flutter/data/datasource/remote/notification_data.dart';
import 'package:pfe_flutter/data/model/notification.dart';
import 'package:pfe_flutter/view/screen/calanderpage.dart';

class NotificationController extends GetxController {
  NotificationData notificationData = NotificationData(Get.find());
  List<NotificationModel> data = [];
  late int iduser;
  StatusRequest statusRequest = StatusRequest.none;

  MyServices myServices = Get.find();

  void getData() async {
    data.clear();
    statusRequest = StatusRequest.loading;
    update();
    Map<String, dynamic>? payload = myServices.decodeToken();
    if (payload != null) {
      iduser = payload['id'];

    print("+++++++++++++++++++++++++++++ id user : ${iduser} +++++++++++++++++++++++++++++");

      var response = await notificationData.getData(iduser);

      print("=============================== Controller ${response} ");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        // Start backend
        if (response.isRight()) {
          data = response.getOrElse(() => []);
        } else {
          statusRequest = StatusRequest.failure;
        }
        // End
      }
    }else {
      // Rediriger vers la page de connexion en cas de token invalide
      Get.offNamed(AppRoute.login);
    }
    update();
  }
  void onNotificationPressed(int id) {
    if (id > 0) {
      Get.put(InspectionDetailsController(id: id));
      Get.toNamed(AppRoute.InspectionDetailsPage, arguments: {
        "id": id,
      });
    } else {
      print("Invalid inspection ID: $id");
      // Gérer l'erreur ou afficher un message à l'utilisateur
    }
  }
  void markNotificationAsRead(int notificationId) async {
    var result = await notificationData.markNotificationAsRead(notificationId);

    result.fold(
          (failure) {
        // Gérer l'échec de la mise à jour
      },
          (notification) {
        // Mettre à jour la liste des notifications avec la notification marquée comme lue
        int index = data.indexWhere((element) => element.id == notification?.id);
        if (index != -1) {
          data[index] = notification!;
          update();
        }
      },
    );
  }



  @override
  void onInit() {
    getData();
    super.onInit();

  }
}
