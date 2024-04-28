import 'package:shoppe_customer/controller/myController/wishlistController.dart';
import 'package:shoppe_customer/data/models/service_model.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/carSpaController.dart';
import 'package:shoppe_customer/util/dimensions.dart';
import 'package:shoppe_customer/view/screens/carSpa/widget/carSpaBottumUpView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CarSpaServiceTile extends StatefulWidget {
  const CarSpaServiceTile(
      {super.key, this.carSpaServiceResultData, this.index});
  final ServiceId? carSpaServiceResultData;
  final int? index;
  @override
  State<CarSpaServiceTile> createState() => _CarSpaServiceTileState();
}

class _CarSpaServiceTileState extends State<CarSpaServiceTile> {
  final craSpaController = Get.find<CarSpaController>();
  final wishlistController = Get.put(WishListController());
  final urltwo = "https://www.youtube.com/watch?v=wDt9cI8BYI0&t=2s";

  @override
  void initState() {
    YoutubePlayer.convertUrlToId(urltwo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.carSpaServiceResultData!.id);
    return GestureDetector(
      onTap: () {
        print(widget.index);
        craSpaController.carSpaAddOnTotal.value =
            widget.carSpaServiceResultData!.price as int;
        craSpaController
            .setRadioStatusList(widget.carSpaServiceResultData!.addOns!.length);
        Get.bottomSheet(
            carSpaBottomUpView(
                context,
                widget.index,
                craSpaController.carSpaServiceProperty[widget.index!],
                widget.carSpaServiceResultData),
            isScrollControlled: true);
      },
      child: Container(
        // height: Get.height * 0.1,
        padding: const EdgeInsets.only(bottom: 5),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 2,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
              padding: const EdgeInsets.only(top: 2),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.height * 0.10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(widget
                                    .carSpaServiceResultData!.imageUrl![0]),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Text(
                                widget.carSpaServiceResultData!.name!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: mediumFont(Colors.black),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: ListView.builder(
                                itemCount: (craSpaController
                                            .carSpaServiceProperty[
                                                widget.index!]
                                            .length >
                                        3)
                                    ? 3
                                    : craSpaController
                                        .carSpaServiceProperty[widget.index!]
                                        .length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.only(top: 0),
                                itemBuilder: (context, i) {
                                  return Text(
                                    '◍ ' +
                                        craSpaController.carSpaServiceProperty[
                                            widget.index!][i],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: smallFont(Colors.grey),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '₹ ${widget.carSpaServiceResultData!.price}',
                              style: mediumFont(Colors.black),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ((widget.carSpaServiceResultData!.description != 'test') &&
                          (widget.carSpaServiceResultData!.description != null))
                      ? Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.025,
                            width: 70,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: const BoxDecoration(
                              color: Color(0xcff10e2a3),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                    Dimensions.RADIUS_EXTRA_LARGE),
                                bottomRight: Radius.circular(
                                    Dimensions.RADIUS_EXTRA_LARGE),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                widget.carSpaServiceResultData!.description
                                    .toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: veryverySmallFontW600(Colors.white),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  Positioned(
                    top: 80,
                    right: 8,
                    child: Row(
                      children: [
                        Container(
                          height: 20,
                          width: 55,
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              "Book Now",
                              style: veryverySmallFontW600(Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
