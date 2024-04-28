import 'package:flutter/material.dart';
import 'package:shoppe_customer/view/widgets/bouncing.dart';

class RoundEditButton extends StatelessWidget {
  const RoundEditButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Bouncing(
      onPress: () {
        Navigator.pop(context);
      },
      child: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
            color: Colors.yellow.withOpacity(0.8),
            borderRadius: const BorderRadius.all(
              Radius.circular(50),
            )),
        child: const Center(
          child: Icon(
            Icons.edit,
            color: Colors.black,
            size: 15,
          ),
        ),
      ),
    );
  }
}
