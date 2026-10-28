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
      home: ButtonExampleScreen(),
    );
  }
}

class ButtonExampleScreen extends StatelessWidget {
  const ButtonExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ElevatedButton Example'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        // --- CẤU HÌNH ELEVATEDBUTTON THEO ĐỀ BÀI ---
        child: ElevatedButton(
          onPressed: () {
            // In dòng chữ ra màn hình Debug Console khi người dùng nhấp vào nút
            print('Vừa nhấn vào nút Print');
          },
          child: const Text('Print'), // Chữ hiển thị bên trên nút bấm
        ),
      ),
    );
  }
}
