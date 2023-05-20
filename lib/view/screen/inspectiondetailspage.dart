import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pfe_flutter/controller/inspectiondetails_controller.dart';
import 'package:pfe_flutter/core/class/handlingdataview.dart';
import 'package:pfe_flutter/core/constant/color.dart';

class InspectionDetailsPage extends StatelessWidget {
  const InspectionDetailsPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final InspectionDetailsController controller = Get.find();
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.backgroundcolor,
        elevation: 0.0,
        title: Text('Détails de l\'inspection',
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: AppColor.grey)),
      ),
      body: GetBuilder<InspectionDetailsController>(
        builder: (controller) {
          return HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: ListView(
              padding: EdgeInsets.all(16),
              children: [
                Card(
                  child: ListTile(
                    title: Text('Description'),
                    subtitle: Text(controller.inspectionDetails?.description ?? ""),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Date Prévue'),
                    subtitle: Text(controller.inspectionDetails?.datePrevue != null
                        ? dateFormat.format(controller.inspectionDetails!.datePrevue)
                        : "Non disponible"),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Type'),
                    subtitle: Text(controller.inspectionDetails?.type ?? ""),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Inspecteur'),
                    subtitle: Text(controller.inspectionDetails?.user.username ?? ""),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Institution'),
                    subtitle: Text(controller.inspectionDetails?.unit.institution.nom ?? ""),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text("Adresse "),                   subtitle: Text(controller.inspectionDetails?.unit.institution.adresse ?? ""),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text("Unité d'inspection "),
                    subtitle: Text(controller.inspectionDetails?.unit.nom ?? ""),
                  ),
                ),

              ],
            ),
          );
        },
      ),
    );
  }
}
