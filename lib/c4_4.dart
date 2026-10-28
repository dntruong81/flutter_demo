import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Đăng ký tài khoản',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const RegisterScreen(),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Key quản lý trạng thái của Form
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // 1. Khai báo các biến lưu trữ dữ liệu sau khi Save thành công
  String _savedEmail = '';
  String _savedPassword = '';

  // Hàm xử lý khi bấm nút Đăng ký (Submit)
  void _submitForm() {
    // 2. Kích hoạt kiểm tra dữ liệu của Form (Validate)
    if (_formKey.currentState!.validate()) {

      // === NẾU HỢP LỆ: TIẾN HÀNH SAVE VÀO BIẾN ===
      _formKey.currentState!.save(); // Lệnh này kích hoạt tất cả các hàm onSaved bên dưới Form

      // Hiển thị thông báo thành công kèm theo dữ liệu đã được lưu
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đăng ký thành công!\nĐã lưu Email: $_savedEmail'),
          backgroundColor: Colors.green,
        ),
      );

    } else {
      // NẾU CÓ BẤT KỲ Ô NÀO NHẬP SAI:
      // Đợi 1.5 giây để người dùng kịp đọc dòng lỗi, sau đó reset sạch form.
      Future.delayed(const Duration(milliseconds: 3000), () {
        if (mounted) {
          _formKey.currentState!.reset(); // Xóa trạng thái lỗi màu đỏ
          _emailController.clear();       // Xóa ký tự ô Email
          _passwordController.clear();    // Xóa ký tự ô Mật khẩu
        }
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
      appBar: AppBar(
        title: const Text('Đăng ký tài khoản'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade100,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.account_circle,
                  size: 100,
                  color: Colors.blue,
                ),
                const SizedBox(height: 32),

                // --- Ô NHẬP EMAIL ---
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'example@gmail.com',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Vui lòng không để trống ô Email';
                    }
                    if (!value.contains('@')) {
                      return 'Vui lòng nhập đúng định dạng Email';
                    }
                    return null;
                  },
                  // Hàm bắt dữ liệu và gán vào biến khi gọi lệnh .save()
                  onSaved: (value) {
                    _savedEmail = value ?? '';
                  },
                ),

                const SizedBox(height: 16),

                // --- Ô NHẬP MẬT KHẨU ---
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Mật khẩu',
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập mật khẩu';
                    }
                    if (value.length < 6) {
                      return 'Mật khẩu phải chứa ít nhất 6 ký tự';
                    }
                    return null;
                  },
                  // Hàm bắt dữ liệu và gán vào biến khi gọi lệnh .save()
                  onSaved: (value) {
                    _savedPassword = value ?? '';
                  },
                ),

                const SizedBox(height: 24),

                // --- NÚT SUBMIT ĐĂNG KÝ ---
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  child: const Text('Đăng ký'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
