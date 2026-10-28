import 'package:flutter/material.dart';

void main() {
  runApp(const SimpleNavApp());
}

class SimpleNavApp extends StatelessWidget {
  const SimpleNavApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Navigation',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: const FirstScreen(),
    );
  }
}

/// 1. Màn hình thứ nhất (FirstScreen)
class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Màn Hình 1'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
          onPressed: () {
            // [NAVIGATION]: Mở màn hình mới bằng Navigator.push
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SecondScreen()),
            );
          },
          child: const Text('Mở trang 2', style: TextStyle(fontSize: 18)),
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
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: const Text('Màn Hình 2'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
          onPressed: () {
            // [NAVIGATION]: Đóng màn hình 2 để quay lại màn hình 1
            Navigator.pop(context);
          },
          child: const Text('Quay về', style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}
