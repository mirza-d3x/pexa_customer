import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/view/screens/cart/cart_screen.dart';
import 'package:shoppe_customer/view/screens/home/homescreen.dart';
import 'package:shoppe_customer/view/screens/order/order_screen.dart';
import 'package:shoppe_customer/view/screens/profile/profile_screen.dart';
import 'package:shoppe_customer/view/screens/support/support_screen.dart';

class BottomNavigationBars extends StatefulWidget {
  final bool pageFromLogin;
  const BottomNavigationBars({super.key, this.pageFromLogin = false});

  @override
  State<BottomNavigationBars> createState() => _BottomNavigationBarsState();
}

class _BottomNavigationBarsState extends State<BottomNavigationBars> {
  List<Widget> _buildScreens() {
    return [
      HomeScreen(newUser: widget.pageFromLogin),
      const OrderScreen(),
      CartScreen(fromNav: false, fromMain: true),
      const SupportScreen(),
      ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Home"),
        iconSize: 20,
        textStyle: smallFontNew(Colors.black),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.black38,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.bookmark_border),
        title: ("Order"),
        iconSize: 20,
        textStyle: smallFontNew(Colors.black),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.black38,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.favorite_border_outlined),
        title: ("Wishlist"),
        iconSize: 20,
        textStyle: smallFontNew(Colors.black),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.black38,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.support_agent_outlined),
        title: ("Support"),
        iconSize: 20,
        textStyle: smallFontNew(Colors.black,),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.black38,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: ("Account"),
        iconSize: 20,
        textStyle: smallFontNew(Colors.black),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.black38,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    PersistentTabController controller;
    controller = PersistentTabController(initialIndex: 0);

    return GestureDetector(
      onTap: (){
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: HomeScreen(),
          withNavBar: true, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
      child: PersistentTabView(
        context,
        controller: controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style6,

      ),
    );

  }

}
