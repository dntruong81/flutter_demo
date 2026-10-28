import 'package:flutter/material.dart';

void main() {
  runApp(const NewsApp());
}

/// 1. Hệ thống ROUTING: Sử dụng onGenerateRoute thay vì thuộc tính routes mặc định
class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Router App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: '/',
      // Quản lý định tuyến tập trung tại onGenerateRoute
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            );

          case '/article':
          // Bóc tách và ép kiểu dữ liệu ngay tại hệ thống Route
            final args = settings.arguments as Map<String, String>?;

            // Lấy ra các giá trị, nếu null thì gán giá trị mặc định
            final String title = args?['title'] ?? 'Không có tiêu đề';
            final String content = args?['content'] ?? 'Không có nội dung';

            return MaterialPageRoute(
              builder: (context) => ArticleScreen(title: title, content: content),
            );

          default:
          // Xử lý khi ứng dụng điều hướng đến một đường dẫn không tồn tại
            return MaterialPageRoute(
              builder: (context) => const Scaffold(
                body: Center(child: Text('Đường dẫn không tồn tại!')),
              ),
            );
        }
      },
    );
  }
}

/// 2. Màn hình NAVIGATION gốc: HomeScreen (Trang chủ chứa danh sách bài viết)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, String>> articles = const [
    {
      'title': 'Flutter ra mắt phiên bản mới siêu mượt',
      'content': 'Phiên bản Flutter mới mang lại hiệu năng đồ họa đột phá với Engine Impeller, giúp các hiệu ứng cuộn trang và chuyển cảnh đạt chuẩn 120Hz trên mọi thiết bị di động.'
    },
    {
      'title': 'Trí tuệ nhân tạo (AI) thay đổi lập trình di động',
      'content': 'Các công cụ AI hiện nay hỗ trợ lập trình viên viết code Flutter nhanh gấp 2 lần, tự động phát hiện lỗi và tối ưu hóa cấu trúc Widget trực tiếp theo thời gian thực.'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang Chủ Tin Tức'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: articles.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final article = articles[index];
          return ListTile(
            title: Text(
              article['title']!,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Lệnh pushNamed giữ nguyên cấu trúc truyền dữ liệu
              Navigator.pushNamed(
                context,
                '/article',
                arguments: article,
              );
            },
          );
        },
      ),
    );
  }
}

/// 3. Màn hình đích: ArticleScreen (Nhận dữ liệu trực tiếp qua Constructor)
class ArticleScreen extends StatelessWidget {
  // Dữ liệu được yêu cầu bắt buộc truyền vào khi khởi tạo Object
  final String title;
  final String content;

  const ArticleScreen({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    // Không cần dùng ModalRoute.of(context) ở đây nữa!
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nội Dung Chi Tiết'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title, // Sử dụng biến trực tiếp từ Class
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  content, // Sử dụng biến trực tiếp từ Class
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Quay về trang chủ'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
