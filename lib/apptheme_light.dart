// apptheme.dart
import 'package:flutter/material.dart';

class AppTheme {
  // Bước 1: Khai báo biến tĩnh lightTheme cấu hình môi trường ban ngày
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,

    // Màu nền trang sáng trắng
    scaffoldBackgroundColor: Colors.white,

    // Định kiểu thanh ứng dụng màu xanh chàm
    appBarTheme: const AppBarTheme(
      color: Colors.indigo,
      elevation: 0,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: Colors.white),
    ),

    // Màu nút bấm nổi bật (Đỏ)
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red, // Màu nền nút đỏ
        foregroundColor: Colors.white, // Màu chữ trên nút
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),

    // Màu chữ chuyển sang tông tối (blueGrey) để hiển thị rõ trên nền trắng
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.blueGrey, fontSize: 32, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: Colors.blueGrey, fontSize: 16),
      bodyMedium: TextStyle(color: Colors.blueGrey, fontSize: 14),
    ),

    // Định kiểu icon toàn cục đồng bộ với màu chữ tối
    iconTheme: const IconThemeData(
      color: Colors.blueGrey,
      size: 24,
    ),
  );
}
