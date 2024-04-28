import 'package:shoppe_customer/data/models/service_model.dart';
import 'package:shoppe_customer/view/screens/carSpa/widget/carspa_payment_chooser_widget.dart';
import 'package:shoppe_customer/view/screens/carSpa/widget/carspa_proceed_payment_widget.dart';
import 'package:flutter/material.dart';

class CarSpaBottomAppBar extends StatelessWidget {
  const CarSpaBottomAppBar({super.key, this.carSpaServiceResultData});
  final ServiceId? carSpaServiceResultData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(child: CarSpaPaymentChooserWidget()),
          const SizedBox(width: 10,),
          CarSpaProceedPaymentWidget()
        ],
      ),
    );
  }
}
