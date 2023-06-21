import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe_flutter/controller/homescreen_controller.dart';
import 'package:pfe_flutter/view/widget/custombuttonappbar.dart';

class CustomBottomAppBarHome extends StatelessWidget {
  const CustomBottomAppBarHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenControllerImp>(
      builder: (controller) => BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: CustomButtonAppBar(
                textbutton: controller.bottomappbar[0]['title'],
                icondata: controller.bottomappbar[0]['icon'],
                onPressed: () {
                  controller.changePage(0);
                },
                active: controller.currentpage == 0 ? true : false,
              ),
            ),
            Expanded(
              child: CustomButtonAppBar(
                textbutton: controller.bottomappbar[1]['title'],
                icondata: controller.bottomappbar[1]['icon'],
                onPressed: () {
                  controller.changePage(1);
                },
                active: controller.currentpage == 1 ? true : false,
              ),
            ),
            Expanded(
              child: CustomButtonAppBar(
                textbutton: controller.bottomappbar[2]['title'],
                icondata: controller.bottomappbar[2]['icon'],
                onPressed: () {
                  controller.changePage(2);
                },
                active: controller.currentpage == 2 ? true : false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
