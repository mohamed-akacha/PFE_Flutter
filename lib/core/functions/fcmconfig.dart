import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:pfe_flutter/controller/calander_controller.dart';
import 'package:pfe_flutter/controller/notification_controller.dart';

requestPermissionNotification() async {
  NotificationSettings settings =
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
}

fcmconfig() {
  print("hai =======================================================");
  FirebaseMessaging.onMessage.listen((message) {
    print("================== Notification =================");
    print(message.notification!.title);
    print(message.notification!.body);
    FlutterRingtonePlayer.playNotification();
    Get.snackbar(message.notification!.title!, message.notification!.body!);
    refreshPageNotification();
  });
}

refreshPageNotification() {
  if (Get.isRegistered<NotificationController>()) {
    NotificationController notificationController = Get.find<NotificationController>();
    notificationController.getData();
  }

  if (Get.isRegistered<CalanderController>()) {
    CalanderController calanderController = Get.find<CalanderController>();
    calanderController.fetchInspections();
  }
}


// Firebase + stream
// Socket io
// Notification refresh