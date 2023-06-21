import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe_flutter/controller/settings_controller.dart';
import 'package:pfe_flutter/core/constant/color.dart';
import 'package:pfe_flutter/core/constant/imgaeasset.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingsController controller = Get.put(SettingsController());
    return Container(
      child: ListView(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(height: Get.width / 3, color: AppColor.primaryColor),
              Positioned(
                top: Get.width / 3.9,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[100],
                    backgroundImage: AssetImage(AppImageAsset.avatar),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 100),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    onTap: () {
                      controller.changeLanguage();
                    },
                    trailing: Icon(Icons.language),
                    title: Text("Change Language"),
                  ),
                  ListTile(
                    onTap: () {
                      controller.changePassword();
                    },
                    trailing: Icon(Icons.lock),
                    title: Text("Change Password"),
                  ),
                  ListTile(
                    onTap: () {
                      // TODO: Implement Contact Us functionality
                    },
                    trailing: Icon(Icons.phone_callback_outlined),
                    title: Text("Contact Admin"),
                  ),
                  ListTile(
                    onTap: () {
                      controller.logout();
                    },
                    title: Text("Logout"),
                    trailing: Icon(Icons.exit_to_app),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
