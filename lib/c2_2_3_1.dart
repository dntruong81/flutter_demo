import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // Bắt buộc phải import thư viện này để dùng widget Cupertino

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const TextFieldComparisonScreen(),
    );
  }
}

class TextFieldComparisonScreen extends StatelessWidget {
  const TextFieldComparisonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material vs Cupertino TextField'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Cấu phần 1: Phong cách Android (Material) ---
            const Text(
              'Phong cách Android (Material):',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Nhập dữ liệu vào đây...',
                // Mặc định TextField của Material sẽ có thanh gạch chân phía dưới
                helperText: 'Có thanh gạch chân & hiệu ứng gợn sóng khi nhấn giữ.',
              ),
            ),

            const SizedBox(height: 40), // Khoảng cách giữa 2 ô nhập liệu

            // --- Cấu phần 2: Phong cách iOS (Cupertino) ---
            const Text(
              'Phong cách iOS (Cupertino):',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            const CupertinoTextField(
              placeholder: 'Nhập dữ liệu vào đây...',
              padding: EdgeInsets.all(12.0),
              // Mặc định CupertinoTextField sẽ có khung viền xám và bo tròn các góc
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                'Khung bo tròn mờ xám chuẩn phong cách iOS.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
