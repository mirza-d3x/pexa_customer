import 'package:flutter/material.dart';
import 'package:shoppe_customer/view/screens/cart/cart_screen.dart';
import 'package:shoppe_customer/view/screens/home/homescreen.dart';
import 'package:shoppe_customer/view/screens/order/order_screen.dart';
import 'package:shoppe_customer/view/screens/profile/profile_screen.dart';
import 'package:shoppe_customer/view/screens/support/support_screen.dart';
class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState>? navigatorKey;
  final String? tabItem;

  const TabNavigator({super.key,this.tabItem,this.navigatorKey});

  @override
  Widget build(BuildContext context) {
    Widget? child;
    if(tabItem=="Home"){
      child = HomeScreen();
    }else if(tabItem=="Order"){
      child = const OrderScreen();
    }else if(tabItem == "Cart"){
      child = CartScreen(fromNav: false, fromMain: true);
    }else if(tabItem == "Support"){
      child = const SupportScreen();
    } else if(tabItem == "Profile"){
      child = ProfileScreen();
    }
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child!);
      },
    );
  }
}
