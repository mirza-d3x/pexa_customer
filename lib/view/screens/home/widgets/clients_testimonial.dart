import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shoppe_customer/util/new_fonts.dart';

class ClientsTestimonial extends StatefulWidget {
  const ClientsTestimonial({super.key});

  @override
  State<ClientsTestimonial> createState() => _ClientsTestimonialState();
}

class _ClientsTestimonialState extends State<ClientsTestimonial> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              "Client’s Testimonials",
              style: smallFontNew(Colors.black),
            ),
          ),
          CarouselSlider(
              items: [
                Row(
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: Column(
                        children: [
                          Expanded(
                              child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage(
                                        "assets/image/menu/client image.png"),
                                    fit: BoxFit.cover),
                                border: Border.all(
                                  color: Colors.yellow,
                                ),
                                borderRadius: BorderRadius.circular(30)),
                          )),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Rahul",
                            style: smallFont(Colors.black),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        "Booked an interior and exterior cleaning service through the Pexa app.The car washing professional arrived on time and did an excellent job. Overall, I was very satisfied with Pexa Carcare.",
                        style: verySmallFont(Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: Column(
                        children: [
                          Expanded(
                              child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage(
                                        "assets/image/menu/client image.png"),
                                    fit: BoxFit.cover),
                                border: Border.all(
                                  color: Colors.yellow,
                                ),
                                borderRadius: BorderRadius.circular(30)),
                          )),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Sreya ",
                            style: smallFont(Colors.black),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        "The app was super easy to use, and the service was awesome. My car looks great and smells nice too. Definitely the best doorstep car care service.",
                        style: verySmallFont(Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: Column(
                        children: [
                          Expanded(
                              child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage(
                                        "assets/image/menu/client image.png"),
                                    fit: BoxFit.cover),
                                border: Border.all(
                                  color: Colors.yellow,
                                ),
                                borderRadius: BorderRadius.circular(30)),
                          )),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Mahesh",
                            style: smallFont(Colors.black),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        "Using the Pexa app was convenient, and the pressure wash service arrived exactly as scheduled I'm really impressed with how clean my car is. The service was excellent.",
                        style: verySmallFont(Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: Column(
                        children: [
                          Expanded(
                              child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage(
                                        "assets/image/menu/client image.png"),
                                    fit: BoxFit.cover),
                                border: Border.all(
                                  color: Colors.yellow,
                                ),
                                borderRadius: BorderRadius.circular(30)),
                          )),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Sajith",
                            style: smallFont(Colors.black),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        "Great experience.. Amazing service at very affordable price.. It's been a great experience booking through Pexa app as per our convenience and the on time delivery of service.",
                        style: verySmallFont(Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
              options: CarouselOptions(
                height: 100,
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 600),
                viewportFraction: 1,
              )),
        ],
      ),

      /* Column(
        children: [
          SizedBox(height: 10,),
          Center(
            child: Text("Client’s Testimonials",style: smallFontNew(Colors.black),),
          ),
          SizedBox(height: 14,),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/image/menu/client image.png"),fit: BoxFit.cover,scale: 1),
                        borderRadius: BorderRadius.circular(30),border: Border.all(color: Colors.yellow)),
                  ),
                  SizedBox(height: 4,),
                  Text("John",style: smallFont(Colors.black),)
                ],
              ),
              SizedBox(width: 10,),
              Expanded(
                child: Text("Sed ut perspiciatis unde omnis iste natus error sit"
                    "voluptatem accusantium doloremque laudantium, totam"
                    "rem aperiam, eaque ipsa quae ab illo inventore veritatis et"
                    "quasi architecto beatae vitae dicta sunt explicabo.",style: verySmallFont(Colors.black),),
              ),
            ],
          ),
          SizedBox(height: 10,),
        ],
      ),*/
    );
  }
}
