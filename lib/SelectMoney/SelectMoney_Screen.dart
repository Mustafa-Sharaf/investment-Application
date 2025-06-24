import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:investment_app/app_theme/app_theme.dart';
import 'CurrencyController.dart';


class SelectMoney extends StatelessWidget {
  const SelectMoney({super.key});

  @override
  Widget build(BuildContext context) {
    final CurrencyController controller = Get.put(CurrencyController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          title: const Text(
              "Select Currency",
            style: TextStyle(color: Colors.white),
          )),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Obx(() =>
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: "Select Currency",
              labelStyle: TextStyle(
                color: Colors.green,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              prefixIcon: const Icon(Icons.attach_money),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.green),
              ),
            ),
            value: controller.selectedCurrency.value,
            items: controller.currencies.map((currency) {
              final code = currency['code']!;
              final flag = currency['flag']!;
              return DropdownMenuItem<String>(
                value: code,
                child: Row(
                  children: [
                    Text(code),
                    SizedBox(width: 200,),
                    Image.asset(
                      flag,
                      width: 24,
                      height: 24,
                      errorBuilder: (context, error, stackTrace) => Icon(Icons.flag),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                controller.changeCurrency(value);
              }
            },
          )

          ),
        ),
      ),
    );
  }
}
