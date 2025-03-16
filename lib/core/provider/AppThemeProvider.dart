import 'package:flutter/material.dart';

class AppThemeProvider extends ChangeNotifier {
  // ThemeMode appTheme = ThemeMode.light;//   الافتراضية
  ThemeMode appTheme = ThemeMode.dark;//   الافتراضية



  void changeTheme(ThemeMode newTheme) {
    if (appTheme == newTheme) return;
    appTheme = newTheme;
    notifyListeners(); // إعلام الواجهة بأن هناك تحديث
  }
}
