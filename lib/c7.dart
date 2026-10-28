import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    // DI (Tiêm phụ thuộc) nằm ở đây: Bọc CartProvider ở gốc ứng dụng.
    // Giờ đây, bất kỳ màn hình con nào bên dưới cũng có thể truy cập vào Giỏ hàng.
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo DI & State Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ProductListScreen(),
    );
  }
}

// ================= TẦNG DỮ LIỆU & TRẠNG THÁI (STATE & DI) =================

// Định nghĩa cấu trúc 1 Sản phẩm
class Product {
  final String id;
  final String name;
  final int price;

  Product({required this.id, required this.name, required this.price});
}

// Lớp quản lý trạng thái Giỏ hàng (Cart State)
class CartProvider extends ChangeNotifier {
  // Danh sách các sản phẩm đang có trong giỏ
  final List<Product> _items = [];

  List<Product> get items => _items;

  // Thêm sản phẩm vào giỏ và thông báo giao diện cập nhật ngay lập tức
  void addToCart(Product product) {
    _items.add(product);
    notifyListeners(); // <-- Hàm kích hoạt State thay đổi tức thì trên giao diện
  }

  // Tính tổng số tiền trong giỏ
  int get totalPrice => _items.fold(0, (sum, item) => sum + item.price);
}

// ================= GIAO DIỆN MÀN HÌNH 1: DANH MỤC SẢN PHẨM =================

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Danh sách sản phẩm giả lập ngoài cửa hàng
    final List<Product> dummyProducts = [
      Product(id: '1', name: 'Điện thoại iPhone 15', price: 20000000),
      Product(id: '2', name: 'Tai nghe AirPods Pro', price: 5000000),
      Product(id: '3', name: 'Đồng hồ Apple Watch', price: 10000000),
    ];

    // Nhờ có DI, chúng ta "lấy" (inject) giỏ hàng về màn hình này để đếm số lượng
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cửa Hàng Công Nghệ'),
        backgroundColor: Colors.blue.shade100,
        actions: [
          // Nút Giỏ hàng trên thanh tiêu đề hiển thị số lượng thay đổi thời gian thực
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart, size: 28),
                onPressed: () {
                  // Chuyển sang màn hình Thanh toán
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CheckoutScreen()),
                  );
                },
              ),
              if (cart.items.isNotEmpty)
                Positioned(
                  right: 6,
                  top: 6,
                  child: CircleAvatar(
                    radius: 9,
                    backgroundColor: Colors.red,
                    child: Text(
                      '${cart.items.length}',
                      style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: ListView.builder(
        itemCount: dummyProducts.length,
        itemBuilder: (context, index) {
          final product = dummyProducts[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Giá: ${product.price.toString()} đ'),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                onPressed: () {
                  // Khi bấm: Gọi hàm thêm vào giỏ. State thay đổi lập tức, số icon giỏ hàng tăng ngay
                  cart.addToCart(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Đã thêm ${product.name} vào giỏ!'), duration: const Duration(milliseconds: 500)),
                  );
                },
                child: const Text('Thêm vào giỏ', style: TextStyle(color: Colors.black)),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ================= GIAO DIỆN MÀN HÌNH 2: THANH TOÁN (CHECKOUT) =================

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Nhờ cơ chế DI, màn hình Thanh toán cũng tự lấy được chính xác dữ liệu giỏ hàng mà không cần màn hình 1 truyền thủ công qua Constructor.
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Màn Hình Thanh Toán'),
        backgroundColor: Colors.amber.shade100,
      ),
      body: cart.items.isEmpty
          ? const Center(child: Text('Giỏ hàng trống rỗng.'))
          : Column(
        children: [
          // Hiển thị lại toàn bộ sản phẩm đã chọn
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                final item = cart.items[index];
                return ListTile(
                  leading: const Icon(Icons.check_circle, color: Colors.green),
                  title: Text(item.name),
                  trailing: Text('${item.price} đ'),
                );
              },
            ),
          ),

          // Phần hiển thị Tổng tiền được duy trì xuyên suốt
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.grey.shade200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('TỔNG TIỀN THANH TOÁN:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('${cart.totalPrice} đ', style: const TextStyle(fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
