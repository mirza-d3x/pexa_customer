import 'package:shoppe_customer/controller/myController/cartController.dart';
import 'package:shoppe_customer/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartWidget extends StatelessWidget {
  final Color? color;
  final double size;
  final bool fromRestaurant;

  const CartWidget(
      {super.key, required this.color, required this.size, this.fromRestaurant = false});

  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: [
      Icon(
        Icons.shopping_cart,
        size: size,
        color: Colors.black,
      ),
      Positioned(
        top: -5,
        right: -5,
        child: Container(
          height: size < 20 ? 10 : size / 2,
          width: size < 20 ? 10 : size / 2,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: fromRestaurant ? Theme.of(context).cardColor : Colors.black,
            border: Border.all(
                width: size < 20 ? 0.7 : 1,
                color: Theme.of(context).primaryColor),
          ),
          child: GetBuilder<CartControllerFile>(builder: (controller) {
            return Text(
              controller.cartList != null
                  ? controller.cartList!.length.toString()
                  : "0",
              style: robotoRegular.copyWith(
                fontSize: size < 20 ? size / 3 : size / 3.8,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).cardColor,
              ),
            );
          }),
        ),
      )
    ]);
  }
}
