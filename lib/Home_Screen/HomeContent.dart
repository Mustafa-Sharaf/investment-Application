
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../Viewlog/LogController.dart';
import 'package:fl_chart/fl_chart.dart';

import '../Viewlog/buildDateSelector.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LogController>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const ImageSlider(),
            const SizedBox(height: 20),
            Row(
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

            const SizedBox(height: 30),

            Expanded(
              child: Obx(() {
                double incomeSum = controller.sumAmount(controller.incomeRecords);
                double expenseSum = controller.sumAmount(controller.expenseRecords);

                incomeSum = incomeSum.isFinite ? incomeSum : 0.0;
                expenseSum = expenseSum.isFinite ? expenseSum : 0.0;

                final maxVal = (incomeSum > expenseSum ? incomeSum : expenseSum);
                final maxY = (maxVal.isFinite && maxVal > 0) ? maxVal + 50 : 100.0;

                return Column(
                  children: [
                    const Text(
                      "مقارنة المدخلات بالنفقات",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 250,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: maxY,
                          barGroups: [
                            BarChartGroupData(x: 0, barRods: [
                              BarChartRodData(
                                toY: incomeSum,
                                color: Colors.green,
                                width: 30,
                                borderRadius: BorderRadius.circular(4),
                              )
                            ]),
                            BarChartGroupData(x: 1, barRods: [
                              BarChartRodData(
                                toY: expenseSum,
                                color: Colors.red,
                                width: 30,
                                borderRadius: BorderRadius.circular(4),
                              )
                            ]),
                          ],
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 40,
                                getTitlesWidget: (value, meta) {
                                  switch (value.toInt()) {
                                    case 0:
                                      return const Text("الدخل");
                                    case 1:
                                      return const Text("النفقات");
                                    default:
                                      return const Text("");
                                  }
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }



}
class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final PageController controller = PageController();
  final List<String> images = [
    'assets/image3.jpeg',
    'assets/image4.jpeg',
    'assets/images.jpeg',
  ];

  int currentPage = 0;
  Timer? autoScrollTimer;

  @override
  void initState() {
    super.initState();
    autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (controller.hasClients) {
        currentPage = (currentPage + 1) % images.length;
        controller.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    autoScrollTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: controller,
            itemCount: images.length,
            onPageChanged: (index) => currentPage = index,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  images[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        SmoothPageIndicator(
          controller: controller,
          count: images.length,
          effect: const WormEffect(
            dotHeight: 10,
            dotWidth: 10,
            activeDotColor: Colors.green,
          ),
        ),
      ],
    );
  }
}