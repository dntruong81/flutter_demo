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
      title: 'Theme primarySwatch Demo',

      // CẤU HÌNH THEME SỬ DỤNG PRIMARYSWATCH TRUYỀN THỐNG
      theme: ThemeData(
        useMaterial3: false, // Tắt Material 3 để Widget ăn màu primarySwatch chuẩn nhất
        primarySwatch: Colors.indigo, // Sử dụng bộ màu Xanh chàm làm chủ đạo
      ),

      home: const MainThemeScreen(),
    );
  }
}

class MainThemeScreen extends StatefulWidget {
  const MainThemeScreen({super.key});

  @override
  State<MainThemeScreen> createState() => _MainThemeScreenState();
}

class _MainThemeScreenState extends State<MainThemeScreen> {
  double _sliderValue = 40.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. AppBar tự động lấy sắc độ mặc định (Màu Indigo) làm màu nền
      appBar: AppBar(
        title: const Text('Ứng dụng dùng primarySwatch'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Tất cả thành phần bên dưới đều đồng bộ theo Colors.indigo nhờ primarySwatch:',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),

            // 2. Slider tự động nhận màu Indigo cho thanh chạy và nút kéo
            Row(
              children: [
                const Icon(Icons.volume_down, color: Colors.grey),
                Expanded(
                  child: Slider(
                    value: _sliderValue,
                    min: 0,
                    max: 100,
                    onChanged: (value) {
                      setState(() {
                        _sliderValue = value;
                      });
                    },
                  ),
                ),
                const Icon(Icons.volume_up, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 40),

            // 3. ElevatedButton tự động lấy màu nền là Indigo, chữ màu trắng
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.check_circle),
              label: const Text('Nút bấm ElevatedButton'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
