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
          title: const Text('SizedBox Button Demo'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: Center(
          // Đoạn mã ép kích thước nút bấm của bạn
          child: SizedBox(
            width: 150,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                // Hành động khi nhấn nút
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Bo góc nút bấm
                ),
              ),
              child: const Text(
                'Sign In',
                style: TextStyle(fontSize: 24), // Tăng kích cỡ chữ cho cân đối với nút to
              ),
            ),
          ),
        ),
      ),
    );
  }
}
