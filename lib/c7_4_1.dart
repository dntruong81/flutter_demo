import 'package:flutter/material.dart';

// 1. KHỞI TẠO INHERITEDWIDGET ĐỂ CHỨA DỮ LIỆU VÀ PHƯƠNG THỨC CẬP NHẬT
class InheritedHomeWidget extends InheritedWidget {
  final String appBarText;
  final String bodyText;
  final VoidCallback onUpdateData; // 👈 Thêm callback để widget con kích hoạt hàm cập nhật ở widget cha

  const InheritedHomeWidget({
    super.key,
    required this.appBarText,
    required this.bodyText,
    required this.onUpdateData,
    required super.child,
  });

  static InheritedHomeWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedHomeWidget>();
  }

  @override
  bool updateShouldNotify(InheritedHomeWidget oldWidget) {
    // Rebuild lại các widget con nếu một trong các giá trị text thay đổi
    return oldWidget.appBarText != appBarText || oldWidget.bodyText != bodyText;
  }
}

// 2. STATEFULWIDGET ĐÓNG VAI TRÒ QUẢN LÝ TRẠNG THÁI VÀ CUNG CẤP CHO INHERITEDWIDGET
class StateContainer extends StatefulWidget {
  final Widget child;

  const StateContainer({super.key, required this.child});

  @override
  State<StateContainer> createState() => _StateContainerState();
}

class _StateContainerState extends State<StateContainer> {
  // Trạng thái ban đầu theo yêu cầu
  String _appBarText = "Dependency Injection Text";
  String _bodyText = "Dependency Injection Demo";

  // Hàm xử lý cập nhật thay đổi dữ liệu
  void _updateText() {
    setState(() {
      _appBarText = "AppBar mang dòng chữ MỚI 🚀";
      _bodyText = "Thân trang hiển thị dữ liệu đã ĐỔI 🎉";
    });
  }

  @override
  Widget build(BuildContext context) {
    // Bọc dữ liệu động của State vào InheritedWidget
    return InheritedHomeWidget(
      appBarText: _appBarText,
      bodyText: _bodyText,
      onUpdateData: _updateText,
      child: widget.child,
    );
  }
}

// 3. GỐC ỨNG DỤNG
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Khởi tạo StateContainer ở gốc để quản lý và chia sẻ trạng thái cho toàn bộ cây widget
    return StateContainer(
      child: const MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}

// 4. MÀN HÌNH CHÍNH (ĐỌC VÀ THAY ĐỔI DỮ LIỆU)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Đi tìm kho chứa dữ liệu InheritedHomeWidget gần nhất ở phía trên cây widget
    final inheritedData = InheritedHomeWidget.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(inheritedData?.appBarText ?? "Default Title"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              inheritedData?.bodyText ?? "Default Body",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                // Kích hoạt hàm cập nhật được tiêm từ InheritedWidget
                inheritedData?.onUpdateData();
              },
              icon: const Icon(Icons.refresh),
              label: const Text("CẬP NHẬT DỮ LIỆU", style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
