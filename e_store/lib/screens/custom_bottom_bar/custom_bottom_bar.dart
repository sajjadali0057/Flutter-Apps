import 'package:e_store/screens/account_screen/account_screen.dart';
import 'package:e_store/screens/cart_screen/cart_screen.dart';
import 'package:e_store/screens/favourite_screen/favourite_screen.dart';
import 'package:e_store/screens/home/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({final Key? key})
      : super(key: key);

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  PersistentTabController _controller= PersistentTabController();
  bool _hideNavBar = false;
  List<Widget> _buildScreens() => [
    homePage(),
    CartScreen(),
    FavouriteScreen(),
    AccountScreen(),

  ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
    PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: "Home",
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.shopping_cart),
      title: "Cart",
      activeColorPrimary: Colors.white,
      inactiveColorPrimary: Colors.white,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.favorite),
      title: "Favorite",
      activeColorPrimary: Colors.white,
      inactiveColorPrimary: Colors.white,

    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.person),
      title: "Account",
      activeColorPrimary: Colors.white,
      inactiveColorPrimary: Colors.white,
    ),
  ];

  @override
  Widget build(final BuildContext context) => Scaffold(
    body: PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      resizeToAvoidBottomInset: true,
      navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
          ? 0.0
          : kBottomNavigationBarHeight,
      bottomScreenMargin: 0,
      // onWillPop: (final context) async {
      //   await showDialog(
      //     context: context!,
      //     useSafeArea: true,
      //     builder: (final context) => Container(
      //       height: 50,
      //       width: 50,
      //       color: Colors.white,
      //       child: ElevatedButton(
      //         child: const Text("Close"),
      //         onPressed: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //     ),
      //   );
      //   return false;
      // },
      backgroundColor: Theme.of(context).primaryColor,
      hideNavigationBar: _hideNavBar,
      decoration: const NavBarDecoration(colorBehindNavBar: Colors.indigo),
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 400),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
      ),
      navBarStyle: NavBarStyle
          .style1, // Choose the nav bar style with this property
    ),
  );
}
