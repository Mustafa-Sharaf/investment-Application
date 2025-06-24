import 'package:flutter/material.dart';
import '../ViewOperations/ProcessModel.dart';
import '../app_theme/app_theme.dart';
import 'LogController.dart';


Widget buildLogView(List<ProcessModel> data, LogController controller) {
  if (data.isEmpty) {
    return const Center(
      child: Text(
        "لا توجد عمليات",
        style: TextStyle(fontSize: 18, color: Colors.grey),
      ),
    );
  }

  return Column(
    children: [
      Expanded(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          itemCount: data.length,
          separatorBuilder: (_, __) => const Divider(height: 1, color: Colors.grey),
          itemBuilder: (_, index) {
            final item = data[index];
            final isIncome = item.category == "دخل";
            final iconColor = isIncome ? Colors.green : Colors.red;

            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: CircleAvatar(
                  backgroundColor: iconColor.withOpacity(0.2),
                  child: Icon(
                    isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                    color: iconColor,
                  ),
                ),
                title: Text(
                  "${item.category}",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                subtitle: Row(
                  children: [
                    Icon(Icons.calendar_today, size: 14, color: Colors.grey[600]),
                    const SizedBox(width: 6),
                    Text(
                      "${item.date.year}-${item.date.month.toString().padLeft(2, '0')}-${item.date.day.toString().padLeft(2, '0')}",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${item.amount.toStringAsFixed(2)} ${item.currency ?? ''}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: iconColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: const Offset(0, 3),
              blurRadius: 6,
            )
          ],
        ),
        child: Text(
          "الإجمالي: ${controller.sumAmount(data).toStringAsFixed(2)}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    ],
  );
}
