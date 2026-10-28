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
        backgroundColor: Colors.white, // Nền trắng giống ảnh mẫu
        body: Center(
          // Sử dụng SingleChildScrollView cho chiều dọc để đảm bảo không bị tràn trên màn hình nhỏ
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // === KHỐI 1 (Ở TRÊN) ===
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Khối 1',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF1A252F)),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      width: 200,
                      height: 200,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFF3B30),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'BoxShape.circle',
                      style: TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.bold, color: Colors.red, fontSize: 16),
                    ),
                  ],
                ),

                const SizedBox(height: 50), // Khoảng cách dọc ngăn cách giữa Khối 1 và Khối 2

                // === KHỐI 2 (Ở DƯỚI) ===
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Khối 2',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF1A252F)),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      width: 200,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF3B30), // Nền hình vuông đỏ
                        borderRadius: BorderRadius.circular(20), // Bo góc 20px
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 20.0,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      // foregroundDecoration đè sát cạnh tạo hiệu ứng 4 góc khuyết đỏ
                      foregroundDecoration: BoxDecoration(
                        color: const Color(0xFF00A2E8), // Lớp phủ màu xanh dương
                        borderRadius: BorderRadius.circular(100), // Bo tròn tối đa 100px
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'foregroundDecoration',
                      style: TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.bold, color: Color(0xFF007ACC), fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
