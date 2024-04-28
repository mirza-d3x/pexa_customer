import 'package:shoppe_customer/controller/myController/categoryController.dart';
import 'package:shoppe_customer/controller/tab_controller.dart';
import 'package:shoppe_customer/util/color.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/view/screens/order/widget/carShppeRunning.dart';
import 'package:shoppe_customer/view/screens/order/widget/carSpaRunning.dart';
import 'package:shoppe_customer/view/widgets/bouncing.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RunningOrdersView extends StatelessWidget {
  const RunningOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyTabController>(
      builder: (orderController) {
        return SizedBox(
          //color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Bouncing(
                      onPress: (orderController.pageIndex.value > 0)
                          ? () {
                        orderController.pageLeft(isRunning: true);
                      }
                          : null,
                      child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: blackPrimary,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 7,
                                offset:
                                const Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: const Center(
                              child: Icon(
                                Icons.keyboard_arrow_left,
                                color: Colors.white,
                              ))),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 40,
                        // padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 7,
                              offset:
                              const Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            orderController
                                .catList[orderController.pageIndex.value],
                            style: mediumFont(Colors.black),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Bouncing(
                      onPress: (orderController.pageIndex.value < 1)
                          ? () {
                        orderController.pageRight(isRunning: true);
                      }
                          : null,
                      child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: blackPrimary,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 7,
                                offset:
                                const Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: const Center(
                              child: Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.white,
                              ))),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              tabBody(orderController)
            ],
          ),
        );
      },
    );
  }

  Widget tabBody(MyTabController orderController) {
    if (orderController.pageIndex.value == 0) {
       Get.find<ProductCategoryController>().getOrderRunningDetailsShoppe('1');
      return Expanded(
        child: CarShoppeRunningOrders(),
      );
    } else {
      // Get.find<QuickHelpController>().getQuickHelpRunningOrders('1');
      return Expanded(
        child: CarSpaRunningOrders(),
      );
    }
  }
  }
  //   return GetBuilder<MyTabController>(
  //     builder: (orderController) {
  //       return Container(
  //         //color: Colors.white,
  //         height: MediaQuery.of(context).size.height,
  //         width: MediaQuery.of(context).size.width,
  //         child: Column(
  //           children: [
  //             SizedBox(
  //               height: 10,
  //             ),
  //           /*  SizedBox(
  //               width: MediaQuery.of(context).size.width,
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   SizedBox(
  //                     width: 10,
  //                   ),
  //                   Bouncing(
  //                     onPress: (orderController.pageIndex.value > 0)
  //                         ? () {
  //                             orderController.pageLeft(isRunning: true);
  //                           }
  //                         : null,
  //                     child: Container(
  //                         padding: EdgeInsets.all(5),
  //                         decoration: BoxDecoration(
  //                           color: blackPrimary,
  //                           borderRadius: BorderRadius.circular(50),
  //                           boxShadow: [
  //                             BoxShadow(
  //                               color: Colors.grey.withOpacity(0.5),
  //                               blurRadius: 7,
  //                               offset:
  //                                   Offset(0, 3), // changes position of shadow
  //                             ),
  //                           ],
  //                         ),
  //                         child: Center(
  //                             child: Icon(
  //                           Icons.keyboard_arrow_left,
  //                           color: Colors.white,
  //                         ))),
  //                   ),
  //                   SizedBox(
  //                     width: 10,
  //                   ),
  //                   Expanded(
  //                     flex: 1,
  //                     child: Container(
  //                       height: 40,
  //                       // padding: EdgeInsets.symmetric(horizontal: 10),
  //                       decoration: BoxDecoration(
  //                         color: Colors.white,
  //                         borderRadius: BorderRadius.circular(10),
  //                         boxShadow: [
  //                           BoxShadow(
  //                             color: Colors.grey.withOpacity(0.5),
  //                             blurRadius: 7,
  //                             offset:
  //                                 Offset(0, 3), // changes position of shadow
  //                           ),
  //                         ],
  //                       ),
  //                       child: Center(
  //                         child: Text(
  //                           orderController
  //                               .catList[orderController.pageIndex.value],
  //                           style: mediumFont(Colors.black),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     width: 10,
  //                   ),
  //                   Bouncing(
  //                     onPress: (orderController.pageIndex.value < 3)
  //                         ? () {
  //                             orderController.pageRight(isRunning: true);
  //                           }
  //                         : null,
  //                     child: Container(
  //                         padding: EdgeInsets.all(5),
  //                         decoration: BoxDecoration(
  //                           color: blackPrimary,
  //                           borderRadius: BorderRadius.circular(50),
  //                           boxShadow: [
  //                             BoxShadow(
  //                               color: Colors.grey.withOpacity(0.5),
  //                               blurRadius: 7,
  //                               offset:
  //                                   Offset(0, 3), // changes position of shadow
  //                             ),
  //                           ],
  //                         ),
  //                         child: Center(
  //                             child: Icon(
  //                           Icons.keyboard_arrow_right,
  //                           color: Colors.white,
  //                         ))),
  //                   ),
  //                   SizedBox(
  //                     width: 10,
  //                   ),
  //                 ],
  //               ),
  //             ),*/
  //             SizedBox(
  //               height: 10,
  //             ),
  //             tabBody(orderController)
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
  //
  // Widget tabBody(MyTabController orderController) {
  //
  //   return Expanded(
  //     child: CarSpaRunningOrders(),
  //   );
  //
  // }
   /* if (orderController.pageIndex.value == 0) {
      // Get.find<ProductCategoryController>().getOrderRunningDetailsShoppe('1');
      return Expanded(
        child: CarShoppeRunningOrders(),
      );
    } else if (orderController.pageIndex.value == 1) {
      // Get.find<CarSpaController>().getCarSpaRunningOrders('1');
      return Expanded(
        child: CarSpaRunningOrders(),
      );
    } else if (orderController.pageIndex.value == 2) {
      // Get.find<MechanicalController>().getMechanicalRunningOrders('1');
      return Expanded(
        child: MechanicalRunningOrders(),
      );
    } else {
      // Get.find<QuickHelpController>().getQuickHelpRunningOrders('1');
      return Expanded(
        child: QuickHelpRunningOrders(),
      );
    }
  }*/

