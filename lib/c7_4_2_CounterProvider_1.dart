// Minh hoạ cho: context.watch<T>();

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ==========================================
// 1. STATE MANAGEMENT (PROVIDER LOGIC)
// ==========================================
class CounterProvider extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners(); // Thông báo để toàn bộ nơi chứa context.watch vẽ lại
  }
}

// ==========================================
// 2. MAIN APPLICATION GỐC
// ==========================================
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CounterProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

// ==========================================
// 3. USER INTERFACE (GIAO DIỆN MÀN HÌNH)
// ==========================================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sử dụng context.watch ở đây.
    // Mỗi khi notifyListeners() được gọi, TOÀN BỘ HomeScreen sẽ rebuild.
    final counter = context.watch<CounterProvider>();
    print('Rebuild HomeScreen');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ví dụ Provider với context.watch'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bạn đã bấm nút này số lần là:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              '${counter.count}', // Lấy dữ liệu trực tiếp từ biến counter
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // Vì đã lắng nghe ở trên rồi, nút bấm chỉ cần gọi hàm qua context.read để kích hoạt sự kiện
        onPressed: () => context.read<CounterProvider>().increment(),
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
