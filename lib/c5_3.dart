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
      home: const NotificationScreen(),
    );
  }
}

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo Align Widget'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      // SafeArea giúp bảo vệ widget khỏi tai thỏ hoặc thanh điều hướng hệ thống
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Tạo khoảng cách nhỏ với cạnh màn hình
          child: Align(
            alignment: Alignment.topLeft, // Đặt widget con ở góc dưới cùng bên phải
            child: IconButton(
              icon: const Icon(
                Icons.notifications,
                size: 40,
                color: Colors.blue,
              ),
              onPressed: () {
                // Hành động khi nhấn vào biểu tượng thông báo
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Bạn vừa nhấn vào thông báo!')),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
