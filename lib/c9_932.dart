import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ResponsiveDemoScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ResponsiveDemoScreen extends StatelessWidget {
  const ResponsiveDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Lấy kích thước toàn màn hình của thiết bị hiện tại
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive Container Demo'),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Hiển thị thông số kích thước màn hình thực tế để dễ quan sát
            Text(
              'Kích thước màn hình: ${deviceWidth.toStringAsFixed(1)} x ${deviceHeight.toStringAsFixed(1)}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // 2. Khai báo Container màu đỏ theo tỷ lệ màn hình
            Container(
              width: deviceWidth * 0.5,   // Luôn chiếm 1/2 chiều rộng màn hình
              height: deviceHeight * 0.25, // Luôn chiếm 1/4 chiều cao màn hình
              color: Colors.red,
              alignment: Alignment.center,
              child: const Text(
                'Width: 50%\nHeight: 25%',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
