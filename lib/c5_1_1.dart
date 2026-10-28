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
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Minh họa BoxConstraints.tight'),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Trường hợp 1: Chữ rất ngắn
              const Text(
                'Trường hợp 1: Chữ ngắn ("Hello!")',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                constraints: BoxConstraints.tight(const Size(200, 100)),
                color: Colors.amber, // Màu nền để thấy rõ kích thước
                alignment: Alignment.center, // Căn giữa chữ
                child: const Text('Hello!'),
              ),

              const SizedBox(height: 40), // Khoảng cách giữa 2 ví dụ

              // Trường hợp 2: Chữ rất dài
              const Text(
                'Trường hợp 2: Chữ dài dằng dặc',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                constraints: BoxConstraints.tight(const Size(200, 100)),
                color: Colors.lightGreen, // Màu nền để thấy rõ kích thước
                alignment: Alignment.center,
                child: const Text(
                  'Đây là một đoạn văn bản rất dài để kiểm tra xem Container có bị phình to ra hay không!',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
