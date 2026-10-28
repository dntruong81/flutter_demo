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
      home: MyHomeScreen(),
    );
  }
}

class MyHomeScreen extends StatelessWidget {
  const MyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. SCAFFOLD (CHA): Widget gốc để dựng cấu trúc toàn bộ màn hình
    return Scaffold(

      // 2. APPBAR (CON): Thanh tiêu đề nằm ở phía trên cùng của Scaffold
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,

        // Thuộc tính ép tiêu đề phải nằm ở CHÍNH GIỮA thanh AppBar
        centerTitle: true,

        // 3. TEXT (CHÁU): Tiêu đề dạng chữ nằm bên trong AppBar
        title: const Text('Hello World'),
      ),

      // Phần thân của màn hình (Có thể thêm nội dung khác ở đây)
      body: const Center(
        child: Text('Nội dung ứng dụng nằm ở đây'),
      ),
    );
  }
}
