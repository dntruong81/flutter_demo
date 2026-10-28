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
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const ChatHomeScreen(),
    );
  }
}

class ChatHomeScreen extends StatelessWidget {
  const ChatHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // --- APPBAR PHÍA TRÊN ---
      appBar: AppBar(
        title: const Text('Tin nhắn', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          // IconButton hình kính lọc nằm ở góc phải AppBar để lọc tin nhắn
          IconButton(
            icon: const Icon(Icons.filter_list),
            tooltip: 'Lọc tin nhắn',
            onPressed: () {
              print('Đã bấm nút lọc tin nhắn (Chưa đọc, Nhóm, v.v...)');
            },
          ),
        ],
      ),

      // --- PHẦN THÂN HIỂN THỊ DANH SÁCH CHAT ---
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue.shade100,
              child: Text('${index + 1}'),
            ),
            title: Text('Người dùng ${index + 1}'),
            subtitle: const Text('Nội dung tin nhắn mới nhất nằm ở đây...'),
            trailing: const Text('12:30', style: TextStyle(color: Colors.grey, fontSize: 12)),
          );
        },
      ),

      // --- FLOATING ACTION BUTTON (FAB) Ở GÓC DƯỚI ---
      // FAB tròn màu xanh chứa biểu tượng cây bút dùng để tạo cuộc trò chuyện mới
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,      // Đổi màu nền của FAB thành màu xanh
        foregroundColor: Colors.white,    // Đổi màu biểu tượng cây bút thành màu trắng
        shape: const CircleBorder(),      // Ép kiểu dáng FAB thành hình tròn hoàn toàn
        onPressed: () {
          print('Mở màn hình tạo cuộc trò chuyện mới');
        },
        child: const Icon(Icons.edit),    // Biểu tượng cây bút
      ),
    );
  }
}
