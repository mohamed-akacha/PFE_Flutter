import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe_flutter/controller/evaluation_controller.dart';
import 'package:pfe_flutter/core/class/handlingdataview.dart';
import 'package:pfe_flutter/core/constant/color.dart';
import 'package:pfe_flutter/view/widget/customcard.dart';

class EvaluationPage extends StatelessWidget {
  const EvaluationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EvaluationController controller = Get.find();

    return WillPopScope(
      onWillPop: () async {
        Get.delete<EvaluationController>();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColor.primaryColor,
          elevation: 0.0,
          title: Text(
            controller.unit ?? "",
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: AppColor.white),
          ),
        ),
        body: GetBuilder<EvaluationController>(
          builder: (controller) {
            return HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: ListView.builder(
                itemCount: controller.evaluation?.blocks?.length ?? 0,
                itemBuilder: (context, index) {
                  final block = controller.evaluation!.blocks![index];
                  final subtitle = "Floor: ${block.etage} "; /*Code: ${block.code}" ; */

                  return CustomCard(
                    title: "${block.nom} ( ${block.code} ) " ,
                    subtitle: subtitle,
                    iconData: Icons.description,
                    color: AppColor.secoundColor,
                    onTap:  controller.evaluatedBlocks.contains(block.id) ? null : () {

                      controller.goToEvaluationBloc(
                        block.id,
                        block.nom,
                        controller.evaluation!.inspection!.id,
                        controller.evaluation!.criteria,
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}





