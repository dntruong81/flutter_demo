// Minh hoạ cho:  Consumer<T>()

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
    notifyListeners(); // Báo hiệu cho các Widget dùng Consumer biết để vẽ lại
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
    // Không còn dòng context.watch ở đầu hàm build nữa!
    // Hàm build của HomeScreen lúc này chỉ chạy duy nhất 1 lần khi khởi tạo.
    print('Rebuild HomeScreen');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ví dụ Provider với Consumer'),
        backgroundColor: Colors.teal,
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

            // Sử dụng Consumer để cô lập vùng cần rebuild
            Consumer<CounterProvider>(
              builder: (context, counter, child) {
                // KHI NHẤN NÚT: Chỉ có khối lệnh return này chạy lại
                print('Rebuild chi phan Text chứa biến count');
                return Text(
                  '${counter.count}',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // Sử dụng context.read để gọi hàm. Không làm lắng nghe thay đổi nên nút bấm KHÔNG bị rebuild.
        onPressed: () => context.read<CounterProvider>().increment(),
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
