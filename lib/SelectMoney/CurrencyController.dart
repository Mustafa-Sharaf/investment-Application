import 'package:get/get.dart';

class CurrencyController extends GetxController {
  final currencies = [
    {"code": "USD", "flag": "assets/america.png"},
    {"code": "EGP", "flag": "assets/egypt.png"},
    {"code": "EUR", "flag": "assets/euro.png"},
    {"code": "SAR", "flag": "assets/saudiArabia.png"},
    {"code": "SYP", "flag": "assets/syria.png"},
    {"code": "TRY", "flag": "assets/turkish.png"},
  ];


  var selectedCurrency = 'USD'.obs;

  void changeCurrency(String value) {
    selectedCurrency.value = value;
  }
}
