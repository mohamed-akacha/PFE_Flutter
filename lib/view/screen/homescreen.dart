import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe_flutter/controller/homescreen_controller.dart';
import 'package:pfe_flutter/view/widget/custombottomappbarhome.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeScreenControllerImp());
    return GetBuilder<HomeScreenControllerImp>(
      builder: (controller) => Scaffold(
        bottomNavigationBar: const CustomBottomAppBarHome(),
        body: controller.listPage.elementAt(controller.currentpage),
      ),
    );
  }
}
