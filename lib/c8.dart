import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mô phỏng E-Commerce',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      // 1. ĐỊNH TUYẾN (ROUTING): Khai báo bản đồ đường đi trước khi app chạy
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/product-detail': (context) => const ProductDetailScreen(),
      },
    );
  }
}

/// MÀN HÌNH DANH SÁCH SẢN PHẨM (TRANG CHỦ)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cửa hàng Trực tuyến')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            elevation: 4,
            child: ListTile(
              leading: const Icon(Icons.phone_iphone, size: 40, color: Colors.blue),
              title: const Text('iPhone 15 Pro Max', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('Giá: 29.990.000 đ'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              // 2. ĐIỀU HƯỚNG (NAVIGATION): Hành động "lái xe" chuyển tiếp sang trang mới khi bấm vào sản phẩm
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/product-detail',
                  arguments: 'iPhone 15 Pro Max', // Truyền tên sản phẩm qua trang chi tiết
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// MÀN HÌNH CHI TIẾT SẢN PHẨM (XỬ LÝ CONTROLLER & CUỘN TRANG)
class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  // Khởi tạo các Bộ điều khiển theo yêu cầu
  final TextEditingController _quantityController = TextEditingController(text: "1");
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    // Luôn luôn hủy các controller khi rời màn hình để tránh rò rỉ bộ nhớ (Memory Leak)
    _quantityController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // Hàm mô phỏng cuộn nhanh xuống danh sách đánh giá
  void _scrollToReviews() {
    _scrollController.animateTo(
      400.0, // Khoảng cách cuộn xuống (pixels)
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Nhận dữ liệu tên sản phẩm được truyền từ màn hình trước
    final productName = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết sản phẩm'),
        // Tự động có nút quay lại nhờ cơ chế Stack của Navigator (Navigation - Quay trở lại)
      ),
      body: SingleChildScrollView(
        controller: _scrollController, // Gắn ScrollController vào khung cuộn của trang
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hình ảnh sản phẩm mô phỏng
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey[200],
              child: const Icon(Icons.image, size: 80, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Text(productName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const Text('29.990.000 đ', style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.w600)),
            const SizedBox(height: 20),

            // Khu vực nhập số lượng qua TextEditingController
            Row(
              children: [
                const Text('Số lượng: ', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 10),
                SizedBox(
                  width: 80,
                  child: TextField(
                    controller: _quantityController, // Gắn bộ điều khiển text
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Nút bấm tương tác tiện ích
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Đã thêm ${_quantityController.text} sản phẩm vào giỏ hàng!')),
                    );
                  },
                  icon: const Icon(Icons.add_shopping_cart),
                  label: const Text('Mua ngay'),
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  onPressed: _scrollToReviews, // Kích hoạt lệnh cuộn tự động khi nhấn
                  icon: const Icon(Icons.comment),
                  label: const Text('Xem đánh giá'),
                ),
              ],
            ),
            const SizedBox(height: 150), // Tạo khoảng trống lớn để thử nghiệm tính năng cuộn

            // Khu vực Đánh giá sản phẩm (Nơi ScrollController hướng tới)
            const Divider(thickness: 2),
            const Text('Đánh giá từ khách hàng (120)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildReviewItem('Nguyễn Văn A', 'Điện thoại dùng rất mượt, giao hàng nhanh chóng! 5 sao.'),
            _buildReviewItem('Trần Thị B', 'Máy đẹp, chụp ảnh nét căng. Rất đáng tiền.'),
            _buildReviewItem('Lê Văn C', 'Pin trâu, chơi game không bị nóng máy.'),
            const SizedBox(height: 100), // Khoảng trống dưới cùng
          ],
        ),
      ),
    );
  }

  // Hàm phụ tạo giao diện từng dòng đánh giá
  Widget _buildReviewItem(String name, String comment) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.account_circle, size: 24, color: Colors.grey),
              const SizedBox(width: 8),
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left:32.0),
            child: Text(comment, style: TextStyle(color: Colors.grey[700])),
          ),
        ],
      ),
    );
  }
}
