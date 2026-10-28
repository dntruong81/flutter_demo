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
      title: 'Ứng dụng Hiển thị Icon',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true, // Sử dụng Material 3 để giao diện hiện đại hơn
      ),
      home: const IconDemoScreen(),
    );
  }
}

class IconDemoScreen extends StatelessWidget {
  const IconDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minh họa Icon Flutter'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade100,
      ),
      body: Container(
        // Tạo nền gradient nhẹ phía sau làm nổi bật hoa tuyết
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.white],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // --- ĐOẠN MÃ ICON CỦA BẠN ĐƯỢC ĐẶT TẠI ĐÂY ---
              const Icon(
                Icons.ac_unit_outlined,
                size: 80,
                color: Colors.blue,
              ),
              // --------------------------------------------

              const SizedBox(height: 20), // Tạo khoảng cách nhỏ

              Text(
                'Bông tuyết mùa đông',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Kích thước: 80 logical pixels',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
