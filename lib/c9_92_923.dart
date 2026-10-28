// main.dart
import 'package:flutter/material.dart';
import 'apptheme.dart';

void main() {
  runApp(const MyApp());
}

// Bước 2: Chuyển MyApp thành StatefulWidget
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Khai báo đối tượng toàn cục appTheme
  final AppTheme appTheme = AppTheme();

  @override
  void initState() {
    super.initState();
    // Đăng ký Listener trong initState(): Khi appTheme gọi notifyListeners(), setState() sẽ kích hoạt lại hàm build
    appTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // Hủy lắng nghe khi widget bị hủy để tránh rò rỉ bộ nhớ (Memory Leak)
    appTheme.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Toggle Theme Demo',
      debugShowCheckedModeBanner: false,

      // Cấu hình các bộ theme từ đối tượng appTheme
      theme: appTheme.lightTheme,
      darkTheme: appTheme.darkTheme,

      // Bước 3: Cấu hình thuộc tính themeMode dựa trên getter của appTheme
      themeMode: appTheme.currentTheme,

      // Truyền đối tượng appTheme xuống HomeScreen để sử dụng nút bấm gọi hàm chuyển màu
      home: HomeScreen(appTheme: appTheme),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final AppTheme appTheme;

  const HomeScreen({super.key, required this.appTheme});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDark = appTheme.currentTheme == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ứng dụng chuyển đổi Chủ đề'),
        actions: [
          // Bước 3: Đặt một IconButton trên AppBar gọi hàm appTheme.toggleTheme()
          IconButton(
            icon: Icon(isDark ? Icons.lightbulb_outline : Icons.lightbulb),
            onPressed: () {
              appTheme.toggleTheme(); // Thay đổi giao diện sáng/tối
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isDark ? 'Chế độ Tối (Dark)' : 'Chế độ Sáng (Light)',
                style: textTheme.displayLarge,
              ),
              const SizedBox(height: 10),
              Text(
                'Ấn vào biểu tượng bóng đèn trên thanh AppBar để chuyển đổi màu sắc toàn cục ứng dụng.',
                style: textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Icon(
                isDark ? Icons.dark_mode : Icons.light_mode,
                size: 60,
                color: Theme.of(context).iconTheme.color,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Nút bấm mẫu'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
