import 'package:flutter/material.dart';

void main() {
  runApp(const MultiNavApp());
}

class MultiNavApp extends StatelessWidget {
  const MultiNavApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      // Màn hình mặc định khi khởi chạy ứng dụng
      home: const FirstScreen(),
      // [ROUTING]: Đăng ký tên định tuyến để phục vụ cho pushNamed
      routes: {
        '/second': (context) => const SecondScreen(),
      },
    );
  }
}

/// 1. Màn hình thứ nhất (FirstScreen) - Chứa 2 nút bấm với 2 cách điều hướng
class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Màn Hình 1'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // NÚT 1: Sử dụng pushNamed()
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    // [NAVIGATION]: Gọi bằng tên định tuyến đã đăng ký
                    Navigator.pushNamed(context, '/second');
                  },
                  child: const Text(
                    'Go to page two with named',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // NÚT 2: Sử dụng push()
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    // [NAVIGATION]: Gọi trực tiếp thông qua MaterialPageRoute
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SecondScreen()),
                    );
                  },
                  child: const Text(
                    'Go to page two without named',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 2. Màn hình thứ hai (SecondScreen)
class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade50,
      appBar: AppBar(
        title: const Text('Màn Hình 2'),
        backgroundColor: Colors.amber.shade800,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber.shade800,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
          onPressed: () {
            // Dù đến bằng cách nào, Navigator.pop() vẫn đưa người dùng về trang 1
            Navigator.pop(context);
          },
          child: const Text('Quay về', style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}
