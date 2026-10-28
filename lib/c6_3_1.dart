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
          title: const Text('Positioned Stack Demo'),
          backgroundColor: Colors.blueGrey,
          foregroundColor: Colors.white,
        ),
        body: const Center(
          child: ImageCardWithHeart(),
        ),
      ),
    );
  }
}

class ImageCardWithHeart extends StatelessWidget {
  const ImageCardWithHeart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      // Cắt bớt phần thừa nếu ảnh hoặc widget con tràn ra ngoài bo góc
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // 1. Bức ảnh nền nằm dưới cùng, chiếm toàn bộ không gian Stack
            Container(
              color: Colors.amber, // Thay thế cho Image.network hoặc Image.asset
              width: double.infinity,
              height: double.infinity,
              child: const Icon(Icons.image, size: 80, color: Colors.white60),
            ),

            // 2. Đoạn mã ghim chặt trái tim của bạn ở góc trên bên phải
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Colors.white70, // Nền mờ giúp trái tim nổi bật hơn trên ảnh
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
