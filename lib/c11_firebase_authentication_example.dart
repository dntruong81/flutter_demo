import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'c11_auth_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Kiểm tra trạng thái phiên đăng nhập cũ khi vừa mở ứng dụng
    final User? currentUser = FirebaseAuth.instance.currentUser;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Auth App',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      // Nếu có phiên đăng nhập cũ thì vào thẳng HomeScreen, ngược lại vào AuthScreen
      home: currentUser != null ? const HomeScreen() : const AuthScreen(),
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthService _authService = AuthService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoginMode = true;
  bool _isLoading = false;

  // Xử lý chuyển màn hình chủ động sang HomeScreen
  // và xóa lịch sử điều hướng (tức xoá màn hình hiện tại khỏi ngăn xếp, không cho quay về)
  void _navigateToHome() {
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  // Thực thi chức năng Đăng ký tài khoản
  void _handleRegister() async {
    final String name = _nameController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      _showSnackBar('Vui lòng nhập đầy đủ thông tin!');
      return;
    }

    setState(() => _isLoading = true);

    try {
      bool isSuccess = await _authService.register(email: email, password: password, name: name);
      if (isSuccess) {
        _showSnackBar('Đăng ký và cập nhật tên thành công!');
        _navigateToHome(); // Chủ động chuyển màn hình khi thành công
      }
    } on FirebaseAuthException catch (e) {
      _showSnackBar(_getAuthErrorMessage(e));
    } catch (e) {
      _showSnackBar('Đã xảy ra lỗi hệ thống: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // Thực thi chức năng Đăng nhập tài khoản
  void _handleSignIn() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnackBar('Vui lòng nhập tài khoản và mật khẩu!');
      return;
    }

    setState(() => _isLoading = true);

    try {
      bool isLoggedIn = await _authService.signIn(email: email, password: password);
      if (isLoggedIn) {
        _showSnackBar('Đăng nhập hệ thống thành công!');
        _navigateToHome(); // Chủ động chuyển màn hình khi thành công
      }
    } on FirebaseAuthException catch (e) {
      _showSnackBar(_getAuthErrorMessage(e));
    } catch (e) {
      _showSnackBar('Đã xảy ra lỗi: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  String _getAuthErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'Định dạng email nhập vào không hợp lệ.';
      case 'user-disabled':
        return 'Tài khoản này đã bị khóa.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Thông tin tài khoản hoặc mật khẩu không chính xác.';
      case 'email-already-in-use':
        return 'Địa chỉ email này đã được đăng ký bởi một tài khoản khác.';
      case 'weak-password':
        return 'Mật khẩu quá ngắn, vui lòng nhập tối thiểu 6 ký tự.';
      default:
        return e.message ?? 'Lỗi xác thực không xác định.';
    }
  }

  void _showSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLoginMode ? 'Đăng Nhập Hệ Thống' : 'Đăng Ký Thành Viên'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!_isLoginMode) ...[
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Họ và tên', border: OutlineInputBorder(), prefixIcon: Icon(Icons.person)),
                ),
                const SizedBox(height: 15),
              ],
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder(), prefixIcon: Icon(Icons.email)),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Mật khẩu', border: OutlineInputBorder(), prefixIcon: Icon(Icons.lock)),
                obscureText: true,
              ),
              const SizedBox(height: 25),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                onPressed: _isLoginMode ? _handleSignIn : _handleRegister,
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                child: Text(_isLoginMode ? 'ĐĂNG NHẬP' : 'ĐĂNG KÝ MỚI', style: const TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => setState(() => _isLoginMode = !_isLoginMode),
                child: Text(_isLoginMode ? 'Chưa có tài khoản? Đăng ký tại đây' : 'Đã có tài khoản? Quay lại Đăng nhập'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Lấy thông tin user hiện tại (Chắc chắn đã qua hàm reload() đồng bộ tên từ lớp dịch vụ)
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Màn Hình Chính'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await AuthService().signOut();
              if (context.mounted) {
                // Đăng xuất thành công, xóa lịch sử màn hình và quay về AuthScreen
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const AuthScreen()),
                      (route) => false,
                );
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.account_circle, size: 100, color: Colors.blue),
            const SizedBox(height: 15),
            Text(
              'Xin chào, ${user?.displayName ?? 'Người dùng'}!',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Email: ${user?.email}', style: const TextStyle(fontSize: 16, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
