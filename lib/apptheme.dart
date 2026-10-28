// apptheme.dart
import 'package:flutter/material.dart';

// Bước 1: Mở rộng lớp AppTheme với ChangeNotifier
class AppTheme extends ChangeNotifier {
  // Quản lý biến trạng thái, mặc định ban đầu là true (giao diện tối)
  bool _isDarkTheme = true;

  // Cung cấp Getter để lấy ra ThemeMode hiện tại
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  // Hàm chuyển đổi trạng thái chủ đề và thông báo tới các Listener
  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners(); // Báo cho các Widget đang lắng nghe để cập nhật giao diện
  }

  // --- CẤU HÌNH GIAO DIỆN SÁNG (LIGHT THEME) ---
  ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Colors.indigo,
      elevation: 0,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.blueGrey, fontSize: 32, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(color: Colors.blueGrey, fontSize: 14),
    ),
    iconTheme: const IconThemeData(color: Colors.blueGrey, size: 24),
  );

  // --- CẤU HÌNH GIAO DIỆN TỐI (DARK THEME) ---
  ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black54,
    appBarTheme: const AppBarTheme(
      color: Colors.purple,
      elevation: 0,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.white, size: 24),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(color: Colors.white70, fontSize: 14),
    ),
  );
}
