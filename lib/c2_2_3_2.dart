import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CrossPlatformDesignScreen(),
    );
  }
}

class CrossPlatformDesignScreen extends StatelessWidget {
  const CrossPlatformDesignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Cố định nền màu trắng cho cả 2 hệ điều hành
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 1. Widget Icon: Hiển thị hình trái tim màu đỏ cố định kích thước 50px
            const Icon(
              Icons.favorite,
              color: Colors.red,
              size: 50.0,
            ),

            const SizedBox(height: 20), // Khoảng cách giữa Icon và Text

            // 2. Widget Text: Hiển thị chữ 'Hello World' cố định cỡ chữ, màu sắc và độ đậm
            const Text(
              'Xin chào',
              style: TextStyle(
                fontSize: 24.0,           // Kích thước chữ cố định 24px
                fontWeight: FontWeight.bold, // Chữ đậm cố định
                color: Colors.black,       // Màu chữ đen cố định
                decoration: TextDecoration.none, // Bỏ các đường gạch chân hệ thống
              ),
            ),
          ],
        ),
      ),
    );
  }
}
