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
      home: StreamCountdownScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StreamCountdownScreen extends StatefulWidget {
  const StreamCountdownScreen({super.key});

  @override
  State<StreamCountdownScreen> createState() => _StreamCountdownScreenState();
}

class _StreamCountdownScreenState extends State<StreamCountdownScreen> {
  late Stream<int> _countdownStream;

  @override
  void initState() {
    super.initState();
    _countdownStream = _createCountdownStream();
  }

  // 1. Tạo hàm Stream phát dữ liệu tuân thủ nghiêm ngặt theo thời gian yêu cầu
  Stream<int> _createCountdownStream() async* {
    // Giây thứ nhất: Trì hoãn 1 giây ban đầu (Giao diện sẽ rơi vào ConnectionState.waiting)
    await Future.delayed(const Duration(seconds: 1));

    // Từ giây thứ 2 đến giây thứ 10: Vòng lặp đếm ngược nhảy số từ 9 về 1 (ConnectionState.active)
    for (int i = 60; i >= 1; i--) {
      yield i;
      await Future.delayed(const Duration(seconds: 1)); // Đợi 1 giây trước khi nhảy số tiếp theo
    }

    // Sau khi vòng lặp kết thúc, hàm kết thúc đồng nghĩa với việc Stream tự động ĐÓNG (ConnectionState.done)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Mô phỏng Luồng Trạng Thái Stream'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 2. Sử dụng StreamBuilder để bắt trọn từng khoảnh khắc trạng thái kết nối
            StreamBuilder<int>(
              stream: _countdownStream,
              builder: (context, snapshot) {

                // --- TRẠNG THÁI 1: Giây đầu tiên ứng dụng chờ tải dữ liệu ---
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(color: Colors.blue.shade700),
                      const SizedBox(height: 16),
                      const Text(
                        'Giây thứ nhất: Đang kết nối...',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  );
                }

                // --- TRẠNG THÁI 3: Khi Stream chạy xong và đóng lại hoàn toàn (Về 0) ---
                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Time Up!',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        color: Colors.red.shade50,
                        child: const Text(
                          'ConnectionState.done',
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  );
                }

                // --- TRẠNG THÁI 2: Từ giây thứ 2 đến giây 10 (Đang nhận dữ liệu đếm ngược) ---
                if (snapshot.connectionState == ConnectionState.active) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${snapshot.data}', // Hiển thị số từ 9 về 1
                        style: TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        color: Colors.blue.shade50,
                        child: const Text(
                          'ConnectionState.active',
                          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  );
                }

                // Trường hợp dự phòng mặc định
                return const Text('Không có dữ liệu');
              },
            ),

            const SizedBox(height: 50),
            // Nút hỗ trợ bạn Khởi động lại (Restart) để dễ dàng kiểm tra lại hiệu ứng
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _countdownStream = _createCountdownStream();
                });
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Chạy lại mô phỏng'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade200,
                foregroundColor: Colors.black87,
              ),
            )
          ],
        ),
      ),
    );
  }
}
