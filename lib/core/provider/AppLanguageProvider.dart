import 'package:flutter/material.dart';

class AppLanguageProvider extends ChangeNotifier {
  String _appLanguage = 'en'; //   الافتراضية

  String get appLanguage => _appLanguage; //  للوصول إلى اللغة الحالية

  void changeLanguage(String newLanguage) {
    if (_appLanguage == newLanguage) return;
    _appLanguage = newLanguage;
    notifyListeners(); // إعلام الواجهة بأن هناك تحديث
  }
}
