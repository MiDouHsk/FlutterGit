import 'package:flutter/material.dart';

class MainViewModel with ChangeNotifier {
  int menustaturs = 0; // close, 1 open
  int activemenu = 0; // index cuar menu item
  void toggleMenu() {
    if (menustaturs == 0) {
      menustaturs = 1;
    } else {
      menustaturs = 0;
    }
    notifyListeners();
  }

  void setActiveMenu(int index) {
    activemenu = index;
    notifyListeners();
  }

  void closeMenu() {
    menustaturs = 0;
    notifyListeners();
  }
}
