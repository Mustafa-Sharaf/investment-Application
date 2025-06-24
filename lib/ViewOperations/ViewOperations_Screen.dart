import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_theme/app_theme.dart';
import 'EditProcessScreen.dart';
import 'ProcessController.dart';

class ViewOperations extends StatelessWidget {
  const ViewOperations({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProcessController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "View Operations",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        if (controller.operations.isEmpty) {
          return const Center(child: Text("لا توجد عمليات مسجلة."));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.operations.length,
          itemBuilder: (context, index) {
            final operation = controller.operations[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              child: Dismissible(
                key: Key(operation.id),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  controller.deleteOperation(index);
                  Get.snackbar(
                      "تم الحذف",
                      "تم حذف العملية بنجاح",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                },
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  child: ListTile(
                    title: Text(
                      "Category: ${operation.category}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "value: ${operation.amount}\n"
                      "The date: ${operation.date.year}-${operation.date.month}-${operation.date.day}\n"
                      "Type: ${operation.currency}"
                    ),
                    leading: const Icon(
                      Icons.monetization_on,
                      color: AppColors.primaryColor,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.orange),
                      onPressed: () {
                        Get.to(
                          () => EditProcessScreen(
                            index: index,
                            process: operation,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
