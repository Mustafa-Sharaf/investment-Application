import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../SelectMoney/CurrencyController.dart';
import '../app_theme/app_theme.dart';
import 'ProcessController.dart';
import 'ProcessModel.dart';

class EditProcessScreen extends StatelessWidget {
  final int index;
  final ProcessModel process;

  EditProcessScreen({required this.index, required this.process});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final RxnString selectedCategory = RxnString();
  final Rxn<DateTime> selectedDate = Rxn<DateTime>();
  final categories = ['دخل', 'نفقة', 'استثمار', 'ادخار'];

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProcessController>();
    final currencyController = Get.find<CurrencyController>();
    _amountController.text = process.amount.toString();
    selectedCategory.value = process.category;
    selectedDate.value = process.date;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Modify the process",
          style: TextStyle(color: Colors.white),
        ),
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
                controller: _amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'The amount'),
                validator: (val) {
                  final n = double.tryParse(val ?? '');
                  if (n == null || n <= 0) return "يرجى إدخال مبلغ صحيح";
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Obx(() => DropdownButtonFormField<String>(
                value: selectedCategory.value,
                items: categories
                    .map((e) =>
                    DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => selectedCategory.value = val,
                decoration: const InputDecoration(labelText: 'Category'),
                validator: (val) =>
                val == null ? "يرجى اختيار الفئة" : null,
              )),
              const SizedBox(height: 16),

              Obx(() => TextFormField(
                readOnly: true,
                decoration: const InputDecoration(labelText: 'The date'),
                controller: TextEditingController(
                    text: selectedDate.value == null
                        ? ''
                        : "${selectedDate.value!.year}-${selectedDate.value!.month}-${selectedDate.value!.day}"),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate.value ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    selectedDate.value = picked;
                  }
                },
                validator: (val) =>
                selectedDate.value == null ? "اختر التاريخ" : null,
              )),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final updatedProcess = ProcessModel(
                      id: controller.operations[index].id,
                      category: selectedCategory.value!,
                      amount: double.parse(_amountController.text),
                      date: selectedDate.value!,
                      currency: currencyController.selectedCurrency.value,  // إضافة العملة هنا
                    );

                    controller.updateOperation(index, updatedProcess);
                    Get.back();
                    Get.snackbar(
                        "تم التحديث",
                        "تم تعديل العملية بنجاح",
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                    );
                  }
                },
                child: const Text("Update",style: TextStyle(color: Colors.white),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
