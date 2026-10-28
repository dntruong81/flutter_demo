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
      title: 'Trực quan hóa Margin',
      theme: ThemeData(useMaterial3: true),
      home: const MarginDemoScreen(),
    );
  }
}

class MarginDemoScreen extends StatelessWidget {
  const MarginDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trực quan hóa Margin (10px)'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade100,
      ),
      body: Container(
        color: Colors.grey.shade300, // Nền xám đậm hơn để dễ nhìn thấy khoảng trống
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Hộp mốc phía trên (Không có margin)
            Container(
              width: 200.0,
              height: 50.0,
              color: Colors.amber,
              child: const Center(child: Text("Hộp phía trên (Dính sát)")),
            ),

            // --- CHIẾC HỘP CỦA BẠN (CÓ MARGIN 10PX) ---
            Container(
              width: 200.0,
              height: 100.0,
              margin: const EdgeInsets.all(50),   // Đẩy các phần tử xung quanh ra xa 10px
              padding: const EdgeInsets.all(40),  // Đẩy chữ bên trong lùi vào 20px
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                "Hey There!",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            // ------------------------------------------

            // Hộp mốc phía dưới (Không có margin)
            Container(
              width: 200.0,
              height: 50.0,
              color: Colors.amber,
              child: const Center(child: Text("Hộp phía dưới (Dính sát)")),
            ),
          ],
        ),
      ),
    );
  }
}
