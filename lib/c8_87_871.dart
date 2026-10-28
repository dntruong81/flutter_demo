import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// 1. ĐỊNH NGHĨA CUSTOM CONTROLLER TỰ CHẾ
// Lớp này quản lý biến màu sắc và logic thay đổi màu
class MyButtonController extends ChangeNotifier {
  Color buttonColor = Colors.blue; // Màu mặc định ban đầu

  // Hàm thay đổi màu sắc phát tín hiệu notifyListeners
  void changeColor(Color newColor) {
    buttonColor = newColor;
    notifyListeners(); // Lập tức phát tín hiệu cho các bên đang lắng nghe
  }
}

// 2. ỨNG DỤNG CHÍNH
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyColorButtonPage(),
    );
  }
}

// 3. MÀN HÌNH GIAO DIỆN LẮNG NGHE CONTROLLER
class MyColorButtonPage extends StatefulWidget {
  const MyColorButtonPage({super.key});

  @override
  State<MyColorButtonPage> createState() => _MyColorButtonPageState();
}

class _MyColorButtonPageState extends State<MyColorButtonPage> {
  // Khởi tạo Custom Controller của bạn
  final MyButtonController _controller = MyButtonController();

  @override
  void initState() {
    super.initState();
    // Đăng ký lắng nghe Controller: Khi controller gọi notifyListeners(),
    // hàm setState sẽ lập tức chạy để vẽ lại giao diện của màn hình này.
    _controller.addListener(_updateUI);
  }

  void _updateUI() {
    setState(() {});
  }

  @override
  void dispose() {
    // Hủy lắng nghe và giải phóng bộ nhớ của Controller
    _controller.removeListener(_updateUI);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Controller Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Nút bấm mục tiêu nhận màu từ Custom Controller
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _controller.buttonColor,
              ),
              onPressed: () {},
              child: const Text('Nút bấm mục tiêu', style: TextStyle(color: Colors.white)),
            ),

            const SizedBox(height: 50),

            // Nút bấm ra lệnh cho Custom Controller hoạt động
            ElevatedButton(
              onPressed: () {
                // Gọi hàm changeColor từ controller và truyền màu đỏ vào
                _controller.changeColor(Colors.red);
              },
              child: const Text('Bấm để gọi controller đổi màu Đỏ'),
            ),
          ],
        ),
      ),
    );
  }
}
