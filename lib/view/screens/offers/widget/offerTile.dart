import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:shoppe_customer/util/color.dart';
import 'package:shoppe_customer/util/new_fonts.dart';

class MainOfferTile extends StatelessWidget {
  const MainOfferTile({super.key, this.index, this.data});
  final List? data;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 300,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/carSpa/offer.png'), fit: BoxFit.fill)),
      child: Stack(
        children: [
          Positioned(
            right: 5,
            child: SizedBox(
              height: 200,
              child: RotatedBox(
                quarterTurns: -1,
                child: Center(
                  child: (data![index!]['price'] != 'FREE')
                      ? Text(
                          'SAVE ' + data![index!]['price'],
                          style: offerPrice(Colors.black),
                        )
                      : Text(
                          data![index!]['price'],
                          style: offerPrice(Colors.black),
                        ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 3,
            top: 5,
            child: Container(
              height: 80,
              width: 80,
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(120),
                      topLeft: Radius.circular(10))),
              child: Stack(
                children: [
                  Positioned(
                      top: 7,
                      left: 7,
                      child: Transform.rotate(
                        angle: -math.pi / 4,
                        child: Image.asset(
                          'assets/carSpa/latestlogo.png',
                          height: 50,
                        ),
                      ))
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            left: 10,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.black),
                child: Text(data![index!]['category'],
                    style: couponSave(botAppBarColor)),
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: 90,
            child: SizedBox(
              width: 230,
              child: Text(
                data![index!]['description'],
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: largeFont(Colors.green),
              ),
            ),
          ),
          Positioned(
              top: 20,
              left: 88,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2.5),
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                width: 150,
                child: Text(
                  data![index!]['title'],
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: offerPriceTitle(Colors.white),
                ),
              ))
        ],
      ),
    );
  }
}
