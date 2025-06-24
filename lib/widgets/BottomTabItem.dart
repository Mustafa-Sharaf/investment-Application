import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../AddProcess/AddProcess_Screen.dart';
import '../Home_Screen/Home_Controller.dart';
import '../SelectMoney/SelectMoney_Screen.dart';
import '../ViewOperations/ViewOperations_Screen.dart';
import '../Viewlog/Viewlog_Screen.dart';
import '../app_theme/app_theme.dart';



class BottomTabItem extends StatelessWidget {
  final int index;
  final IconData icon;
  final String label;
  final BottomNavController controller = Get.find();

  BottomTabItem({
    super.key,
    required this.index,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = controller.currentIndex.value == index;
      return GestureDetector(
        onTap: (){
          if (index == 1) {
            Get.to(() => const ViewOperations());
          } else if (index == 3) {
            Get.to(() =>  AddProcess());
          } else if (index == 4) {
            Get.to(() => const ViewLog());
          } else if (index == 2) {
            Get.to(() => const SelectMoney());}
          else {
            controller.changeTabIndex(index);
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primaryColor : Colors.grey,
              size:MediaQuery.of(context).size.width * 0.06,),
            Text(label,
              style: TextStyle(
                fontSize: 10,
                color: isSelected ? AppColors.primaryColor : Colors.grey,
              ),
            ),
          ],
        ),
      );
    });
  }
}