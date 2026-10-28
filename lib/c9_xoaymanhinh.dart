// main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Bắt buộc phải có để điều khiển xoay màn hình
import 'apptheme.dart';

void main() async {
  // Khởi tạo dịch vụ hệ thống của Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // Mặc định ban đầu cho phép xoay tự do để người dùng trải nghiệm
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppTheme appTheme = AppTheme();

  @override
  void initState() {
    super.initState();
    appTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    appTheme.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xoay Màn Hình Demo',
      debugShowCheckedModeBanner: false,
      theme: appTheme.lightTheme,
      darkTheme: appTheme.darkTheme,
      themeMode: appTheme.currentTheme,
      home: HomeScreen(appTheme: appTheme),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final AppTheme appTheme;

  const HomeScreen({super.key, required this.appTheme});

  // Hàm xử lý thay đổi hướng màn hình dựa trên nút bấm
  void _changeOrientation(List<DeviceOrientation> orientations) {
    SystemChrome.setPreferredOrientations(orientations);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = appTheme.currentTheme == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Điều Khiển Xoay Màn Hình'),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.lightbulb : Icons.lightbulb_outline),
            onPressed: () => appTheme.toggleTheme(),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            // Sử dụng SingleChildScrollView để tránh lỗi tràn màn hình khi xoay các hướng
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.screen_rotation, size: 60),
                  const SizedBox(height: 15),
                  Text(
                    'Nhấn nút để đổi hướng màn hình',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),

                  // Khu vực chứa các nút lệnh điều khiển hướng xoay
                  Wrap(
                    spacing: 15,
                    runSpacing: 15,
                    alignment: WrapAlignment.center,
                    children: [
                      // Nút 1: Khóa màn hình dọc thuận
                      ElevatedButton.icon(
                        icon: const Icon(Icons.stay_current_portrait),
                        label: const Text('Khóa Màn Hình Dọc'),
                        onPressed: () {
                          _changeOrientation([DeviceOrientation.portraitUp]);
                        },
                      ),

                      // Nút 2: Khóa màn hình ngang (Cho phép cả trái và phải)
                      ElevatedButton.icon(
                        icon: const Icon(Icons.stay_current_landscape),
                        label: const Text('Khóa Màn Hình Ngang'),
                        onPressed: () {
                          _changeOrientation([
                            DeviceOrientation.landscapeLeft,
                            DeviceOrientation.landscapeRight,
                          ]);
                        },
                      ),

                      // Nút 3: Chỉ khóa quay sang Ngang Trái
                      ElevatedButton.icon(
                        icon: const Icon(Icons.rotate_left),
                        label: const Text('Ngang Sang Trái'),
                        onPressed: () {
                          _changeOrientation([DeviceOrientation.landscapeLeft]);
                        },
                      ),

                      // Nút 4: Chỉ khóa quay sang Ngang Phải
                      ElevatedButton.icon(
                        icon: const Icon(Icons.rotate_right),
                        label: const Text('Ngang Sang Phải'),
                        onPressed: () {
                          _changeOrientation([DeviceOrientation.landscapeRight]);
                        },
                      ),

                      // Nút 5: Tháo khóa - Cho phép tự động xoay theo cảm biến của máy
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                        icon: const Icon(Icons.screen_rotation_alt),
                        label: const Text('Tự Động Theo Máy'),
                        onPressed: () {
                          _changeOrientation([
                            DeviceOrientation.portraitUp,
                            DeviceOrientation.landscapeLeft,
                            DeviceOrientation.landscapeRight,
                          ]);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
