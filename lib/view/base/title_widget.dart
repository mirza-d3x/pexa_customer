import 'package:flutter/material.dart';
import 'package:shoppe_customer/helper/fonts.dart';
import 'package:shoppe_customer/view/screens/carshoppe/widget/view_all_product.dart';

class TitleData extends StatelessWidget {
  final String title;
  final Function? onTap;
  const TitleData({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(title,
          style: defaultFont(
            color: Colors.black,
            size: 14,
            weight: FontWeight.bold,
          )),
      (onTap != null)
          ? InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAllProduct(),));
    },
    /*onTap as void Function()?,*/
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                child: Text(
                  'View All',
                  style: defaultFont(
                    color: Colors.black,
                    size: 12,
                    weight: FontWeight.w400,
                  ),
                ),
              ),
            )
          : const SizedBox(),
    ]);
  }
}
