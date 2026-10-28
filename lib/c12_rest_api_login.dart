import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Login ReqRes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}

// ================= MÀN HÌNH LOGIN =================
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Bộ điều khiển lấy dữ liệu nhập vào trực tiếp từ ô TextField giao diện
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  String _tinNhanLoi = '';

  // Hàm loginAPI xác thực tài khoản trên Server ReqRes
  Future<void> loginAPI() async {
    // 1. Đọc dữ liệu trực tiếp người dùng gõ trên màn hình giao diện
    final emailInput = _emailController.text.trim();
    final passwordInput = _passwordController.text.trim();

    // Kiểm tra nếu người dùng bỏ trống một trong hai ô nhập liệu
    if (emailInput.isEmpty || passwordInput.isEmpty) {
      setState(() {
        _tinNhanLoi = 'Vui lòng điền đầy đủ email và mật khẩu!';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _tinNhanLoi = '';
    });

    // 2. Đường dẫn Endpoint xác thực đăng nhập chuẩn của ReqRes
    final url = Uri.parse('https://reqres.in/api/login');

    try {
      // Gửi yêu cầu POST lên server kèm body dữ liệu lấy từ giao diện
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": emailInput,
          "password": passwordInput,
        }),
      );

      final data = jsonDecode(response.body);

      // 3. Nếu tài khoản hợp lệ, Server trả về statusCode == 200
      if (response.statusCode == 200) {
        String serverToken = data['token'];
       // String serverID = data['id']; Không có ID
        print('Data: \n');
       print(data);
        if (!mounted) return;
        // Đưa người dùng vào ngay màn hình FactScreen và xóa màn hình Login cũ khỏi luồng điều hướng
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => FactScreen(userEmail: emailInput, token: serverToken),
          ),
              (route) => false,
        );
      } else {
        // Nếu Server từ chối (Sai tài khoản, thiếu thông tin...) -> Trả về lỗi hệ thống
        setState(() {
          _tinNhanLoi = data['error'] ?? 'Đăng nhập không thành công!';
        });
      }
    } catch (e) {
      // Xử lý lỗi ngoại lệ nếu mất mạng hoặc sai URL cấu hình
      setState(() {
        _tinNhanLoi = "Không thể kết nối Internet hoặc lỗi hệ thống!";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Đăng Nhập Hệ Thống'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.account_circle_outlined, size: 90, color: Colors.blue.shade600),
                const SizedBox(height: 10),
                const Text(
                  'ĐĂNG NHẬP API',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),

                // Ô nhập Email
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email tài khoản test',
                    hintText: 'Ví dụ: eve.holt@reqres.in',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
                const SizedBox(height: 20),

                // Ô nhập Mật khẩu
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Mật khẩu',
                    hintText: 'Nhập mật khẩu bất kỳ',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                ),

                // Khung hiển thị thông báo lỗi màu đỏ nếu server từ chối
                if (_tinNhanLoi.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  Text(
                    _tinNhanLoi,
                    style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
                const SizedBox(height: 30),

                // Nút bấm kích hoạt Login
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : loginAPI,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                    )
                        : const Text('Login', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ================= MÀN HÌNH ĐÍCH (FACT SCREEN) =================
class FactScreen extends StatelessWidget {
  final String userEmail;
  final String token;

  const FactScreen({
    super.key,
    required this.userEmail,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fact Screen'),
        centerTitle: true,
        backgroundColor: Colors.green.shade600,
        foregroundColor: Colors.white,
        actions: [
          // Nút Đăng xuất quay về màn hình cũ
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false,
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, size: 90, color: Colors.green),
              const SizedBox(height: 20),
              const Text(
                'Xác Thực Thành Công!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              const SizedBox(height: 30),

              // Hộp hiển thị thông tin trả về
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('👤 Tài khoản: $userEmail', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const Divider(height: 20),
                      const Text('🔑 Token nhận từ Server:', style: TextStyle(fontSize: 14, color: Colors.black54)),
                      const SizedBox(height: 6),
                      Text(
                        token,
                        style: TextStyle(fontFamily: 'Courier', fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blue.shade700),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
