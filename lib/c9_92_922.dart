// main.dart
import 'package:flutter/material.dart';
import 'apptheme_light.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter LightTheme Demo',
      debugShowCheckedModeBanner: false,

      // Bước 2: Khai báo thuộc tính theme nhận cấu hình lightTheme
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light, // Ép ứng dụng luôn chạy chế độ sáng

      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Giao diện Sáng (Light Theme)'),
        leading: const Icon(Icons.menu), // Icon màu trắng theo appBarTheme
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Tiêu đề ứng dụng',
                style: textTheme.displayLarge, // Chữ màu Xanh xám
              ),
              const SizedBox(height: 10),
              Text(
                'Nội dung văn bản hiển thị rõ ràng trên nền sáng nhờ tông chữ blueGrey.',
                style: textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Icon(Icons.wb_sunny, size: 60, color: Theme.of(context).iconTheme.color), // Icon màu Xanh xám
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Bấm vào đây'), // Nút màu Đỏ, chữ Trắng
              ),
            ],
          ),
        ),
      ),
    );
  }
}
