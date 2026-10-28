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
          title: const Text('Newfeed Mạng Xã Hội'),
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
        ),
        backgroundColor: Colors.grey[200],
        // 3. Sử dụng ListView để danh sách bài viết cuộn liên tục
        body: ListView.builder(
          itemCount: 3, // Số lượng bài viết mẫu
          itemBuilder: (context, index) {
            return const PostCard();
          },
        ),
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        // 2. Toàn bộ bài viết xếp từ trên xuống dưới (Column)
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Ảnh đại diện và Tên người dùng xếp hàng ngang (Row)
            Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.orange,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Nguyễn Văn A',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text('2 giờ trước', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Nội dung văn bản bài viết
            const Text(
              'Hôm nay trời đẹp quá! Mình vừa chụp được một bức ảnh tuyệt vời tại bãi biển.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12),

            // 4. Nút thả tim nằm đè lên góc bức ảnh (Stack)
            Stack(
              children: [
                // Thành phần nằm dưới cùng: Bức ảnh bài viết
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.image, size: 50, color: Colors.grey),
                ),
                // Thành phần nằm đè lên trên: Nút thả tim ở góc
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.9),
                    child: IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () {
                        // Xử lý thả tim bài viết
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
