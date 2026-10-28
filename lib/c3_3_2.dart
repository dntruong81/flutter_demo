import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScaffoldExampleScreen(),
    );
  }
}

class ScaffoldExampleScreen extends StatelessWidget {
  const ScaffoldExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // --- CẤU HÌNH APPBAR THEO ĐỀ BÀI ---
      appBar: AppBar(
        title: const Text('Scaffold Example'), // Tiêu đề mặc định nằm bên trái (trên Android)
        actions: [
          IconButton(
            icon: const Icon(Icons.search), // Biểu tượng kính lúp tìm kiếm ở góc phải
            onPressed: () {
              print('Vừa nhấn vào nút tìm kiếm trên appBar');
              // Xử lý hành động tìm kiếm khi người dùng nhấn vào đây
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Nội dung màn hình ví dụ'),
      ),
    );
  }
}
