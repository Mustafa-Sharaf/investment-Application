
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

Widget buildDateselector(BuildContext context, String label, Rxn<DateTime> dateObs) {
  return Expanded(
    child: Obx(() => InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: dateObs.value ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (picked != null) dateObs.value = picked;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          dateObs.value == null
              ? "$label date"
              : "${dateObs.value!.year}-${dateObs.value!.month.toString().padLeft(2, '0')}-${dateObs.value!.day.toString().padLeft(2, '0')}",
        ),
      ),
    )),
  );
}