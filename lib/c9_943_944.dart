import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ResponsiveFittedBoxDemo(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ResponsiveFittedBoxDemo extends StatelessWidget {
  const ResponsiveFittedBoxDemo({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Lấy kích thước toàn màn hình (Logical Pixels)
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;

    // 2. Tính kích thước ô màu đỏ theo tỷ lệ cố định
    final double containerWidth = deviceWidth * 0.5;
    final double containerHeight = deviceHeight * 0.25;

    return Scaffold(
      appBar: AppBar(
        title: const Text('FittedBox & Responsive UI'),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Thông số thiết bị để tiện theo dõi
            Text(
              'Thiết bị: ${deviceWidth.toStringAsFixed(0)}lp x ${deviceHeight.toStringAsFixed(0)}lp',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            // Ô màu đỏ chiếm 1/2 chiều rộng và 1/4 chiều cao màn hình
            Container(
              width: containerWidth,
              height: containerHeight,
              color: Colors.red,
              padding: const EdgeInsets.all(12.0), // Tạo khoảng đệm an toàn với mép ô

              // 3. Sử dụng FittedBox làm Widget con trực tiếp để quản lý văn bản
              child: const FittedBox(
                fit: BoxFit.scaleDown, // scaleDown: Chỉ co nhỏ lại nếu chữ quá dài, không phóng to khi chữ ngắn
                alignment: Alignment.center,

                // Dòng chữ rất dài mô phỏng tình huống dễ gây tràn viền
                child: Text(
                  'Fitted Box Container\nKhông bao giờ sợ tràn viền pixel\n vì đã dùng Fitted Box',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40, // Cài đặt cỡ chữ gốc lớn để ép FittedBox phải co lại
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
