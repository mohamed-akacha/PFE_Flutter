import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe_flutter/controller/evaluationbloc_controller.dart';
import 'package:pfe_flutter/core/class/handlingdataview.dart';
import 'package:pfe_flutter/core/constant/color.dart';
import 'package:pfe_flutter/data/model/evaluationpoint.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class EvaluationBlocPage extends StatelessWidget {
  final int blockId;
  final String blockName;
  final int inspectionId;
  final List<EvaluationPoint>? criteria;

  const EvaluationBlocPage({
    Key? key,
    required this.blockId,
    required this.blockName,
    required this.inspectionId,
    this.criteria,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EvaluationBlocController controller = Get.put(
        EvaluationBlocController(
            blockId: blockId, inspectionId: inspectionId, criteria: criteria));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
        elevation: 0.0,
        title: Text(blockName,
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: AppColor.white)),
      ),
      body: GetBuilder<EvaluationBlocController>(
        builder: (controller) {
          return HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: ListView.builder(
              itemCount: controller.criteria?.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.criteria![index].description,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 10),
                        RatingBar.builder(
                          initialRating:
                          controller.evaluations[index].score.toDouble(),
                          minRating: 0,
                          maxRating: 5,
                          itemSize: 50,
                          glow: true,
                          glowColor: AppColor.primaryColor,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.orange,
                          ),
                          onRatingUpdate: (rating) =>
                              controller.updateScore(index, rating),
                        ),
                        SizedBox(height: 5),
                        GetBuilder<EvaluationBlocController>(
                          builder: (controller) {
                            return Text(
                              ' Score :    ${controller.evaluations[index].score}/10',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () => controller.selectFile(index),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: AppColor.secoundColor,
                            textStyle: TextStyle(fontSize: 16),
                            padding: EdgeInsets.all(5),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.file_upload),
                              SizedBox(width: 8),
                              Text("Select File"),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        GetBuilder<EvaluationBlocController>(
                          builder: (controller) {
                            final fileName =
                                controller.fileNames[index]?.split('/').last;
                            return Text(
                              fileName ?? "No File Selected",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: Container(
        width: 80,
        height: 80,
        child: FloatingActionButton(
          backgroundColor: Colors.green,
          child: const Icon(Icons.navigation, size: 40),
          onPressed: () async {
            bool? isConfirmed = await _showConfirmationDialog(context);
            if (isConfirmed != null && isConfirmed) {
              await controller.uploadFiles();
              controller.saveEvaluation();
            }
          },
        ),
      ),

    );
  }

  Future<bool?> _showConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Voulez-vous confirmer?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text(
                'Non',
                style: TextStyle(
                  color: AppColor.secoundColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text(
                'Oui',
                style: TextStyle(
                  color: AppColor.secoundColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
