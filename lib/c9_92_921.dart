// main.dart
import 'package:flutter/material.dart';
import 'apptheme_dark.dart'; // Import lớp AppTheme vừa tạo ở Bước 1

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter AppTheme Demo',
      debugShowCheckedModeBanner: false,

      // Bước 3: Đăng ký darkTheme vào MaterialApp
      darkTheme: AppTheme.darkTheme,

      // Ép ứng dụng luôn hiển thị chế độ Dark Mode để kiểm tra (hoặc dùng ThemeMode.system để theo hệ thống)
      themeMode: ThemeMode.dark,

      home: const HomeScreen(),
    );
  }
}

// Giao diện demo để kiểm tra các thuộc tính theme đã cài đặt
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giao diện tối (Dark Theme)'),
        leading: const Icon(Icons.menu), // Icon tự động nhận IconTheme màu trắng
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Tiêu đề lớn',
                style: Theme.of(context).textTheme.displayLarge, // Chữ màu trắng
              ),
              const SizedBox(height: 10),
              Text(
                'Đây là đoạn văn bản mô tả sử dụng màu xám sáng để nội dung dễ nhìn hơn.',
                style: Theme.of(context).textTheme.bodyMedium, // Chữ màu xám sáng
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              const Icon(Icons.star, size: 50), // Icon tự động nhận màu trắng
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Bấm vào đây'), // Nút tự động nhận màu tím, chữ trắng
              ),
            ],
          ),
        ),
      ),
    );
  }
}
