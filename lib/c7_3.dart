import 'package:flutter/material.dart';

// 1. LỚP DỊCH VỤ CUNG CẤP DỮ LIỆU (DEPENDENCY)
class ApiService {
  // Giả lập hàm gọi API lấy tên người dùng từ máy chủ
  String fetchUserName() {
    return "Nguyễn Văn A";
  }

  // Giả lập hàm lấy email người dùng
  String fetchUserEmail() {
    return "nguyenvana@email.com";
  }
}

// 2. WIDGET SỬ DỤNG DI QUA CONSTRUCTOR
class UserProfileWidget extends StatelessWidget {
  // Khai báo biến chứa dịch vụ
  final ApiService apiService;

  // TIÊM PHỤ THUỘC (DI): Truyền ApiService từ bên ngoài vào qua Constructor ở đây
  const UserProfileWidget({
    super.key,
    required this.apiService,
  });

  @override
  Widget build(BuildContext context) {
    // Sử dụng dữ liệu từ phụ thuộc được tiêm vào
    final userName = apiService.fetchUserName();
    final userEmail = apiService.fetchUserEmail();

    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 40,
              child: Icon(Icons.person, size: 40),
            ),
            const SizedBox(height: 16),
            Text(
              userName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              userEmail,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

// 3. GỐC ỨNG DỤNG - NƠI KHỞI TẠO VÀ TIÊM PHỤ THUỘC
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Khởi tạo dịch vụ ở cấp cao hơn (bên ngoài Widget sử dụng)
    final sharedApiService = ApiService();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Minh họa Dependency Injection'),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          // TIÊM PHỤ THUỘC: Truyền thực thể sharedApiService vào trong widget con
          child: UserProfileWidget(apiService: sharedApiService),
        ),
      ),
    );
  }
}
