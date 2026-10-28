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
        primarySwatch: Colors.blue,
      ),
      home: const SocialMediaHomeScreen(),
    );
  }
}

class SocialMediaHomeScreen extends StatelessWidget {
  const SocialMediaHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // SCAFFOLD: Khung nền móng chính của toàn bộ màn hình trang chủ
    return Scaffold(

      // 1. appBar: Thanh tiêu đề trên cùng chứa Logo mạng xã hội
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.share, color: Colors.blue, size: 28), // Biểu tượng mạng xã hội
            SizedBox(width: 8),
            Text(
              'Mạng xã hội App',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),

      // 2. drawer: Menu vuốt từ cạnh trái màn hình ra chứa các cài đặt tài khoản
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(radius: 30, backgroundColor: Colors.white, child: Icon(Icons.person, size: 35)),
                  SizedBox(height: 10),
                  Text('Nguyễn Văn A', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Thông tin tài khoản'),
              onTap: () {
                print("Thông tin: Nguyễn Văn A");
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Cài đặt tài khoản'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Đăng xuất'),
              onTap: () {},
            ),
          ],
        ),
      ),

      // 3. body: Phần thân chính hiển thị Bảng tin (Newsfeed)
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: 5, // Ví dụ hiển thị 10 bài viết mẫu
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(radius: 20, child: Icon(Icons.person)),
                      const SizedBox(width: 10),
                      Text('Người dùng ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text('Đây là nội dung bài đăng mẫu thứ ${index + 1} trên bảng tin mạng xã hội của bạn.'),
                ],
              ),
            ),
          );
        },
      ),

      // 4. floatingActionButton: Nút bấm nổi ở góc dưới bên phải để Đăng bài mới
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Xử lý sự kiện mở màn hình tạo bài viết mới tại đây
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.edit),
      ),
    );
  }
}
