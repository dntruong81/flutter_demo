import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo Rest API Flutter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ManHinhDangKy(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ManHinhDangKy extends StatefulWidget {
  const ManHinhDangKy({super.key});

  @override
  State<ManHinhDangKy> createState() => _ManHinhDangKyState();
}

class _ManHinhDangKyState extends State<ManHinhDangKy> {
  // Bộ điều khiển để lấy dữ liệu từ các ô nhập liệu (Form)
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _DangTai = false;
  String _ketQuaId = "";
  String _ketQuaToken = "";
  String _tinNhanLoi = "";

  // HÀM KẾT NỐI VÀ GỬI DỮ LIỆU ĐẾN BACKEND DEMO (REQRES)
  Future<void> thucHienDangKy() async {
    // 1. Địa chỉ API Register của backend demo trực tuyến ReqRes
    final url = Uri.parse('https://reqres.in/api/register');

    setState(() {
      _DangTai = true;
      _ketQuaId = "";
      _ketQuaToken = "";
      _tinNhanLoi = "";
    });

    try {
      // 2. Sử dụng http.post để gửi dữ liệu đi kèm dạng chuỗi JSON
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": _emailController.text.trim(),
          "password": _passwordController.text.trim(),
        }),
      );

      // 3. Giải mã dữ liệu JSON thô nhận từ backend thành Map trong Dart
      final data = jsonDecode(response.body);

      // 4. Kiểm tra mã trạng thái trả về (200 OK đại diện cho xử lý thành công)
      if (response.statusCode == 200) {
        setState(() {
          print('Body tra ve: ' + response.body); //Lệnh thêm vào để kiểm tra
          // Trích xuất id và token định danh từ JSON của backend trả về
          _ketQuaId = data['id'].toString(); //Kết quả trả về có ID
          _ketQuaToken = data['token'].toString();
        });
      } else {
        setState(() {
          // Nếu có lỗi (ví dụ thiếu mật khẩu), hiển thị thông tin lỗi của backend
          _tinNhanLoi = data['error'] ?? "Đăng ký thất bại!";
        });
      }
    } catch (e) {
      print("❌ Chi tiết lỗi kết nối: $e");
      print("🔍 Kiểu dữ liệu của lỗi: ${e.runtimeType}");
      setState(() {
        _tinNhanLoi = "Không thể kết nối Internet hoặc lỗi hệ thống!";
      });
    } finally {
      setState(() {
        _DangTai = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter REST API Demo')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Đăng ký tài khoản (Dùng Backend ReqRes)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email tài khoản test',
                hintText: 'Nhập: eve.holt@reqres.in',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Mật khẩu',
                hintText: 'Nhập mật khẩu bất kỳ',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            _DangTai
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
              onPressed: thucHienDangKy,
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15)),
              child: const Text('Bấm Gửi lên Server (POST)', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 25),

            // HIỂN THỊ KẾT QUẢ PHẢN HỒI TỪ BACKEND
            if (_ketQuaToken.isNotEmpty) ...[
              Card(
                color: Colors.green.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('🎉 ĐĂNG KÝ THÀNH CÔNG (statusCode: 200)', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                      const Divider(),
                      Text('ID người dùng: $_ketQuaId'),
                      const SizedBox(height: 5),
                      Text('Mã Token nhận được:\n$_ketQuaToken', style: const TextStyle(fontFamily: 'monospace', color: Colors.blueGrey)),
                    ],
                  ),
                ),
              )
            ],
            if (_tinNhanLoi.isNotEmpty) ...[
              Card(
                color: Colors.red.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text('❌ LỖI TỪ SERVER:\n$_tinNhanLoi', style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
