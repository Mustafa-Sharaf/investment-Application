import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_theme/app_theme.dart';
import 'LogController.dart';
import 'buildDateSelector.dart';
import 'buildLogView.dart';

class ViewLog extends StatelessWidget {
  const ViewLog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LogController>();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          title: const Text("View Log"),
        ),
        body: Column(
          children: [
            Container(
              color: Colors.white,
              child: const TabBar(
                labelColor: AppColors.primaryColor,
                unselectedLabelColor: Colors.grey,
                indicatorColor: AppColors.primaryColor,
                tabs: [
                  Tab(text: "View Income History"),
                  Tab(text: "View Expense History"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  buildDateselector(context, "From", controller.fromDate),
                  const SizedBox(width: 10),
                  buildDateselector(context, "To", controller.toDate),
                  IconButton(
                    icon: const Icon(Icons.clear),
                    tooltip: 'Clear Dates',
                    onPressed: () {
                      controller.fromDate.value = null;
                      controller.toDate.value = null;
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Obx(() =>
                      buildLogView(controller.incomeRecords, controller)),
                  Obx(() =>
                      buildLogView(controller.expenseRecords, controller)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}