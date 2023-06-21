import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pfe_flutter/controller/evaluation_controller.dart';
import 'package:pfe_flutter/core/class/statusrequest.dart';
import 'package:pfe_flutter/core/constant/routes.dart';
import 'package:pfe_flutter/data/datasource/remote/inspectiondetailsdata.dart';
import 'package:pfe_flutter/data/model/inspection.dart';

class InspectionDetailsController extends GetxController {
  late final int id;
  late final InspectionDetailsData inspectionDetailsData;
  Inspection? inspectionDetails;
  StatusRequest statusRequest = StatusRequest.none;
  bool isLoading = false;

  InspectionDetailsController({required this.id});

  @override
  void onInit() {
    super.onInit();
    inspectionDetailsData = InspectionDetailsData(Get.find());
    fetchInspectionDetails();
  }

  void fetchInspectionDetails() async {
    isLoading = true;
    statusRequest = StatusRequest.loading;
    update(); // Notify listeners to rebuild widgets
    final inspectionDetailsResult =  await inspectionDetailsData.getInspectionDetails(id);
    print(inspectionDetailsResult);
    isLoading = false;

    inspectionDetailsResult.fold(
      (failure) {
        statusRequest = failure;
        inspectionDetails = null;
        if (statusRequest == StatusRequest.invalidToken) {
          // Si le token est invalide, rediriger vers la page de connexion
          Get.offNamed(AppRoute.login);
        } else {
          update();
        }
      },
      (inspection) {
        inspectionDetails = inspection;
        statusRequest = StatusRequest.success;
        /*if (inspection?.statut == true && inspection?.dateInspection != null) {
          Get.snackbar("",
              "Cette inspection est terminée en: ${DateFormat('dd/MM/yyyy').format(inspection!.dateInspection!)}",
              snackPosition: SnackPosition.BOTTOM,
              animationDuration: Duration(seconds: 30));
        }*/
      },
    );
    update(); // Notify listeners to rebuild widgets
  }

  void goToEvaluationPage() {
    //if (inspectionDetails?.statut == false && inspectionDetails?.dateInspection == null) {
    Get.put(EvaluationController(id: id, unit: inspectionDetails!.unit!.nom));
    Get.toNamed(
      AppRoute.EvaluationPage,
      arguments: {"id": id, "unit": inspectionDetails!.unit!.nom},
    );
    /*   } else {
      Get.snackbar(
          "Attention",
          inspectionDetails?.dateInspection != null
              ? "Cette inspection est terminée en: ${DateFormat('dd/MM/yyyy').format(inspectionDetails!.dateInspection!)}"
              : "Cette inspection est terminée."
      );
    }*/
  }



}
