import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // Đảm bảo các dịch vụ hệ thống của Flutter được khởi tạo trước khi cấu hình SharedPreferences
  WidgetsFlutterBinding.ensureInitialized();

  // Đọc trạng thái đăng nhập được lưu trong thiết bị từ phiên làm việc trước
  final prefs = await SharedPreferences.getInstance();
  final bool isLogin = prefs.getBool('isLogin') ?? false;
  final String savedEmail = prefs.getString('userEmail') ?? '';
  final String savedToken = prefs.getString('token') ?? '';

  runApp(MyApp(
    isLogin: isLogin,
    savedEmail: savedEmail,
    savedToken: savedToken,
  ));
}

class MyApp extends StatelessWidget {
  final bool isLogin;
  final String savedEmail;
  final String savedToken;

  const MyApp({
    super.key,
    required this.isLogin,
    required this.savedEmail,
    required this.savedToken,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Login SharedPreferences',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // Tự động chuyển màn hình dựa trên trạng thái phiên làm việc (isLogin)
      home: isLogin
          ? FactScreen(userEmail: savedEmail, token: savedToken)
          : const LoginScreen(),
    );
  }
}

// ================= LỚP XỬ LÝ API (ApiCall) =================
class ApiCall {
  // Hàm loginAPI trả về kiểu Future<bool> kết hợp lưu phiên làm việc
  Future<bool> loginAPI(String email, String password) async {
    final url = Uri.parse('https://reqres.in/api/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final result = jsonDecode(response.body);

      // Nếu API trả về mã xác thực thành công (200) và có chuỗi Token
      if (response.statusCode == 200 && result['token'] != null) {
        // Lưu thông tin phiên vào bộ nhớ SharedPreferences của thiết bị
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLogin', true);
        await prefs.setString('userEmail', email);
        await prefs.setString('token', result['token']);

        return true;
      }
      return false;
    } catch (e) {
      debugPrint("Lỗi kết nối API: $e");
      return false;
    }
  }
}

// ================= MÀN HÌNH ĐĂNG NHẬP (LoginScreen) =================
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  bool _isLoading = false;
  String _tinNhanLoi = '';

  // Hàm xử lý kích hoạt tiến trình khi người dùng ấn nút Login
  Future<void> _thucHienDangNhap() async {
    final emailInput = _emailController.text.trim();
    final passwordInput = _passController.text.trim();

    if (emailInput.isEmpty || passwordInput.isEmpty) {
      setState(() {
        _tinNhanLoi = 'Vui lòng điền đầy đủ thông tin nhập liệu!';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _tinNhanLoi = '';
    });

    // Thực thi gọi hàm loginAPI từ thực thể của lớp ApiCall
    bool isLogin = await ApiCall().loginAPI(emailInput, passwordInput);

    if (!mounted) return;

    if (isLogin) {
      // Lấy Token vừa được lưu trong máy để truyền sang màn hình đích
      final prefs = await SharedPreferences.getInstance();
      final String token = prefs.getString('token') ?? '';

      if (!mounted) return;
      // Điều hướng người dùng sang FactScreen và xóa màn hình Login cũ khỏi Stack
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => FactScreen(userEmail: emailInput, token: token),
        ),
            (route) => false,
      );
    } else {
      setState(() {
        _tinNhanLoi = 'Đăng nhập thất bại! Vui lòng kiểm tra lại tài khoản.';
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
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
                  'ĐĂNG NHẬP HỆ THỐNG',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),

                // Ô nhập Email tài khoản
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

                // Ô nhập Mật khẩu bảo mật
                TextField(
                  controller: _passController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Mật khẩu',
                    hintText: 'Nhập mật khẩu bất kỳ',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                ),

                // Hiển thị thông báo lỗi màu đỏ nếu đăng nhập không thành công
                if (_tinNhanLoi.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  Text(
                    _tinNhanLoi,
                    style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
                const SizedBox(height: 30),

                // Nút bấm Đăng Nhập
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _thucHienDangNhap,
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

// ================= MÀN HÌNH ĐÍCH (FactScreen) =================
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
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();

              if (!context.mounted) return;
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

              // CẤU TRÚC ĐẦY ĐỦ VỚI TỪNG DẤU NGOẶC ĐÓNG THEO ĐÚNG ẢNH MẪU CỦA BẠN:
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Email: $userEmail',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Token: $token',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                        ),
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
