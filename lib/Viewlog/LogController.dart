import 'package:get/get.dart';
import '../ViewOperations/ProcessController.dart';
import '../ViewOperations/ProcessModel.dart';


class LogController extends GetxController {
  final ProcessController processController = Get.find<ProcessController>();

  var fromDate = Rxn<DateTime>();
  var toDate = Rxn<DateTime>();

  List<ProcessModel> get allOperations => processController.operations;

  List<ProcessModel> get incomeRecords => _filterByType("دخل");
  List<ProcessModel> get expenseRecords => _filterByType("نفقة");

  List<ProcessModel> _filterByType(String type) {
    return allOperations.where((op) {
      final inRange = fromDate.value != null && toDate.value != null
          ? (op.date.isAfter(fromDate.value!.subtract(const Duration(days: 1))) &&
          op.date.isBefore(toDate.value!.add(const Duration(days: 1))))
          : true;
      return op.category == type && inRange;
    }).toList();
  }

  double sumAmount(List<ProcessModel> list) {
    final sum = list.fold(0.0, (prev, op) => prev + op.amount);
    return sum.isFinite ? sum : 0.0;
  }
}

