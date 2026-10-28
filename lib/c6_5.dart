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
      title: 'Danh Sách Sản Phẩm',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const ProductGridScreen(),
    );
  }
}

// 1. Định nghĩa cấu trúc dữ liệu cho một Sản phẩm (Product)
class Product {
  final String name;
  final double price;
  final String imageUrl;

  Product({required this.name, required this.price, required this.imageUrl});
}

// 2. Màn hình hiển thị lưới sản phẩm
class ProductGridScreen extends StatefulWidget {
  const ProductGridScreen({super.key});

  @override
  State<ProductGridScreen> createState() => _ProductGridScreenState();
}

class _ProductGridScreenState extends State<ProductGridScreen> {
  // Tạo danh sách giả lập gồm 5,000 sản phẩm
  final List<Product> _products = List.generate(
    50,
        (index) => Product(
      name: 'Sản phẩm cao cấp số ${index + 1}',
      price: (index + 1) * 15000.0,
      // Sử dụng ảnh màu ngẫu nhiên từ via.placeholder để demo minh họa mượt mà
      imageUrl: 'https://picsum.photos/id/${(index % 200) + 1}/300/300',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cửa hàng trực tuyến (${_products.length} sản phẩm)'),
        backgroundColor: Colors.amber,
        elevation: 2,
      ),
      backgroundColor: Colors.grey.shade100,

      // Sử dụng GridView.builder để tối ưu hiệu năng dạng lưới
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: _products.length, // Tổng số lượng phần tử trong lưới

        // Cấu hình số cột và khoảng cách giữa các ô
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,          // Hiển thị dạng lưới 2 cột
          crossAxisSpacing: 10,       // Khoảng cách giữa cột trái và phải
          mainAxisSpacing: 10,        // Khoảng cách giữa các hàng trên và dưới
          childAspectRatio: 0.75,     // Tỷ lệ chiều rộng / chiều cao của mỗi ô vuông vắn (ví dụ: rộng 3 phần, cao 4 phần)
        ),

        itemBuilder: (context, index) {
          final product = _products[index];

          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Hình ảnh sản phẩm (Chiếm phần lớn không gian phía trên)
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                    child: Container(
                      width: double.infinity,
                      color: Colors.grey.shade200,
                      child: Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                        // Hiển thị icon tải khi ảnh đang load để tránh giật lag hình ảnh
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(child: CircularProgressIndicator(strokeWidth: 2));
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(child: Icon(Icons.broken_image, color: Colors.grey));
                        },
                      ),
                    ),
                  ),
                ),

                // 2. Thông tin Tên và Giá (Nằm ở phía dưới ô sản phẩm)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tên sản phẩm giới hạn tối đa 2 dòng, tự động cắt chữ nếu quá dài
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      // Giá bán nổi bật với màu sắc riêng biệt
                      Text(
                        '${product.price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{3})(?=\d)'), (Match m) => '${m[1]}.')} đ',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
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
