import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TimeDemoScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TimeDemoScreen extends StatefulWidget {
  const TimeDemoScreen({super.key});

  @override
  State<TimeDemoScreen> createState() => _TimeDemoScreenState();
}

class _TimeDemoScreenState extends State<TimeDemoScreen> {
  late Future<String> _timeFuture;

  @override
  void initState() {
    super.initState();
    // Chạy lần đầu tiên khi mở ứng dụng
    _timeFuture = fetchTime();
  }

  // Giả lập hàm lấy thời gian từ Internet mất 2.5 giây
  Future<String> fetchTime() async {
    await Future.delayed(const Duration(milliseconds: 2500));
    final now = DateTime.now();
    return 'Bây giờ là: ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
  }

  // Hàm xử lý cập nhật lại thời gian thực
  void _handleRefresh() {
    setState(() {
      // Đè một Future mới để kích hoạt lại chu trình: waiting -> done
      _timeFuture = fetchTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FutureBuilder State Fix'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<String>(
              future: _timeFuture,
              builder: (context, snapshot) {

                // 🌟 BƯỚC 1: Nếu trạng thái đang là WAITING, ép buộc hiển thị vòng xoay
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Column(
                    children: [
                      CircularProgressIndicator(color: Colors.indigo),
                      SizedBox(height: 15),
                      Text('Đang nạp lại dữ liệu thực tế...', style: TextStyle(color: Colors.grey)),
                    ],
                  );
                }

                // 🌟 BƯỚC 2: Khi connectionState chuyển sang DONE và có dữ liệu
                if (snapshot.hasData) {
                  return Card(
                    color: Colors.indigo.shade50,
                    margin: const EdgeInsets.all(20),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                        snapshot.data!,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.indigo),
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Đã xảy ra lỗi: ${snapshot.error}');
                } else {
                  return const Text('Không có dữ liệu');
                }
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _handleRefresh,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              icon: const Icon(Icons.sync),
              label: const Text('Cập nhật lại thời gian', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
