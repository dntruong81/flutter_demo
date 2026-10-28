import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductPage(),
    );
  }
}

// 1. Định nghĩa cấu trúc dữ liệu Sản phẩm
class Product {
  final String id;
  final String name;
  final double price;
  int quantity; // Số lượng mặc định ban đầu là 0 (chưa mua)

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.quantity = 0,
  });
}

// 2. Widget Trang Sản Phẩm (Quản lý trạng thái chính)
class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  // Danh sách sản phẩm mẫu (số lượng ban đầu = 0)
  final List<Product> _products = [
    Product(id: '1', name: 'Điện thoại iPhone 15', price: 1000),
    Product(id: '2', name: 'Tai nghe AirPods Pro', price: 250),
    Product(id: '3', name: 'Ốp lưng sạc MagSafe', price: 50),
  ];

  // Hàm tính tổng tiền dựa trên các sản phẩm có quantity > 0
  double get _totalPrice {
    return _products.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  // Hàm tăng số lượng (hoặc chuyển từ nút Mua thành số lượng = 1)
  void _increaseQuantity(int index) {
    setState(() {
      _products[index].quantity++;
    });
  }

  // Hàm giảm số lượng (nếu giảm về 0 sẽ ẩn bộ tăng giảm và hiện lại nút Mua)
  void _decreaseQuantity(int index) {
    setState(() {
      if (_products[index].quantity > 0) {
        _products[index].quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tổng giỏ hàng: \$${_totalPrice.toStringAsFixed(2)}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final item = _products[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Giá: \$${item.price}'),

              // Sử dụng toán tử điều kiện để hoán đổi UI nút bấm
              trailing: item.quantity == 0
                  ? // TRẠNG THÁI 1: Chưa mua -> Hiển thị nút "Mua"
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => _increaseQuantity(index),
                child: const Text('Mua'),
              )
                  : // TRẠNG THÁI 2: Đã thêm vào giỏ -> Hiển thị bộ tăng giảm (- / số lượng / +)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Nút giảm (-)
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                    onPressed: () => _decreaseQuantity(index),
                  ),
                  // Hiển thị số lượng
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      '${item.quantity}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // Nút tăng (+)
                  IconButton(
                    icon: const Icon(Icons.add_circle, color: Colors.teal),
                    onPressed: () => _increaseQuantity(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
