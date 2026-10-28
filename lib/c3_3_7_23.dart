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
      home: RegistrationFormScreen(),
    );
  }
}

class RegistrationFormScreen extends StatefulWidget {
  const RegistrationFormScreen({super.key});

  @override
  State<RegistrationFormScreen> createState() => _RegistrationFormScreenState();
}

class _RegistrationFormScreenState extends State<RegistrationFormScreen> {
  // --- 1. Khai báo biến lưu trạng thái Giới tính (Radio) ---
  // Dùng chuỗi String để lưu lựa chọn hiện tại ('Nam' hoặc 'Nữ')
  String? _selectedGender = 'Nam';

  // --- 2. Khai báo biến lưu trạng thái Sở thích (Checkbox) ---
  bool _likesSports = false;
  bool _likesMusic = false;
  bool _likesTravel = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Đăng Ký Thông Tin'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =======================================================
            // PHẦN 1: CHỌN GIỚI TÍNH (Sử dụng Radio)
            // =======================================================
            const Text(
              'Chọn giới tính (Chỉ chọn một):',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Nam'),
                    value: 'Nam',
                    groupValue: _selectedGender, // Nhóm chung để Flutter biết chỉ được chọn 1
                    onChanged: (String? value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Nữ'),
                    value: 'Nữ',
                    groupValue: _selectedGender, // Nhóm chung để Flutter biết chỉ được chọn 1
                    onChanged: (String? value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30), // Khoảng cách giữa các phần

            // =======================================================
            // PHẦN 2: CHỌN SỞ THÍCH (Sử dụng Checkbox)
            // =======================================================
            const Text(
              'Sở thích (Có thể chọn nhiều mục):',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            CheckboxListTile(
              title: const Text('Thể thao'),
              value: _likesSports,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) {
                setState(() {
                  _likesSports = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Âm nhạc'),
              value: _likesMusic,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) {
                setState(() {
                  _likesMusic = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Du lịch'),
              value: _likesTravel,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) {
                setState(() {
                  _likesTravel = value ?? false;
                });
              },
            ),

            const SizedBox(height: 40),

            // Nút bấm xác nhận gửi Form
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                onPressed: () {
                  // In kết quả ra Console để kiểm tra dữ liệu
                  print('--- DỮ LIỆU ĐĂNG KÝ ---');
                  print('Giới tính: $_selectedGender');
                  print('Sở thích Thể thao: $_likesSports');
                  print('Sở thích Âm nhạc: $_likesMusic');
                  print('Sở thích Du lịch: $_likesTravel');
                },
                child: const Text('Gửi Thông Tin', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
