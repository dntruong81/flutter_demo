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
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Chi tiết sản phẩm'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: ProductPriceWidget(),
        ),
      ),
    );
  }
}

class ProductPriceWidget extends StatelessWidget {
  const ProductPriceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline, // Giúp các chữ căn đều chân dòng với nhau
      textBaseline: TextBaseline.alphabetic,
      children: const [
        // 1. Hiển thị Giá giảm (Giá bán hiện tại) - Làm nổi bật bằng màu đỏ và chữ to
        Text(
          '80.000đ',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        SizedBox(width: 12), // Tạo khoảng cách nhỏ giữa giá giảm và giá gốc

        // 2. Hiển thị Giá gốc - Làm mờ đi và thêm hiệu ứng gạch ngang (lineThrough)
        Text(
          '100.000đ',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
            decoration: TextDecoration.lineThrough, // Tạo đường gạch ngang chữ
          ),
        ),
      ],
    );
  }
}
