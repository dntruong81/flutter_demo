import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// 1. QUẢN LÝ CHỦ ĐỀ (THEME CONTROLLER)
class ThemeController extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); // Thông báo làm mới toàn bộ app khi đổi màu nền
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeController _themeController = ThemeController();

  @override
  void initState() {
    super.initState();
    _themeController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _themeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Responsive & Theme App',
      // Cấu hình Màu sáng
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      // Cấu hình Màu tối
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey[900],
      ),
      themeMode: _themeController.themeMode, // Gắn bộ điều khiển màu vào đây
      home: ResponsiveHomePage(themeController: _themeController),
    );
  }
}

// 2. MÀN HÌNH CHÍNH TỰ ĐỘNG THÍCH ỨNG (RESPONSIVE UI)
class ResponsiveHomePage extends StatelessWidget {
  final ThemeController themeController;
  const ResponsiveHomePage({super.key, required this.themeController});

  @override
  Widget build(BuildContext context) {
    // Lấy kích thước chiều rộng màn hình hiện tại
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTabletLandscape = screenWidth > 600; // Ngưỡng phân tách Phone và Tablet

    return Scaffold(
      appBar: AppBar(
        title: Text(isTabletLandscape ? 'Giao diện Tablet (2 Cột)' : 'Giao diện Phone (1 Cột)'),
        actions: [
          IconButton(
            icon: Icon(themeController.themeMode == ThemeMode.light ? Icons.lightbulb : Icons.lightbulb_outline),
            onPressed: themeController.toggleTheme, // Nút bấm đổi tông màu Sáng/Tối
          )
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300), // Hiệu ứng mượt mà khi xoay màn hình
        child: isTabletLandscape
            ? _buildTwoColumnLayout() // Nếu màn hình rộng -> Hiện 2 cột
            : _buildOneColumnLayout(), // Nếu màn hình hẹp -> Hiện 1 cột
      ),
    );
  }

  // Giao diện 1 cột cho Điện thoại
  Widget _buildOneColumnLayout() {
    return ListView.builder(
      key: const ValueKey('OneColumn'),
      itemCount: 10,
      itemBuilder: (context, index) => _buildCardItem(index, 'Chi tiết mục $index (Xem tại màn hình mới)'),
    );
  }

  // Giao diện 2 cột cho Máy tính bảng
  Widget _buildTwoColumnLayout() {
    return Row(
      key: const ValueKey('TwoColumn'),
      children: [
        // Cột trái: Danh sách mục (Chiếm 40% chiều rộng)
        Expanded(
          flex: 4,
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) => _buildCardItem(index, null),
          ),
        ),
        const VerticalDivider(width: 1, thickness: 1),
        // Cột phải: Vùng hiển thị nội dung chi tiết (Chiếm 60% chiều rộng)
        const Expanded(
          flex: 6,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              key: ValueKey('DetailView'),
              child: Text(
                'Chọn một mục bên trái để xem nội dung chi tiết hiển thị ở đây.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Khung thiết kế ô danh sách dùng chung
  Widget _buildCardItem(int index, String? subtitle) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(child: Text('${index + 1}')),
        title: Text('Tiêu đề bài viết số $index'),
        subtitle: subtitle != null ? Text(subtitle) : const Text('Bấm để xem nhanh'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
      ),
    );
  }
}
