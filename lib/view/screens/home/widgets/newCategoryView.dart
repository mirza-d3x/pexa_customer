import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/tab_controller.dart';
import 'package:shoppe_customer/view/widgets/bouncing.dart';

class NewCategoryView extends StatelessWidget {
  NewCategoryView({super.key});

  final control = Get.find<TabControllerMethod>();
  final List categoryDetails = [
    'assets/image/menu/shoppe_btn.png',
    'assets/image/menu/carspa_btn.png',
    'assets/image/menu/mechanical_btn.png',
    'assets/image/menu/quick_btn.png',
  ];
  final List categories = [
    'assets/image/menu/shoppe.png',
    'assets/image/menu/carspa.png',
    'assets/image/menu/mechanical.png',
    'assets/image/menu/quick.png',
  ];

  final List categoryTitle = [
    'Shoppe',
    'Car Spa',
    'Mechanical',
    'Quick Service',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Center(
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Bouncing(
                    onPress: () {
                      if (control.tabIndex.value != 0) {
                        control.tabIndex.value = 0;
                      } else {
                        control.tabIndex.value = 6;
                      }
                    },
                    child: Container(
                      height: 90,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: control.tabIndex.value == 0
                            ? AssetImage(
                                categoryDetails[0],
                              )
                            : AssetImage(
                                categories[0],
                              ),
                        fit: BoxFit.contain,
                      )),
                    ),
                  ),
                ),
                // SizedBox(
                //   width: 5,
                // ),
                Expanded(
                  child: Bouncing(
                    onPress: () {
                      if (control.tabIndex.value != 1) {
                        control.tabIndex.value = 1;
                      } else {
                        control.tabIndex.value = 6;
                      }
                    },
                    child: Container(
                      height: 90,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: control.tabIndex.value == 1
                            ? AssetImage(
                                categoryDetails[1],
                              )
                            : AssetImage(
                                categories[1],
                              ),
                        fit: BoxFit.contain,
                      )),
                    ),
                  ),
                ),
                // SizedBox(
                //   width: 5,
                // ),
                Expanded(
                    child: Bouncing(
                  onPress: () {
                    if (control.tabIndex.value != 2) {
                      control.tabIndex.value = 2;
                    } else {
                      control.tabIndex.value = 6;
                    }
                  },
                  child: Container(
                    height: 90,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: control.tabIndex.value == 2
                          ? AssetImage(
                              categoryDetails[2],
                            )
                          : AssetImage(
                              categories[2],
                            ),
                      fit: BoxFit.contain,
                    )),
                  ),
                )),
                // SizedBox(
                //   width: 5,
                // ),
                Expanded(
                  child: Bouncing(
                    onPress: () {
                      if (control.tabIndex.value != 3) {
                        control.tabIndex.value = 3;
                      } else {
                        control.tabIndex.value = 6;
                      }
                    },
                    child: Container(
                      height: 90,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: control.tabIndex.value == 3
                            ? AssetImage(
                                categoryDetails[3],
                              )
                            : AssetImage(
                                categories[3],
                              ),
                        fit: BoxFit.contain,
                      )),
                    ),
                  ),
                )
              ],
            ),
            // child: Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Expanded(
            //       flex: 4,
            //       child: Bouncing(
            //         onPress: () {
            //           if (control.tabIndex.value != 0) {
            //             control.tabIndex.value = 0;
            //           } else {
            //             control.tabIndex.value = 6;
            //           }
            //         },
            //         child: Container(
            //           height: 90,
            //           decoration: BoxDecoration(
            //               image: DecorationImage(
            //             image: control.tabIndex.value == 0
            //                 ? AssetImage(
            //                     categoryDetails[0],
            //                   )
            //                 : AssetImage(
            //                     categories[0],
            //                   ),
            //             fit: BoxFit.cover,
            //           )),
            //         ),
            //       ),
            //     ),
            //     Expanded(
            //       flex: 4,
            //       child: Bouncing(
            //         onPress: () {
            //           if (control.tabIndex.value != 1) {
            //             control.tabIndex.value = 1;
            //           } else {
            //             control.tabIndex.value = 6;
            //           }
            //         },
            //         child: Container(
            //           height: 90,
            //           decoration: BoxDecoration(
            //               image: DecorationImage(
            //             image: control.tabIndex.value == 1
            //                 ? AssetImage(
            //                     categoryDetails[1],
            //                   )
            //                 : AssetImage(
            //                     categories[1],
            //                   ),
            //             fit: BoxFit.cover,
            //           )),
            //         ),
            //       ),
            //     ),
            //     Expanded(
            //       flex: 4,
            //       child: Bouncing(
            //         onPress: () {
            //           if (control.tabIndex.value != 2) {
            //             control.tabIndex.value = 2;
            //           } else {
            //             control.tabIndex.value = 6;
            //           }
            //         },
            //         child: Container(
            //           height: 90,
            //           decoration: BoxDecoration(
            //               // color: Colors.white,
            //               image: DecorationImage(
            //             image: control.tabIndex.value == 2
            //                 ? AssetImage(
            //                     categoryDetails[2],
            //                   )
            //                 : AssetImage(
            //                     categories[2],
            //                   ),
            //             fit: BoxFit.cover,
            //           )),
            //         ),
            //       ),
            //     ),
            //     Expanded(
            //       flex: 4,
            //       child: Bouncing(
            //         onPress: () {
            //           if (control.tabIndex.value != 3) {
            //             control.tabIndex.value = 3;
            //           } else {
            //             control.tabIndex.value = 6;
            //           }
            //         },
            //         child: Container(
            //           height: 90,
            //           decoration: BoxDecoration(
            //               image: DecorationImage(
            //             image: control.tabIndex.value == 3
            //                 ? AssetImage(
            //                     categoryDetails[3],
            //                   )
            //                 : AssetImage(
            //                     categories[3],
            //                   ),
            //             fit: BoxFit.cover,
            //           )),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ),
        ),
      ),
    );
  }
}
