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
      home: ShoppingListScreen(),
    );
  }
}

// 1. ĐÂY LÀ STATELESSWIDGET
// Màn hình hiển thị tiêu đề tĩnh, không tự thay đổi dữ liệu bên trong chính nó
class ShoppingListScreen extends StatelessWidget {
  const ShoppingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ứng dụng mua sắm'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ô văn bản hiển thị tiêu đề cố định - Bản chất của StatelessWidget
            const Text(
              'Danh sách mua sắm',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),

            // Các ô Checkbox mua hàng bên dưới (Tách biệt trạng thái)
            const ShoppingItemCheckbox(itemName: 'Mua sữa bò tươi'),
            const ShoppingItemCheckbox(itemName: 'Mua bánh mì'),
            const ShoppingItemCheckbox(itemName: 'Mua trứng gà'),
          ],
        ),
      ),
    );
  }
}

// 2. ĐÂY LÀ STATEFULWIDGET
// Mỗi dòng Checkbox cần lưu giữ trạng thái riêng (Đã chọn hay chưa chọn)
class ShoppingItemCheckbox extends StatefulWidget {
  final String itemName;

  const ShoppingItemCheckbox({super.key, required this.itemName});

  @override
  State<ShoppingItemCheckbox> createState() => _ShoppingItemCheckboxState();
}

class _ShoppingItemCheckboxState extends State<ShoppingItemCheckbox> {
  // Biến lưu trạng thái: false = ô rỗng, true = dấu tích xanh
  bool _isLight = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        widget.itemName,
        style: TextStyle(
          // Hiệu ứng gạch ngang chữ nếu mặt hàng đã được tích chọn mua
          decoration: _isLight ? TextDecoration.lineThrough : TextDecoration.none,
          color: _isLight ? Colors.grey : Colors.black,
        ),
      ),
      value: _isLight,
      activeColor: Colors.green, // Màu xanh khi được tích chọn
      controlAffinity: ListTileControlAffinity.leading, // Đẩy ô checkbox ra trước chữ
      onChanged: (bool? newValue) {
        // Hàm setState bắt buộc phải gọi để Flutter vẽ lại giao diện từ ô rỗng sang tích xanh
        setState(() {
          _isLight = newValue ?? false;
        });
      },
    );
  }
}
