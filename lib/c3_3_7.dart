import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minh họa Ẩn/Hiện Mật khẩu',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const PasswordDemoPage(),
    );
  }
}

class PasswordDemoPage extends StatefulWidget {
  const PasswordDemoPage({super.key});

  @override
  State<PasswordDemoPage> createState() => _PasswordDemoPageState();
}

class _PasswordDemoPageState extends State<PasswordDemoPage> {
  final TextEditingController _passwordController = TextEditingController();

  // Biến kiểm soát việc ẩn hay hiện mật khẩu trong ô nhập (Mặc định là ẩn = true)
  bool _isObscure = true;

  // Biến lưu trữ mật khẩu để hiển thị ở text phía dưới khi bấm nút
  String _submittedPassword = "";

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ẩn/Hiện Mật khẩu với Icon'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Ô nhập mật khẩu có tích hợp nút con mắt
            TextField(
              controller: _passwordController,
              obscureText: _isObscure, // Sử dụng biến số để bật/tắt ẩn ký tự
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Password',
                hintText: 'Enter your password',
                // Thêm icon con mắt vào phía cuối (bên phải) của ô nhập
                suffixIcon: IconButton(
                  icon: Icon(
                    // Thay đổi icon tùy thuộc vào trạng thái ẩn hay hiện
                    _isObscure ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    // Đảo ngược trạng thái ẩn/hiện khi người dùng bấm vào con mắt
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Nút bấm lấy nội dung mật khẩu vừa nhập
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _submittedPassword = _passwordController.text;
                });
              },
              child: const Text('Hiển thị nội dung vừa nhập'),
            ),
            const SizedBox(height: 40),

            // Khu vực kết quả hiển thị mật khẩu dạng văn bản rõ ràng
            const Text(
              'Mật khẩu bạn vừa nhập là:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              _submittedPassword.isEmpty ? '(Chưa bấm hiển thị)' : _submittedPassword,
              style: const TextStyle(
                  fontSize: 22,
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2
              ),
            ),
          ],
        ),
      ),
    );
  }
}
