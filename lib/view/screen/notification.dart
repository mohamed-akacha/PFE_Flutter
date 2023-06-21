import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pfe_flutter/controller/notification_controller.dart';
import 'package:pfe_flutter/core/class/handlingdataview.dart';
import 'package:pfe_flutter/core/constant/color.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NotificationController());
    return GetBuilder<NotificationController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: AppColor.primaryColor,
            elevation: 0.0,
            title: Text('Notifications',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(color: AppColor.white)),
          ),
          body: HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: Container(
              padding: EdgeInsets.all(10),
              child: ListView(
                children: [
                  /* Center(
                    child: Text(
                      'Notifications',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),*/
                  ...controller.data.map(
                    (notification) => GestureDetector(
                      onTap: () {
                        controller.markNotificationAsRead(notification.id);
                        controller.onNotificationPressed(notification.inspectionId);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        color: notification.read
                            ? Colors.white
                            : Colors.grey[200], // Add this line
                        child: Stack(
                          children: [
                            ListTile(
                              title: Text(notification.title),
                              subtitle: Text( 'on' + notification.body),
                            ),
                            Positioned(
                              right: 5,
                              child: Text(
                                Jiffy.parse(notification.createdAt.toString())
                                    .fromNow(),
                                style: TextStyle(
                                  color: AppColor.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
