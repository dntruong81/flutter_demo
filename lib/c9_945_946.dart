import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ResponsiveProductScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ResponsiveProductScreen extends StatelessWidget {
  const ResponsiveProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Tạo danh sách 20 sản phẩm giả lập để hiển thị
    final List<String> products = List.generate(20, (index) => 'Sản phẩm ${index + 1}');
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp
    ]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Giao diện Xoay Màn Hình'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      // 1. Sử dụng OrientationBuilder để bắt sự kiện xoay màn hình
      body: OrientationBuilder(
        builder: (context, orientation) {
          // 2. Tự động tính toán số cột dựa trên trạng thái xoay
          // Xoay đứng (portrait) = 2 cột | Xoay ngang (landscape) = 3 cột
          final int columnCount = orientation == Orientation.portrait ? 2 : 3;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Thanh thông báo trạng thái xoay hiện tại
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.teal.withOpacity(0.1),
                  child: Text(
                    'Trạng thái: ${orientation == Orientation.portrait ? "Xoay Đứng (2 cột)" : "Xoay Ngang (3 cột)"}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
                  ),
                ),
                const SizedBox(height: 8),

                // 3. Hiển thị danh sách sản phẩm dạng lưới
                Expanded(
                  child: GridView.builder(
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columnCount, // Áp dụng số cột đã tính toán ở trên
                      crossAxisSpacing: 8.0,      // Khoảng cách giữa các cột
                      mainAxisSpacing: 8.0,       // Khoảng cách giữa các hàng
                      childAspectRatio: 0.8,      // Tỷ lệ khung hình của ô sản phẩm
                    ),
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 3,
                        color: Colors.amber.shade100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.shopping_bag, size: 50, color: Colors.teal),
                            const SizedBox(height: 10),
                            Text(
                              products[index],
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const Text('100.000 đ', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
