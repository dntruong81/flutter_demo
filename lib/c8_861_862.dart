import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 1. Khai báo các Controller cần thiết
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // 2. Định nghĩa chiều cao cố định cho mỗi item trong danh sách (để tính toán mốc cuộn)
  final double _itemHeight = 80.0;

  void _handleSubmit() {
    // In dòng chữ ra Debug Console
    print(_textController.text);

    // Tính toán vị trí để cuộn đến mốc số 5 (Index = 5, tức là phần tử thứ 6)
    // Vị trí offset = index * chiều cao của mỗi item
    double targetOffset = 5 * _itemHeight;

    // Cuộn màn hình xuống vị trí đã tính toán với hiệu ứng mượt mà
    _scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 500), // Thời gian cuộn: 0.5 giây
      curve: Curves.easeInOut, // Hiệu ứng cuộn mượt lúc đầu và cuối
    );
  }

  @override
  void dispose() {
    // Hủy các controller khi widget bị hủy để tránh rò rỉ bộ nhớ
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Demo')),
      body: Column(
        children: [
          // Khu vực nhập liệu và nút bấm cố định ở phía trên
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      labelText: 'Nhập nội dung',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _handleSubmit,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),

          // Danh sách bên dưới
          Expanded(
            child: ListView.builder(
              controller: _scrollController, // Gắn scroll controller vào đây
              itemCount: 20, // Giả định danh sách có 20 phần tử để thấy rõ việc cuộn
              itemBuilder: (context, index) {
                return SizedBox(
                  height: _itemHeight, // Bắt buộc đặt chiều cao cố định
                  child: Card(
                    color: index == 5 ? Colors.amber.shade200 : null, // Tô màu mốc số 5 cho dễ nhìn
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Center(
                      child: Text(
                        'Mốc số $index',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: index == 5 ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
