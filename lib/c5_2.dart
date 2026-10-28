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
          title: const Text('Ví dụ Padding trong Flutter'),
          backgroundColor: Colors.blue,
        ),
        body: const Center(
          child: NameInputExample(),
        ),
      ),
    );
  }
}

class NameInputExample extends StatelessWidget {
  const NameInputExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Widget Padding bọc ngoài ô chữ để tạo khoảng cách lề trái 50px
        Padding(
          padding: const EdgeInsets.only(left: 50.0),
          child: SizedBox(
            width: 300, // Giới hạn chiều rộng để dễ quan sát lề phải
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Nhập tên người dùng',
                hintText: 'Nhập tên của bạn tại đây...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: const Icon(Icons.person),
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Dòng chữ minh họa để bạn thấy rõ vị trí bắt đầu từ lề trái 50px
        const Padding(
          padding: EdgeInsets.only(left: 50.0),
          child: Text(
            '* Ô nhập liệu trên đã được cách lề trái chính xác 50px.',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
