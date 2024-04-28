import 'package:shoppe_customer/data/models/service_model.dart';
import 'package:shoppe_customer/util/color.dart';
import 'package:shoppe_customer/controller/myController/carSpaController.dart';
import 'package:shoppe_customer/controller/myController/serviceCheckoutController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:get/get.dart';

class CarSpaTimeSlotController extends GetxController implements GetxService {
  var dateShow = DateTime.now().toString().substring(0, 10).obs;
  var serviceId = "".obs;
  var index = 3000.obs;
  var paymentIndex = 1.obs;
  var dateLoad = false.obs;
  var isLoad = false.obs;
  int dateLoop = 1;
  RxList<Map<String, String>> timeList = [
    {'text': '7:00 AM', 'slot': '07:00 AM - 08:00 AM', 'time': '06:45:00'},
    {'text': '8:00 AM', 'slot': '08:00 AM - 09:00 AM', 'time': '07:45:00'},
    {'text': '9:00 AM', 'slot': '09:00 AM - 10:00 AM', 'time': '08:45:00'},
    {'text': '10:00 AM', 'slot': '10:00 AM - 11:00 AM', 'time': '09:45:00'},
    {'text': '11:00 AM', 'slot': '11:00 AM - 12:00 PM', 'time': '10:45:00'},
    {'text': '12:00 PM', 'slot': '12:00 PM - 01:00 PM', 'time': '11:45:00'},
    {'text': '1:00 PM', 'slot': '01:00 PM - 02:00 PM', 'time': '12:45:00'},
    {'text': '2:00 PM', 'slot': '02:00 PM - 03:00 PM', 'time': '13:45:00'},
    {'text': '3:00 PM', 'slot': '03:00 PM - 04:00 PM', 'time': '14:45:00'},
    {'text': '4:00 PM', 'slot': '04:00 PM - 05:00 PM', 'time': '15:45:00'},
    {'text': '5:00 PM', 'slot': '05:00 PM - 06:00 PM', 'time': '16:45:00'},
    {'text': '6:00 PM', 'slot': '06:00 PM - 07:00 PM', 'time': '17:45:00'},
    {'text': '7:00 PM', 'slot': '07:00 PM - 08:00 PM', 'time': '18:45:00'}
  ].obs;
  var radioId = 0.obs;

  initialLoad(String? serviceId) {
    dateLoop = 1;
    dateLoad.value = false;
    update();
    final carSpaController = Get.find<CarSpaController>();
    isLoad.value = true;
    update();
    Get.find<ServiceCheckOutController>().timeSlot.value = "";
    String date = '';
    if (DateTime.parse(
            '${DateTime.now().toString().substring(0, 10)} 19:00:00.000')
        .isBefore(DateTime.now())) {
      date = DateTime.now().add(const Duration(days: 1)).toString().substring(0, 10);
    } else {
      date = DateTime.now().toString().substring(0, 10);
    }
    dateShow.value = date;
    paymentIndex.value = 2;
    Get.find<CarSpaController>().getTimeSlot(serviceId, date).then((value) =>
        value
            ? {isLoad.value = false, update(), setIndex(carSpaController)}
            : loadNextDate(serviceId, date));
    update();
  }

  loadNextDate(String? serviceId, String date) {
    final carSpaController = Get.find<CarSpaController>();
    if (dateLoop <= 7) {
      dateLoop = dateLoop + 1;
      String nextDate = DateTime.parse('$date 00:00:00.000')
          .add(const Duration(days: 1))
          .toString()
          .substring(0, 10);

      dateShow.value = nextDate;
      Get.find<CarSpaController>().getTimeSlot(serviceId, nextDate).then(
          (value) => value
              ? {isLoad.value = false, update(), setIndex(carSpaController)}
              : loadNextDate(serviceId, nextDate));
    } else {
      isLoad.value = false;
      update();
      setIndex(carSpaController);
    }
  }

  void changeDate(BuildContext context, ServiceId? carSpaServiceDetails) async {
    DateTime? newDateTime;
    final carSpaController = Get.find<CarSpaController>();
    try {
      newDateTime = await showRoundedDatePicker(
        context: context,
        barrierDismissible: true,
        firstDate: DateTime.now().subtract(const Duration(days: 1)),
        lastDate: DateTime.now().add(const Duration(days: 6)),
        initialDate: DateTime.parse("${dateShow.value} 00:00:00.000"),
        borderRadius: 16,
        height: 300,
        theme: ThemeData(primarySwatch: primaryColor1),
        styleDatePicker: MaterialRoundedDatePickerStyle(
            textStyleYearButton: const TextStyle(
              fontSize: 17,
            ),
            textStyleButtonPositive: TextStyle(color: Colors.lightGreen[700]),
            textStyleButtonNegative: const TextStyle(color: Colors.black),
            textStyleCurrentDayOnCalendar: const TextStyle(color: Colors.black),
            paddingMonthHeader: const EdgeInsets.all(12),
            paddingDateYearHeader: const EdgeInsets.all(20),
            textStyleDayButton: const TextStyle(fontSize: 25, color: Colors.white)),
      );
    } catch (e) {
      print(e.toString());
    }
    if (newDateTime != null) {
      index.value = 3000;
      dateLoad.value = false;
      update();
      dateShow.value = newDateTime.toString().substring(0, 10);
      update();
      carSpaController
          .getTimeSlot(carSpaServiceDetails!.id, dateShow.value)
          .then((value) => setIndex(carSpaController));
    }
  }

  setIndex(carSpaController) {
    if (Get.find<CarSpaController>().carSpaTimeSlot.isNotEmpty) {
      final checkOutController = Get.find<ServiceCheckOutController>();
      timeList.asMap().forEach((
        value,
        element,
      ) {
        if (element['slot'] == carSpaController.carSpaTimeSlot[0]) {
          if (DateTime.now().toString().substring(0, 10) == dateShow.value) {
            if (DateTime.now().isBefore(DateTime.parse(
                "${dateShow.value} ${timeList[value]['time']}.000"))) {
              index.value = value;
              dateLoad.value = true;
              update();
            } else {
              index.value = value + 1;
              dateLoad.value = true;
              update();
            }
          } else {
            index.value = value;
            dateLoad.value = true;
            update();
          }
        }
      });
      checkOutController.timeSlot.value = timeList[index.value]['slot']!;
      update();
    }
    dateLoad.value = true;
    update();
  }
}
