import 'package:get/get.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;

  final List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/image3.jpeg',
      'text': "💰 Take control of your money, step by step!\nEasily track your income and expenses, and plan your financial future intelligently.",
    },
    {
      'image': 'assets/financialanalysis.webp',
      'text': "📊 Financial Analysis... Designed for You!\nGet clear insights to help you make better financial decisions.",
    },
    {
      'image': 'assets/img.png',
      'text': "Don't let your money go unnoticed\nTrack, analyze, and stay on top of your spending.",
    },
  ];

  void nextPage() {
    if (currentPage.value < onboardingData.length - 1) {
      currentPage.value++;
    } else {
      Get.offAllNamed('/loginScreen');
    }
  }
}
