import 'package:flutter/material.dart';

class BottomNavigation extends ChangeNotifier {
  int _currentIndex = 4;
  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
