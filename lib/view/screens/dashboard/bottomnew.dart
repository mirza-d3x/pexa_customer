import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:shoppe_customer/controller/myController/cartController.dart';

import 'package:shoppe_customer/util/images.dart';

import 'package:shoppe_customer/view/screens/dashboard/widget/tabnavigator.dart';

// import 'package:shoppe_customer/view/widgets/bottom_navigation_bar.dart';

class BottomNew extends StatefulWidget {
  const BottomNew({super.key, required this.seletedIndex});
  final int seletedIndex;
  @override
  State<BottomNew> createState() => _BottomNewState();
}

class _BottomNewState extends State<BottomNew> {
  int selectedindex = 0;
  String _currentPage = "Home";
  List<String> pageKeys = ["Home", "Order", "Cart", "Support", "Profile"];
  final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Home": GlobalKey<NavigatorState>(),
    "Order": GlobalKey<NavigatorState>(),
    "Cart": GlobalKey<NavigatorState>(),
    "Support": GlobalKey<NavigatorState>(),
    "Profile": GlobalKey<NavigatorState>(),
  };

  void _selectTab(String tabItem, int index) {
    if (tabItem == _currentPage) {
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        selectedindex = index;
      });
    }
  }

  @override
  void initState() {
    selectedindex = widget.seletedIndex;
    _currentPage = pageKeys[widget.seletedIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentPage]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentPage != "Home") {
            _selectTab("Home", 0);
            return false;
          }
        }
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(children: <Widget>[
          _buildOffstageNavigator("Home"),
          _buildOffstageNavigator("Order"),
          _buildOffstageNavigator("Cart"),
          _buildOffstageNavigator("Support"),
          _buildOffstageNavigator("Profile"),
        ]),
        bottomNavigationBar: BottomNavigationBarWidget(
          selectedIndex: selectedindex,
          onTap: (index) {
            Get.find<CartControllerFile>().getCartDetails(true);
            _selectTab(pageKeys[index], index);
          },
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}

class BottomNavigationBarWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const BottomNavigationBarWidget({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        showUnselectedLabels: true,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              Images.home_active,
              scale: 2.5,
            ),
            icon: Image.asset(
              Images.home,
              scale: 2.5,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              Images.order_active,
              scale: 2.5,
            ),
            icon: Image.asset(
              Images.order,
              scale: 2.5,
            ),
            label: "Order",
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              Images.cart_active,
              scale: 2.5,
            ),
            icon: Image.asset(
              Images.cart,
              scale: 2.5,
            ),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              Images.supports_active,
              scale: 2.5,
            ),
            icon: Image.asset(
              Images.supports,
              scale: 2.5,
            ),
            label: "Support",
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              Images.account_active,
              scale: 2.5,
              color: Colors.black,
            ),
            icon: Image.asset(
              Images.account,
              scale: 2.5,
              color: Colors.black12,
            ),
            label: "Profile",
          ),
        ],
        onTap: onTap,
      ),
    );
  }
}
