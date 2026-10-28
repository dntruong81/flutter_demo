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
  // 1. Khai báo biến Future để lưu giữ trạng thái
  late Future<String> _timeFuture;

  @override
  void initState() {
    super.initState();
    // 2. Chỉ gọi hàm fetchTime() DUY NHẤT một lần tại đây khi khởi tạo màn hình
    _timeFuture = fetchTime();
  }

  // Giả lập hàm lấy thời gian từ Internet mất 2.5 giây
  Future<String> fetchTime() async {
    await Future.delayed(const Duration(milliseconds: 2500));
    final now = DateTime.now();
    return 'Bây giờ là: ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
  }

  // Hàm xử lý khi người dùng chủ động nhấn nút cập nhật
  void _handleRefresh() {
    setState(() {
      // Đè một Future mới lên biến cũ để ép FutureBuilder kích hoạt trạng thái loading và nạp lại data
      _timeFuture = fetchTime();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FutureBuilder Lifecycle Demo'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 3. Truyền biến đã lưu trữ vào FutureBuilder thay vì gọi trực tiếp hàm
            FutureBuilder<String>(
              future: _timeFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(color: Colors.indigo);
                }
                // Kiểm tra xem dữ liệu bất đồng bộ đã về tới nơi chưa
                if (snapshot.hasData) {
                  return Card(
                    color: Colors.indigo.shade50,
                    margin: const EdgeInsets.all(20),
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
                  // Trong khi chờ đợi 2.5 giây, hiển thị vòng xoay nạp dữ liệu
                  return const CircularProgressIndicator(color: Colors.indigo);
                }
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _handleRefresh,
              icon: const Icon(Icons.refresh),
              label: const Text('Thử nhấn Rebuild giao diện'),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Lưu ý: Nhấn nút trên giao diện sẽ vẽ lại (rebuild)!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            )
          ],
        ),
      ),
    );
  }
}
