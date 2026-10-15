import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  // Status mode gelap (default: Light Mode)
  bool _isDarkMode = false;

  // Getter untuk mengecek status Dark Mode
  bool get isDarkMode => _isDarkMode;

  // Getter untuk mengambil ThemeData sesuai status
  ThemeData get themeData {
    return _isDarkMode ? ThemeData.dark() : ThemeData.light();
  }

  // Fungsi toggleTheme() untuk mengganti tema
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners(); // Memastikan perubahan langsung berlaku di seluruh aplikasi
  }
}