import 'package:get/get.dart';
import 'package:pfe_flutter/core/class/statusrequest.dart';
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
    inspectionDetailsData = Get.put(InspectionDetailsData());
    fetchInspectionDetails();
  }

  void fetchInspectionDetails() async {
    isLoading = true;
    update(); // Notify listeners to rebuild widgets
    final inspectionDetailsResult = await inspectionDetailsData.getInspectionDetails(id);
    isLoading = false;

    inspectionDetailsResult.fold(
          (failure) {
        statusRequest = failure;
      },
          (inspection) {
        inspectionDetails = inspection;
        statusRequest = StatusRequest.success;
      },
    );
    update(); // Notify listeners to rebuild widgets
  }
}


