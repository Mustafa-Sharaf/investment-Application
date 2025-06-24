import 'package:get/get.dart';

class AddProcessController extends GetxController {
  var amount = ''.obs;
  var selectedCategory = RxnString();
  var selectedDate = Rxn<DateTime>();
  final categories = ['دخل', 'نفقة', 'استثمار', 'ادخار'];


  String? validateAmount(String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'يرجى إدخال المبلغ';
    }
    final n = double.tryParse(val);
    if (n == null || n <= 0) {
      return 'يرجى إدخال مبلغ صحيح أكبر من صفر';
    }
    return null;
  }

  // تحقق من اختيار الفئة
  String? validateCategory(String? val) {
    if (val == null || val.isEmpty) {
      return 'يرجى اختيار الفئة';
    }
    return null;
  }



  String? validateDate(DateTime? val) {
    if (val == null) return 'يرجى اختيار التاريخ';
    return null;
  }



}
