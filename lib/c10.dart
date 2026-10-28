import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SocialMediaDemoScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SocialMediaDemoScreen extends StatefulWidget {
  const SocialMediaDemoScreen({super.key});

  @override
  State<SocialMediaDemoScreen> createState() => _SocialMediaDemoScreenState();
}

class _SocialMediaDemoScreenState extends State<SocialMediaDemoScreen> {
  late Future<String> _fetchPostFuture;

  // 1. Khai báo Stream kiểu int trực tiếp thay vì StreamController
  late Stream<int> _likeStream;
  int _currentLikes = 42;

  @override
  void initState() {
    super.initState();
    _fetchPostFuture = _getPostData();

    // 2. Khởi tạo luồng bằng cách gọi hàm async* chứa từ khóa yield
    _likeStream = _createInitialLikeStream();
  }

  // Hàm tải dữ liệu bài viết tĩnh
  Future<String> _getPostData() async {
    await Future.delayed(const Duration(seconds: 2));
    return 'Hôm nay trời đẹp quá! Mọi người đi chơi ở đâu thế? ☀️✨';
  }

  // 3. Sử dụng yield để phát số lượng thích mặc định ban đầu
  Stream<int> _createInitialLikeStream() async* {
    yield _currentLikes;
  }

  // 4. HÀM CHÍNH: Tạo luồng tăng lượt thích liên tục bằng cách yield dữ liệu sau mỗi 800ms
  Stream<int> _simulateIncomingLikesStream() async* {
    // Đầu tiên phát ngay số lượng hiện tại ra luồng
    yield _currentLikes;

    // Giả lập tăng 5 lần tương tác từ xa
    for (int i = 1; i <= 5; i++) {
      await Future.delayed(const Duration(milliseconds: 800));
      _currentLikes += 1;

      yield _currentLikes; // Dùng yield bắn số mới ra ngoài thay cho .add()
    }
    // Sau khi kết thúc vòng lặp này, luồng Stream sẽ tự động đóng lại (Done)
  }

  // Xử lý khi chính người dùng bấm nút thả tim
  Stream<int> _toggleMyLike() async* {
    _currentLikes += 1;

    yield _currentLikes; // Dùng yield bắn số mới ra trực tiếp tại đây
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('Instagram Async* / Yield'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        actions: [
          // Nút bấm kích hoạt luồng dữ liệu giả lập từ xa
          IconButton(
            icon: const Icon(Icons.bolt, color: Colors.amber),
            tooltip: 'Giả lập tương tác từ xa',
            onPressed: () {
              // Khi nhấn nút, ta nạp luồng sinh ra từ hàm yield vào giao diện
              setState(() {
                _likeStream = _simulateIncomingLikesStream();
              });
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          width: 400,
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.purple,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                title: Text('flutter_developer', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Được tài trợ'),
              ),
              Container(
                height: 200,
                width: double.infinity,
                color: Colors.blueGrey,
                child: const Icon(Icons.image, size: 60, color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: FutureBuilder<String>(
                  future: _fetchPostFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator(color: Colors.purple));
                    } else {
                      return Text(snapshot.data ?? '', style: const TextStyle(fontSize: 16));
                    }
                  },
                ),
              ),
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red, size: 28),
                      onPressed: () {
                        setState(() {
                          // Phép gán luồng diễn ra ngay tại nút bấm khi hàm được kích hoạt
                          _likeStream = _toggleMyLike();
                        });
                      },
                    ),
                    const SizedBox(width: 4),

                    // 5. StreamBuilder giữ nguyên cấu trúc lắng nghe từ biến luồng trực tiếp
                    StreamBuilder<int>(
                      stream: _likeStream, // Lắng nghe luồng sinh ra từ yield
                      initialData: _currentLikes,
                      builder: (context, snapshot) {
                        return Text(
                          '${snapshot.data} lượt thích',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        );
                      },
                    ),
                    const Spacer(),
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Text('Cập nhật liên tục', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
