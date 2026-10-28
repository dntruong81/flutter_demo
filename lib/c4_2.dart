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
      title: 'Phân biệt Image Asset và Network',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ImageDemoScreen(),
    );
  }
}

class ImageDemoScreen extends StatefulWidget {
  const ImageDemoScreen({super.key});

  @override
  State<ImageDemoScreen> createState() => _ImageDemoScreenState();
}

class _ImageDemoScreenState extends State<ImageDemoScreen> {
  // Đường link banner quảng cáo động (có thể thay đổi qua State)
  String _bannerUrl = 'https://picsum.photos/id/237/200/300';
  int _counter = 0;

  // Hàm mô phỏng việc đổi quảng cáo mới từ Máy chủ
  void _changeAdBanner() {
    setState(() {
      _counter++;
      // Thay đổi ID ảnh để lấy một ảnh ngẫu nhiên khác từ Internet
      _bannerUrl = 'https://picsum.photos/id/${237 + _counter}/200/300';
      print(_bannerUrl);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Asset vs Network Image'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- PHẦN 1: IMAGE.ASSET (LOGO CỐ ĐỊNH) ---
            const Card(
              color: Colors.blue,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '1. Image.asset: Tải từ tệp APK/IPA (Offline / Tốc độ ngay lập tức)',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                // Nạp từ bộ nhớ máy, ứng dụng chạy là có ngay, không lo mất mạng
                child: Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Text('Chưa bỏ ảnh\nlogo.png vào\nthư mục assets',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: Colors.red),
                      ),
                    );
                  },
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Center(child: Text('Logo ứng dụng cố định', style: TextStyle(fontStyle: FontStyle.italic))),
            ),

            const SizedBox(height: 32),

            // --- PHẦN 2: IMAGE.NETWORK (BANNER QUẢNG CÁO ĐỘNG) ---
            const Card(
              color: Colors.green,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '2. Image.network: Tải từ Cloud/Server (Cần mạng / Thay đổi linh hoạt)',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              // Nạp từ URL Internet, hiển thị vòng xoay tải dữ liệu (loading) trong lúc chờ
              child: Image.network(
                _bannerUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(), // Vòng xoay chờ tải ảnh từ mạng
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(Icons.signal_wifi_connected_no_internet_4, color: Colors.red, size: 48),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: ElevatedButton.icon(
                onPressed: _changeAdBanner,
                icon: const Icon(Icons.refresh),
                label: const Text('Đổi banner quảng cáo mới'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
