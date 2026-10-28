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
      home: CameraAppHomeScreen(),
    );
  }
}

// Cần sử dụng StatefulWidget để cập nhật giao diện khi chuyển đổi qua lại giữa các Tab
class CameraAppHomeScreen extends StatefulWidget {
  const CameraAppHomeScreen({super.key});

  @override
  State<CameraAppHomeScreen> createState() => _CameraAppHomeScreenState();
}

class _CameraAppHomeScreenState extends State<CameraAppHomeScreen> {
  // Biến lưu trữ vị trí mục đang được chọn (Mặc định là mục 0 - Home)
  int _selectedIndex = 0;

  // Danh sách các màn hình tương ứng với từng mục trên thanh điều hướng
  final List<Widget> _screens = [
    const Center(child: Text('Màn hình Trang chủ (Home)', style: TextStyle(fontSize: 20))),
    const Center(child: Text('Màn hình Tìm kiếm (Search)', style: TextStyle(fontSize: 20))),
    const Center(child: Text('Giao diện Máy ảnh (Take Photo)', style: TextStyle(fontSize: 20))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera App'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),

      // Hiển thị nội dung màn hình dựa vào mục được chọn
      body: _screens[_selectedIndex],

      // --- THIẾT KẾ THANH ĐIỀU HƯỚNG BÊN DƯỚI ---
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Mục hiện tại đang sáng lên
        selectedItemColor: Colors.teal, // Màu của mục khi được nhấn chọn
        unselectedItemColor: Colors.grey, // Màu của các mục còn lại

        // Cập nhật lại chỉ số khi người dùng chạm vào một mục khác
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },

        // Danh sách 3 mục điều hướng theo thiết kế của bạn
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt), // Đổi thành camera_alt cho giống máy ảnh thực tế hơn
            label: 'Take Photo',
          ),
        ],
      ),
    );
  }
}
