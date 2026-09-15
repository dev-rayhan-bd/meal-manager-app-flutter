import 'package:flutter/material.dart';
import '../../app/constants/app_translations.dart';

/// Global App State Manager for Theme (Dark/Light) and Language (BN/EN).
class AppState extends ChangeNotifier {
  static final AppState instance = AppState._();
  AppState._();

  ThemeMode _themeMode = ThemeMode.light;
  String _languageCode = 'bn'; // Default to Bangla

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  String get languageCode => _languageCode;
  bool get isEnglish => _languageCode == 'en';

  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setLanguage(String code) {
    if (_languageCode != code) {
      _languageCode = code;
      notifyListeners();
    }
  }

  void toggleLanguage() {
    _languageCode = _languageCode == 'bn' ? 'en' : 'bn';
    notifyListeners();
  }

  String tr(String key) {
    return AppTranslations.getText(key, _languageCode);
  }
}
