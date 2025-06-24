import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:investment_app/app_theme/app_theme.dart';
import '../SelectMoney/CurrencyController.dart';
import '../ViewOperations/ProcessController.dart';
import '../ViewOperations/ProcessModel.dart';
import 'AddProcess_Controller.dart';

class AddProcess extends StatelessWidget {
  AddProcess({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final AddProcessController controller = Get.put(AddProcessController());
  final processController = Get.find<ProcessController>();
  final currencyController = Get.find<CurrencyController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            "Add Process",
             style: TextStyle(
              color: Colors.white,)),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'The amount',
                  labelStyle: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.attach_money),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.primaryColor),
                  ),
                ),
                onChanged: (val) => controller.amount.value = val,
                validator: controller.validateAmount,
              ),
              const SizedBox(height: 20),

              Obx(() => DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Select category',
                  labelStyle: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.category),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: AppColors.primaryColor),
                  ),
                ),
                value: controller.selectedCategory.value,
                items: controller.categories
                    .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                    .toList(),
                onChanged: (val) => controller.selectedCategory.value = val,
                validator: controller.validateCategory,
              )),

              const SizedBox(height: 20),
              Obx(() => TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Select Date',
                  labelStyle: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  prefixIcon: const Icon(Icons.calendar_today),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.primaryColor),
                  ),
                ),
                controller: TextEditingController(
                  text: controller.selectedDate.value == null
                      ? ''
                      : '${controller.selectedDate.value!.year}-${controller.selectedDate.value!.month.toString().padLeft(2, '0')}-${controller.selectedDate.value!.day.toString().padLeft(2, '0')}',
                ),
                validator: (val) => controller.validateDate(controller.selectedDate.value),
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: controller.selectedDate.value ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    controller.selectedDate.value = picked;
                  }
                },
              )),

              const SizedBox(height: 30),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final amount = double.parse(controller.amount.value);
                      final category = controller.selectedCategory.value!;
                      final date = controller.selectedDate.value!;

                      final user = FirebaseAuth.instance.currentUser;
                      if (user == null) {
                        Get.snackbar('خطأ', 'لم يتم تسجيل الدخول');
                        return;
                      }
                      try {
                        final docRef = await FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.uid)
                            .collection('operations')
                            .add({
                          'category': category,
                          'amount': amount,
                          'date': date.toIso8601String(),
                          'createdAt': FieldValue.serverTimestamp(),
                        });

                        final process = ProcessModel(
                          id: docRef.id,
                          category: category,
                          amount: amount,
                          date: date,
                          currency: currencyController.selectedCurrency.value,
                        );

                        processController.operations.add(process);


                        Get.snackbar(
                          'نجاح',
                          'تمت إضافة العملية بنجاح',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                        );

                        controller.amount.value = '';
                        controller.selectedCategory.value = null;
                        controller.selectedDate.value = null;
                        _formKey.currentState!.reset();

                      } catch (e) {
                        Get.snackbar(
                          'خطأ',
                          'حدث خطأ أثناء إضافة العملية: $e',
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      }

                    }
                  },

                  child: const Text('Add Process', style: TextStyle(fontSize: 18,color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
