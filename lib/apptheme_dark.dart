// apptheme_dark.dart
import 'package:flutter/material.dart';

class AppTheme {
  // Bước 1: Định nghĩa biến tĩnh darkTheme
  static ThemeData darkTheme = ThemeData(
    // Bước 2: Khai báo cấu hình darkTheme chi tiết
    brightness: Brightness.dark, // Chuyển đổi độ sáng hệ thống sang Dark Mode

    // Màu nền trang
    scaffoldBackgroundColor: Colors.black54,

    // Định kiểu riêng cho thanh ứng dụng (AppBar)
    appBarTheme: const AppBarTheme(
      color: Colors.purple,
      elevation: 0,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    ),

    // Định kiểu màu nút bấm (ElevatedButton)
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple, // Màu nền nút
        foregroundColor: Colors.white, // Màu chữ/icon trên nút
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Bo góc nút
        ),
      ),
    ),

    // Đổi màu icon toàn cục sang màu trắng
    iconTheme: const IconThemeData(
      color: Colors.white,
      size: 24,
    ),

    // Đổi màu các định dạng chữ sang màu trắng/xám sáng
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
      bodyMedium: TextStyle(color: Colors.white70, fontSize: 14), // Xám sáng
    ),
  );
}
