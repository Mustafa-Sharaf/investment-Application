import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:investment_app/app_theme/app_theme.dart';
import '../AddProcess/AddProcess_Screen.dart';
import '../SelectMoney/SelectMoney_Screen.dart';
import '../ViewOperations/ViewOperations_Screen.dart';
import '../Viewlog/Viewlog_Screen.dart';
import '../widgets/BottomTabItem.dart';
import 'HomeContent.dart';
import 'Home_Controller.dart';

class HomeScreen extends StatelessWidget {
  final BottomNavController controller = Get.put(BottomNavController());
   HomeScreen({super.key});
  final List<Widget> pages = [
    HomeContent(),
    ViewOperations(),
    SelectMoney(),
    AddProcess(),
    ViewLog(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "Home Screen",
          style: TextStyle(
              color: Colors.white,
          ),
        ),
      ),

      body: Obx(() => IndexedStack(
        index: controller.currentIndex.value,
        children: pages,
      )),

      floatingActionButton: Transform.translate(
        offset: const Offset(0, 10),
        child: SizedBox(
          height: MediaQuery.of(context).size.width * 0.14,
          width: MediaQuery.of(context).size.width * 0.14,
          child: FloatingActionButton(
            backgroundColor: AppColors.primaryColor,
            elevation: 8,
            shape: const CircleBorder(),
            onPressed: () => Get.to(() => const SelectMoney()),
            child: const Icon(Icons.attach_money, size: 35,color: Colors.grey,),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: SizedBox(
        height:MediaQuery.of(context).size.height * 0.074,
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 6.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(child: BottomTabItem(index: 0, icon: Icons.home, label: 'Home')),
              SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
              Expanded(child: BottomTabItem(index: 1, icon: Icons.view_day, label: 'View')),
              SizedBox(width: MediaQuery.of(context).size.width * 0.20,),
              Expanded(child: BottomTabItem(index: 3, icon: Icons.add_circle, label: 'Add Process')),
              SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
              Expanded(child: BottomTabItem(index: 4, icon: Icons.view_headline, label: 'View log')),
            ],
          ),
        ),
      ),


    );
  }
}
