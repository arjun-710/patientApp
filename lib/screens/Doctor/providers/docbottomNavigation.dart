import 'package:flutter/material.dart';

class DocBottomNavigation extends ChangeNotifier {
  int _currentIndex = 2;
  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
