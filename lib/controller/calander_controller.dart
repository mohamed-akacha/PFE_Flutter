import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe_flutter/controller/inspectiondetails_controller.dart';
import 'package:pfe_flutter/core/class/statusrequest.dart';
import 'package:pfe_flutter/core/constant/routes.dart';
import 'package:pfe_flutter/data/datasource/remote/calanderdata.dart';
import 'package:pfe_flutter/data/model/inspection.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalanderController extends GetxController {
  CalendarData calendarData = CalendarData(Get.find());
  List<Inspection> inspections = [];
  //DateTime selectDate = DateTime.now();

  MeetingDataSource dataSource = MeetingDataSource([]);
  List<Appointment> selectedAppointments = [];

  StatusRequest statusRequest = StatusRequest.none;

  @override
  void onInit() {
    super.onInit();
    fetchInspections();
  }

  void fetchInspections() async {
    statusRequest = StatusRequest.loading;
    update();

    final response = await calendarData.getInspections();

    response.fold((status) {   // Handling StatusRequest
      statusRequest = status;
      if (status == StatusRequest.invalidToken) {
        // Si le token est invalide, rediriger vers la page de connexion
        Get.offNamed(AppRoute.login);
      } else {
        update();
      }
      }, (inspectionList) {   // Handling List<Inspection>
      inspections = inspectionList;
      var appointments = inspections.map((inspection) {
        return Appointment(
            startTime: inspection.datePrevue,
            endTime:  inspection.datePrevue.add(Duration(hours: 1)),
            subject: inspection.unit!.institution!.nom,
            color: inspection.statut ? Colors.green : Colors.red,
            startTimeZone: '',
            endTimeZone: '',
            notes: inspection.type,
            id: inspection.id
        );
      }).toList();
      dataSource = MeetingDataSource(appointments);
      statusRequest = StatusRequest.success;
      update();
    });
  }



  void selectionChanged(CalendarSelectionDetails details) {
    getSelectedDateAppointments(details.date);
  }

  void getSelectedDateAppointments(DateTime? selectedDate) {
    if (dataSource.appointments!.isEmpty) {
      return;
    }

    selectedAppointments = dataSource.appointments!.where((appointment) {
      final DateTime startOfDay = DateTime(selectedDate!.year, selectedDate.month, selectedDate.day);
      final DateTime endOfDay = startOfDay.add(Duration(days: 1)).subtract(Duration(seconds: 1));
      return (appointment.startTime.isAtSameMomentAs(startOfDay) || appointment.startTime.isAfter(startOfDay)) && appointment.startTime.isBefore(endOfDay) ||
          (appointment.endTime.isAfter(startOfDay) && (appointment.endTime.isAtSameMomentAs(endOfDay) || appointment.endTime.isBefore(endOfDay)));
    }).toList() as List<Appointment>;

    update();
  }


  IconData getIcon(bool isCompleted) {
    return isCompleted ? Icons.check_circle : Icons.pending;
  }
  goToInspectionDetailsPage(int index) {
    int id = selectedAppointments[index].id as int;
    Get.put(InspectionDetailsController(id: id));
    Get.toNamed(
      AppRoute.InspectionDetailsPage,
      arguments: {
        "id" : id,
      },
    );
  }


}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
