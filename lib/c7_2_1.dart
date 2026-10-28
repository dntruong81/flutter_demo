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
      home: Scaffold(
        body: Center(
          child: PasswordInputField(),
        ),
      ),
    );
  }
}

// Widget quản lý trạng thái của ô nhập mật khẩu
class PasswordInputField extends StatefulWidget {
  const PasswordInputField({super.key});

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  // Trạng thái dùng để kiểm soát việc ẩn/hiện văn bản
  // Mặc định ban đầu là true (ẩn mật khẩu)
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: TextField(
        // Sử dụng biến trạng thái để quyết định ẩn ký tự hay không
        obscureText: _isObscure,
        decoration: InputDecoration(
          labelText: 'Mật khẩu',
          hintText: 'Nhập mật khẩu của bạn',
          prefixIcon: const Icon(Icons.lock), // Biểu tượng ổ khóa ở đầu ô nhập
          border: const OutlineInputBorder(),

          // SuffixIcon: Biểu tượng con mắt nằm ở cuối ô nhập
          suffixIcon: IconButton(
            // Hoán đổi icon con mắt đóng/mở dựa trên trạng thái _isObscure
            icon: Icon(
              _isObscure ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: () {
              // Kích hoạt setState để giao diện cập nhật lại ngay lập tức
              setState(() {
                _isObscure = !_isObscure;
              });
            },
          ),
        ),
      ),
    );
  }
}
