import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pfe_flutter/controller/inspectiondetails_controller.dart';
import 'package:pfe_flutter/core/class/handlingdataview.dart';
import 'package:pfe_flutter/core/constant/color.dart';
import 'package:pfe_flutter/view/widget/auth/custombuttonauth.dart';

class InspectionDetailsPage extends StatelessWidget {
  const InspectionDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

    return WillPopScope(
      onWillPop: () async {
        Get.delete<InspectionDetailsController>();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColor.primaryColor,
          elevation: 0.0,
          title: Text('Inspection Details',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: AppColor.white)),
        ),
        body: GetBuilder<InspectionDetailsController>(
          builder: (controller) {
            return HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  Card(
                    color: AppColor.primaryColor,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDetailItem(
                            title: 'Description',
                            subtitle:
                                controller.inspectionDetails?.description ?? "",
                            iconData: Icons.description,
                          ),
                          _buildDetailItem(
                            title: 'Date Prévue',
                            subtitle: controller
                                        .inspectionDetails?.datePrevue !=
                                    null
                                ? dateFormat.format(
                                    controller.inspectionDetails!.datePrevue)
                                : "Non disponible",
                            iconData: Icons.date_range,
                          ),
                          _buildDetailItem(
                            title: 'Type',
                            subtitle: controller.inspectionDetails?.type ?? "",
                            iconData: Icons.category,
                          ),
                          _buildDetailItem(
                            title: 'Inspecteur',
                            subtitle:
                                controller.inspectionDetails?.user!.username ??
                                    "",
                            iconData: Icons.person,
                          ),
                          _buildDetailItem(
                            title: 'Institution',
                            subtitle: controller.inspectionDetails?.unit!
                                    .institution!.nom ??
                                "",
                            iconData: Icons.location_city,
                          ),
                          _buildDetailItem(
                            title: 'Adresse',
                            subtitle: controller.inspectionDetails?.unit!
                                    .institution!.adresse ??
                                "",
                            iconData: Icons.place,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (controller.inspectionDetails?.statut == true &&
                      controller.inspectionDetails?.dateInspection != null)
                    Card(
                      color: AppColor.grey,
                      child: ListTile(
                        title: Text(
                          'Cette inspection est terminée en: ${DateFormat('dd/MM/yyyy').format(controller.inspectionDetails!.dateInspection!)}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  if (controller.inspectionDetails?.statut == false &&
                      controller.inspectionDetails?.dateInspection ==null  && controller.inspectionDetails?.datePrevue != null && controller.inspectionDetails!.datePrevue.isBefore(DateTime.now())) // ici on vérifie si l'inspection n'est pas encore évaluée
                    CustomButtomAuth(
                      color: AppColor.thirdColor,
                      text: 'Start inspection ',
                      onPressed: () => controller.goToEvaluationPage(),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDetailItem({
    required String title,
    required String subtitle,
    required IconData iconData,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(iconData, color: Colors.white),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
