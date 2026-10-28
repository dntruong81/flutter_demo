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
      home: ListTileExampleScreen(),
    );
  }
}

class ListTileExampleScreen extends StatelessWidget {
  const ListTileExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListTile Example'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          // --- CẤU HÌNH LISTTILE THEO ĐỀ BÀI ---
          ListTile(
            leading: const Icon(Icons.mail), // Biểu tượng hòm thư ở góc trái ngoài cùng
            title: const Text('Inbox'),      // Tiêu đề chính lớn ở giữa
            subtitle: const Text('Usage of ListTile'), // Dòng phụ đề nhỏ nằm ngay dưới tiêu đề
            trailing: const Icon(Icons.favorite, color: Colors.red), // Trái tim màu đỏ ở góc phải ngoài cùng
            onTap: () {
              // Bấm vào dòng này để xử lý sự kiện (Ví dụ: Mở hộp thư)
            },
          ),
          const Divider(), // Đường kẻ ngang mỏng phân cách giữa các dòng
          ListTile(
            leading: const Icon(Icons.mail), // Biểu tượng hòm thư ở góc trái ngoài cùng
            title: const Text('Inbox'),      // Tiêu đề chính lớn ở giữa
            subtitle: const Text('Usage of ListTile'), // Dòng phụ đề nhỏ nằm ngay dưới tiêu đề
            trailing: const Icon(Icons.favorite, color: Colors.red), // Trái tim màu đỏ ở góc phải ngoài cùng
            onTap: () {
              // Bấm vào dòng này để xử lý sự kiện (Ví dụ: Mở hộp thư)
            },
          ),
          const Divider(), // Đường kẻ ngang mỏng phân cách giữa các dòng
          ListTile(
            leading: const Icon(Icons.mail), // Biểu tượng hòm thư ở góc trái ngoài cùng
            title: const Text('Inbox'),      // Tiêu đề chính lớn ở giữa
            subtitle: const Text('Usage of ListTile'), // Dòng phụ đề nhỏ nằm ngay dưới tiêu đề
            trailing: const Icon(Icons.favorite, color: Colors.red), // Trái tim màu đỏ ở góc phải ngoài cùng
            onTap: () {
              // Bấm vào dòng này để xử lý sự kiện (Ví dụ: Mở hộp thư)
            },
          ),
        ],
      ),
    );
  }
}
