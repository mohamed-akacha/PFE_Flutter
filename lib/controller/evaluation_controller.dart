import 'package:get/get.dart';
import 'package:pfe_flutter/core/class/statusrequest.dart';
import 'package:pfe_flutter/core/constant/routes.dart';
import 'package:pfe_flutter/data/datasource/remote/evaluationdata.dart';
import 'package:pfe_flutter/data/model/evaluationdatamodel.dart';
import 'package:pfe_flutter/data/model/evaluationpoint.dart';
import 'package:pfe_flutter/view/screen/evaluationblocpage.dart';

class EvaluationController extends GetxController {
  late final int id;
  String? unit;
  late final EvaluationData evaluationData;
  EvaluationDataModel? evaluation;
  StatusRequest statusRequest = StatusRequest.none;
  bool isLoading = false;

  EvaluationController({required this.id, this.unit});

  @override
  void onInit() {
    super.onInit();
    evaluationData = EvaluationData(Get.find());
    fetchEvaluationData();
  }

  void fetchEvaluationData() async {
    isLoading = true;
    statusRequest = StatusRequest.loading;
    update(); // Notify listeners to rebuild widgets
    final evaluationDataResult = await evaluationData.getEvaluationData(id);
    // print("=============================== response : $evaluationDataResult ");
    isLoading = false;

    evaluationDataResult.fold(
          (failure) {
        statusRequest = failure;
        evaluation = null;
        if (statusRequest == StatusRequest.invalidToken) {
          Get.offNamed(AppRoute.login);
        } else {
          update();
        }
      },
          (evaluation) {
        this.evaluation = evaluation;
        statusRequest = StatusRequest.success;
      },
    );
    update(); // Notify listeners to rebuild widgets
  }
  void goToEvaluationBloc(int idBloc, String nomBloc , int idInspection ,List<EvaluationPoint>? criteria) {
    // Get the list of criteria for the selected block
    //List<EvaluationPoint>? criteria = evaluation!.criteria;

    // Pass the block id, block name, and the criteria to the EvaluationBlocPage using GetX navigation
    Get.to(() => EvaluationBlocPage(
      blockId: id,
      blockName: nomBloc,
      inspectionId : idInspection ,
      criteria: criteria,
    ));
  }


}



