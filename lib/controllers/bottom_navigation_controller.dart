import 'package:flutter/material.dart';

class BottomNavigationController with ChangeNotifier {
  int _pageIndex = 0;
  int get pageIndex => _pageIndex;

  //* set page index for changing the screen
  set setPageIndex(int newIndex) {
    _pageIndex = newIndex;
    notifyListeners();
  }
}
