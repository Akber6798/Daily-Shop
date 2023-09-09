// ignore_for_file: must_be_immutable

import 'package:daily_shop/controllers/bottom_navigation_controller.dart';
import 'package:daily_shop/screens/cartscreen/cart_screen.dart';
import 'package:daily_shop/screens/categoryscreen/category_screen.dart';
import 'package:daily_shop/screens/homescreen/home_screen.dart';
import 'package:daily_shop/screens/profilescreen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({super.key});

  List<Widget> pages =  [
    HomeScreen(),
    CategoryScreen(),
    CartScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationController>(
      builder: (context, newValue, child) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Theme.of(context).cardColor,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Theme.of(context).iconTheme.color,
            unselectedItemColor: Theme.of(context).iconTheme.color,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: newValue.pageIndex,
            onTap: (value) {
              newValue.setPageIndex = value;
            },
            items: [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(newValue.pageIndex == 0
                    ? IconlyBold.home
                    : IconlyLight.home),
              ),
              BottomNavigationBarItem(
                label: 'Category',
                icon: Icon(newValue.pageIndex == 1
                    ? IconlyBold.category
                    : IconlyLight.category),
              ),
              BottomNavigationBarItem(
                label: 'Cart',
                icon: Icon(
                    newValue.pageIndex == 2 ? IconlyBold.buy : IconlyLight.buy),
              ),
              BottomNavigationBarItem(
                label: 'Profile',
                icon: Icon(newValue.pageIndex == 3
                    ? IconlyBold.profile
                    : IconlyLight.profile),
              ),
            ],
          ),
          body: pages[newValue.pageIndex],
        );
      },
    );
  }
}
