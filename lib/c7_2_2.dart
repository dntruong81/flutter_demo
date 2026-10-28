import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

// 1. ĐỊNH NGHĨA LỚP DỮ LIỆU SÁCH
class Book {
  final String title;
  final String author;
  final double price;

  Book({required this.title, required this.author, required this.price});
}

// 2. KHỞI TẠO SCOPED MODEL ĐỂ QUẢN LÝ TRẠNG THÁI
class CartModel extends Model {
  // Danh sách các sách đã chọn mua
  final List<Book> _cartItems = [];

  List<Book> get items => _cartItems;

  // Tính tổng tiền của giỏ hàng
  double get totalPrice => _cartItems.fold(0, (sum, item) => sum + item.price);

  // Thêm sách vào giỏ hàng và thông báo cập nhật giao diện
  void addBook(Book book) {
    _cartItems.add(book);
    notifyListeners(); // Cập nhật lại tất cả ScopedModelDescendant
  }

  // Xóa sạch giỏ hàng sau khi thanh toán
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}

// 3. HÀM MAIN VÀ CẤU HÌNH SCOPEDMODEL Ở GỐC ỨNG DỤNG
void main() {
  runApp(
    ScopedModel<CartModel>(
      model: CartModel(), // Khởi tạo model chung cho toàn bộ ứng dụng
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Store ScopedModel',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const BookDetailScreen(), // Màn hình mặc định ban đầu
    );
  }
}

// 4. MÀN HÌNH CHI TIẾT SÁCH (MÀN HÌNH CHÍNH)
class BookDetailScreen extends StatelessWidget {
  const BookDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Giả lập dữ liệu một cuốn sách chi tiết
    final sampleBook = Book(
      title: 'Lập trình Flutter toàn tập',
      author: 'Nguyễn Văn A',
      price: 150000,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi Tiết Sách'),
        actions: [
          // Nút đi tới giỏ hàng hiển thị số lượng item hiện tại
          ScopedModelDescendant<CartModel>(
            builder: (context, child, model) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CartScreen()),
                      );
                    },
                  ),
                  if (model.items.isNotEmpty)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.red,
                        child: Text(
                          '${model.items.length}',
                          style: const TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ),
                    )
                ],
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey[300],
              child: const Icon(Icons.book, size: 100, color: Colors.blue),
            ),
            const SizedBox(height: 16),
            Text(sampleBook.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Tác giả: ${sampleBook.author}', style: const TextStyle(fontSize: 18, color: Colors.grey)),
            const SizedBox(height: 8),
            Text('Giá: ${sampleBook.price.toStringAsFixed(0)} đ', style: const TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold)),
            const Spacer(),
            // Sử dụng ScopedModelDescendant để gọi hàm chọn mua từ Model
            ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
                return SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      model.addBook(sampleBook);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Đã thêm sách vào giỏ hàng!'), duration: Duration(seconds: 1)),
                      );
                    },
                    child: const Text('CHỌN MUA SÁCH', style: TextStyle(fontSize: 18)),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// 5. MÀN HÌNH GIỎ HÀNG (TỰ ĐỘNG ĐỌC DỮ LIỆU TỪ MODEL)
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Giỏ Hàng')),
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          if (model.items.isEmpty) {
            return const Center(child: Text('Giỏ hàng trống!'));
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: model.items.length,
                  itemBuilder: (context, index) {
                    final item = model.items[index];
                    return ListTile(
                      leading: const Icon(Icons.book),
                      title: Text(item.title),
                      subtitle: Text(item.author),
                      trailing: Text('${item.price.toStringAsFixed(0)} đ'),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Text('Tổng cộng: ${model.totalPrice.toStringAsFixed(0)} đ', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const CheckoutScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        child: const Text('THANH TOÁN', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

// 6. MÀN HÌNH THANH TOÁN (TỰ ĐỘNG ĐỌC DỮ LIỆU TỪ MODEL)
class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thanh Toán')),
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('HÓA ĐƠN CỦA BẠN', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Divider(),
                const SizedBox(height: 10),
                Text('Số lượng sách: ${model.items.length} cuốn', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                Text('Tổng số tiền: ${model.totalPrice.toStringAsFixed(0)} đ', style: const TextStyle(fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold)),
                const SizedBox(height: 30),
                const Text('Phương thức thanh toán: Tiền mặt khi nhận hàng (COD)', style: const TextStyle(fontStyle: FontStyle.italic)),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      model.clearCart(); // Xóa sạch giỏ hàng
                      // Hiện thông báo và quay về màn hình gốc
                      showDialog(
                        context: context,
                        barrierDismissible: false, // 👈 THÊM DÒNG NÀY: Khóa không cho nhấn ra ngoài để tắt hộp thoại
                        builder: (ctx) => AlertDialog(
                          title: const Text('Thành công'),
                          content: const Text('Bạn đã đặt mua sách thành công!'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(ctx); // Đóng Đialog
                                Navigator.popUntil(context, (route) => route.isFirst); // Quay về màn hình Chi tiết ban đầu
                              },
                              child: const Text('OK'),
                            )
                          ],
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                    child: const Text('XÁC NHẬN ĐẶT HÀNG', style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
