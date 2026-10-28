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
      title: 'Demo Search Bar',
      theme: ThemeData(useMaterial3: true, primarySwatch: Colors.blue),
      home: const SearchBarDemoScreen(),
    );
  }
}

class SearchBarDemoScreen extends StatefulWidget {
  const SearchBarDemoScreen({super.key});

  @override
  State<SearchBarDemoScreen> createState() => _SearchBarDemoScreenState();
}

class _SearchBarDemoScreenState extends State<SearchBarDemoScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh tìm kiếm co giãn'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.grey.shade100,
        child: Column(
          children: [
            // ================= THANH TÌM KIẾM CHÍNH =================
            Row(
              children: [
                // 1. Bọc ô gõ từ khóa vào Expanded để nó tự động chiếm toàn bộ chiều ngang còn lại
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Nhập từ khóa cần tìm...',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                ),

                // Khoảng cách nhỏ giữa ô nhập dữ liệu và nút bấm
                const SizedBox(width: 10),

                // 2. Nút bấm nhỏ nằm gọn ở góc phải màn hình
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // Hành động khi nhấn nút bấm
                    final keyword = _searchController.text;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Đang tìm kiếm: "$keyword"')),
                    );
                  },
                  child: const Text(
                    'Tìm',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
