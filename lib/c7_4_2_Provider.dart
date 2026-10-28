import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 1. LỚP API MÔ PHỎNG (DEPENDENCY)
class Api {
  Future<String> checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 5)); // Giả lập chờ mạng
    return "I am logged in";
  }
}

// 2. LỚP QUẢN LÝ TRẠNG THÁI (HOMEMODEL) - DI QUA CONSTRUCTOR
class HomeModel extends ChangeNotifier {
  final Api _api;
  String loginStatus = "Chưa đăng nhập";

  // Tiêm phụ thuộc Api từ bên ngoài vào đây
  HomeModel(this._api);

  Future<void> login() async {
    loginStatus = "Đang kiểm tra...";
    notifyListeners();

    // Gọi hàm từ thực thể Api được tiêm vào
    loginStatus = await _api.checkLoginStatus();
    notifyListeners();
  }
}

// 3. GỐC ỨNG DỤNG - KHỞI TẠO VÀ TIÊM PHỤ THUỘC TƯỜNG MINH
void main() {
  final apiService = Api(); // Tạo phụ thuộc bên ngoài

  runApp(
    ChangeNotifierProvider<HomeModel>(
      create: (context) {
        final model = HomeModel(apiService); // Tiêm vào model
        return model;
      },
      child: const MaterialApp(home: LoginScreen()),
    ),
  );
}

// 4. GIAO DIỆN ĐƠN GIẢN
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng Nhập Đơn Giản')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextField(decoration: InputDecoration(labelText: 'Username')),
            const TextField(decoration: InputDecoration(labelText: 'Password')),
            const SizedBox(height: 20),

            // Nút nhấn gọi hàm đăng nhập
            ElevatedButton(
              onPressed: () => context.read<HomeModel>().login(), //cú pháp hiện đại và gọn gàng trong thư viện Provider dùng để lấy dữ liệu hoặc gọi hàm từ một Model kiểu T mà không lắng nghe sự thay đổi
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),

            // Hiển thị kết quả trạng thái từ Model
            Consumer<HomeModel>(
              builder: (context, model, child) => Text(
                model.loginStatus,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
