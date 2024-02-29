// ignore_for_file: must_be_immutable

/// This file defines the DashBoardScreen widget, which serves as the main navigation hub of the PillCart application.
/// It features a bottom navigation bar with four tabs: Home, Cart, Orders, and Settings. Each tab corresponds to a different screen within the app.
/// The screen uses an IndexedStack to efficiently switch between the different screens without rebuilding them from scratch.
/// The bottom navigation bar is customized to include icons and labels for each tab, with different styles for selected and unselected states.
///
/// Key sections of the code include:
/// - The `DashBoardScreen` class: This is the main widget for the dashboard screen. It initializes the HomeScreenController and defines the UI layout.
/// - The `BottomNavigationBar` widget: Provides the navigation bar at the bottom of the screen. It includes customization for the appearance of selected and unselected items.
/// - The `IndexedStack` widget: Contains the child widgets for each tab's screen. It efficiently switches between these screens based on the current index.
/// - The `_bottomNavigationBarItem` method: A helper method to create BottomNavigationBarItem instances with custom icons and labels.
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pill_cart/controller/home_screen_controller.dart';
import 'package:pill_cart/helper/constant.dart';
import 'package:pill_cart/screens/cart_screen.dart';
import 'package:pill_cart/screens/orders_screen.dart';
import 'package:pill_cart/screens/home_screen.dart';
import 'package:pill_cart/screens/settings_scree.dart';

class DashBoardScreen extends StatelessWidget {
  HomeScreenController homeScreenController = Get.put(HomeScreenController());

  DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(builder: (controller) {
      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: kBrand600,
          showUnselectedLabels: false,
          elevation: 8,
          selectedLabelStyle: const TextStyle(fontSize: 1),
          unselectedLabelStyle: const TextStyle(fontSize: 1),
          selectedIconTheme: const IconThemeData(size: 40),
          unselectedIconTheme: const IconThemeData(size: 30),
          unselectedItemColor: Colors.grey[500],
          onTap: homeScreenController.changeTabIndex,
          currentIndex: homeScreenController.tabIndex,
          items: [
            _bottomNavigationBarItem(icon: Icons.home_outlined, activIcon: Icons.home),
            _bottomNavigationBarItem(icon: Icons.shopping_cart_outlined, activIcon: Icons.shopping_cart),
            _bottomNavigationBarItem(icon: Icons.history_outlined, activIcon: Icons.history),
            _bottomNavigationBarItem(icon: Icons.settings_outlined, activIcon: Icons.settings),
          ],
        ),
        body: SafeArea(
          child: IndexedStack(
            index: homeScreenController.tabIndex,
            children: [
              HomeScreen(),
              CartScreen(),
              OrdersScreen(),
              SettingsScreen(),
            ],
          ),
        ),
      );
    });
  }

  _bottomNavigationBarItem({required IconData icon, required IconData activIcon}) {
    return BottomNavigationBarItem(
        activeIcon: Icon(
          activIcon,
        ),
        icon: Icon(
          icon,
        ),
        label: '');
  }
}
