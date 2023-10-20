// ignore_for_file: must_be_immutable

import 'package:daily_shop/controllers/cart_controller.dart';
import 'package:daily_shop/screens/cartScreen/cart_screen.dart';
import 'package:daily_shop/screens/categoryScreen/category_screen.dart';
import 'package:daily_shop/screens/homeScreen/home_screen.dart';
import 'package:daily_shop/screens/profileScreen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatefulWidget {
  BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int selectedIndex = 0;
  List<Widget> pages = const [
    HomeScreen(),
    CategoryScreen(),
    CartScreen(),
    ProfileScreen()
  ];

  void selectPage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).cardColor,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).iconTheme.color,
        unselectedItemColor: Theme.of(context).iconTheme.color,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: selectedIndex,
        onTap: selectPage,
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(selectedIndex == 0 ? IconlyBold.home : IconlyLight.home),
          ),
          BottomNavigationBarItem(
            label: 'Category',
            icon: Icon(selectedIndex == 1
                ? IconlyBold.category
                : IconlyLight.category),
          ),
          BottomNavigationBarItem(
            label: 'Cart',
            icon: Consumer<CartController>(
              builder: (context, cartControllerValue, child) {
                return Badge(
                  label: Text(
                    cartControllerValue.getCartProductItems.length.toString(),
                  ),
                  child: Icon(
                      selectedIndex == 2 ? IconlyBold.buy : IconlyLight.buy),
                );
              },
            ),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(
                selectedIndex == 3 ? IconlyBold.profile : IconlyLight.profile),
          ),
        ],
      ),
      body: pages[selectedIndex],
    );
  }
}
