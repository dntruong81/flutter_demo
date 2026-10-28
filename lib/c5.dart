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
      title: 'UI Layout Demo',
      theme: ThemeData(useMaterial3: true),
      home: const ProfileCardScreen(),
    );
  }
}

class ProfileCardScreen extends StatelessWidget {
  const ProfileCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thiết kế Giao diện'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade100,
      ),
      body: Center(
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // --- KỸ THUẬT 1: HÌNH ẢNH TRONG CONTAINER ĐỂ BO GÓC & THÊM VIỀN ---
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // Chuyển khung hình sang dạng hình tròn
                  border: Border.all(
                    color: Colors.blue, // Viền màu xanh
                    width: 4.0,         // Độ dày viền 4 logical pixels
                  ),
                  image: const DecorationImage(
                    image: NetworkImage('https://picsum.photos/id/600/200/300'), // Tải ảnh đại diện từ mạng
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // --- KỸ THUẬT 2: BỌC TEXT TRONG PADDING ĐỂ TRÁNH DÍNH MÉP MÀN HÌNH ---
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'Nguyễn Văn A',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0), // Đệm sâu 24px hai bên trái phải
                child: Text(
                  'Đây là đoạn văn bản mô tả ngắn về bản thân. Nhờ được bọc trong widget Padding, đoạn chữ này sẽ tự động xuống hàng một cách đẹp mắt mà không bao giờ bị dính sát dạt vào mép của chiếc thẻ nhựa hay màn hình điện thoại.',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                  textAlign: TextAlign.center, // Căn giữa dòng chữ
                ),
              ),

              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
