import 'package:shoppe_customer/helper/fonts.dart';
import 'package:flutter/material.dart';

class BottomNavItem extends StatelessWidget {
  final String path;
  final String? title;
  final Function? onTap;
  final bool isSelected;

  const BottomNavItem(
      {super.key, required this.path, this.onTap, this.isSelected = false, this.title});

  @override
  Widget build(BuildContext context) {
    return isSelected
        ? InkWell(
            onTap: onTap as void Function()?,
            child: Container(
             /* decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: Color(0XFFf7d417), width: 3)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFf9e9a2),
                      Color(0xFFfbf0ba),
                      Color(0xFFfdf1c0),
                      Color(0xFFfdf7d9),
                      Color(0xFFfef8e1),
                      Color(0xFFfdf7e0),
                    ],
                  )),*/
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // isSelected?
                  // Container(
                  //   height:10,
                  //   color: Colors.orange,
                  // ):
                  // SizedBox(),
                  Container(
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.all(Radius.circular(10)),
                    //     color: Colors.black.withOpacity(0.3)),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ImageIcon(
                      AssetImage(
                        path,
                      ),
                      // color: Color(0xFFf7d417)
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    title!,
                    style: defaultFont(
                      color: Colors.black
                      // Color(0XFFf7d417)
                      ,
                      weight: FontWeight.w700,
                    ),
                  )
                ],
              ),
            ),
            // ),
          )
        : InkWell(
            onTap: onTap as void Function()?,
            // child: Bouncing(
            //     onPress: onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ImageIcon(
                    AssetImage(
                      path,
                    ),
                    color: Colors.grey[400],
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(title!,
                    style: defaultFont(
                        color: Colors.black, weight: FontWeight.w600)),
              ],
            ),
            //  ),
          );
  }
}
