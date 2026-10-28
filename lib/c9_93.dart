import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // 1. BẮT BUỘC: Thư viện điều khiển phần cứng hệ thống

void main() {
  // 2. BẮT BUỘC: Đảm bảo các dịch vụ nền của Flutter được khởi tạo xong trước khi khóa màn hình
  WidgetsFlutterBinding.ensureInitialized();

  // 3. THỰC HIỆN KHÓA MÀN HÌNH XOAY NGANG (Landscape Left & Right)
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) {
    // Chỉ chạy ứng dụng sau khi hệ thống đã xác nhận thiết lập hướng màn hình thành công
    runApp(const RacingGameApp());
  });
}

class RacingGameApp extends StatelessWidget {
  const RacingGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Stack(
        children: [
          // Giả lập đường đua góc nhìn ngang
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.directions_car, size: 100, color: Colors.redAccent),
                const SizedBox(height: 20),
                Text(
                  'GAME ĐUA XE CHẾ ĐỘ MÀN HÌNH NGANG',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    shadows: [Shadow(color: Colors.black.withOpacity(0.5), offset: const Offset(2, 2), blurRadius: 4)],
                  ),
                ),
              ],
            ),
          ),
          // Bảng tốc độ góc màn hình
          Positioned(
            bottom: 20,
            right: 30,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.redAccent),
              ),
              child: const Text(
                'TỐC ĐỘ: 180 KM/H',
                style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }
}
