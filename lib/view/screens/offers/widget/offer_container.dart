import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OfferTile extends StatelessWidget {
  const OfferTile({super.key, this.data, this.index});
  final List? data;
  final int? index;

  @override
  Widget build(BuildContext context) {
    var color = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.purple,
      Colors.orange,
      Colors.pink,
      Colors.teal,
      Colors.cyan,
      Colors.lime,
      Colors.indigo,
      Colors.yellow,
    ];

    final random = Random();
    return Column(
      children: [
        InkWell(
          onTap: () {
            //showCustomSnackBar('Offers are not available now.');
            // SmartDialog.showToast(
            //   'Offers are not available now.',
            // );
          },
          child: Container(
              //height: 100,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 5,
                    spreadRadius: 5,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Container(
                child: Row(
                  children: [
                    Container(
                      width: 10,
                      height: 100,
                      decoration: BoxDecoration(
                          color: color[random.nextInt(color.length)]),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      'assets/carSpa/latestlogo.png',
                      height: 50,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data![index!]['title'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: GoogleFonts.mukta().fontFamily,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              data![index!]['description'],
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: GoogleFonts.mukta().fontFamily,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "OK",
        style: TextStyle(
          fontSize: 20,
          fontFamily: GoogleFonts.mukta().fontFamily,
          fontWeight: FontWeight.w300,
        ),
      ),
      onPressed: () {
        Get.back();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Not available"),
      content: const Text("Offers are not available now."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
