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
      home: UserCardScreen(),
    );
  }
}

class UserCardScreen extends StatelessWidget {
  const UserCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Nền xám nhạt để làm nổi bật thẻ
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),

            // --- BẮT ĐẦU WIDGET ROW ---
            child: Row(
              children: [
                // 1. Ảnh đại diện nằm BÊN TRÁI (Sử dụng hình tròn)
                const CircleAvatar(
                  radius: 30, // Đường kính của vòng tròn là 60px
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.person, size: 35, color: Colors.white),
                  // Hoặc dùng ảnh từ mạng: backgroundImage: NetworkImage('url_anh'),
                ),

                const SizedBox(width: 16), // Tạo một khoảng trống vừa phải giữa ảnh và tên
                // 2. Tên người dùng nằm BÊN PHẢI
                const Text(
                  'Nguyễn Văn A',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  'Địa chỉ',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),

            // --- KẾT THÚC WIDGET ROW ---

          ),
        ),
      ),
    );
  }
}
