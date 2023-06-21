import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe_flutter/controller/calander_controller.dart';
import 'package:pfe_flutter/controller/notification_controller.dart';
import 'package:pfe_flutter/view/screen/calanderpage.dart';
import 'package:pfe_flutter/view/screen/homepage.dart';
import 'package:pfe_flutter/view/screen/notification.dart';
import 'package:pfe_flutter/view/screen/settings.dart';

abstract class HomeScreenController extends GetxController {
  changePage(int currentpage);
}

class HomeScreenControllerImp extends HomeScreenController {
  int currentpage = 0;

  List<Widget> listPage = [
    /* const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Center(child: Text("home"))],
    ),*/
    CalanderPage(),
    NotificationView(),

    Settings()
  ];

  List bottomappbar = [
  //  {"title": "home", "icon": Icons.home},
    {"title": "calander", "icon": Icons.calendar_today},
    {"title": "notification", "icon": Icons.notifications_active_outlined},
    {"title": "settings", "icon": Icons.settings}
  ];

  @override
  changePage(int i) {
    currentpage = i;
   /*if (i == 2) { // Si la page de notification est sélectionnée
      NotificationController notificationController = Get.find<NotificationController>();
      notificationController.getData();
    }
    if (i == 1) { // Si la page du calendrier est sélectionnée
      CalanderController calanderController = Get.find<CalanderController>();
      calanderController.fetchInspections();
    }*/
    update();
  }
}
