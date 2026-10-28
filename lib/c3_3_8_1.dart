import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Thư viện định dạng ngày tháng

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BirthdayPickerScreen(),
    );
  }
}

class BirthdayPickerScreen extends StatefulWidget {
  const BirthdayPickerScreen({super.key});

  @override
  State<BirthdayPickerScreen> createState() => _BirthdayPickerScreenState();
}

class _BirthdayPickerScreenState extends State<BirthdayPickerScreen> {
  final TextEditingController _birthdayController = TextEditingController();

  // Biến lưu trữ giá trị ngày gốc dạng DateTime để in kiểm tra logic
  DateTime? _selectedDateTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedDateTime = picked;
        // Hiển thị chuỗi định dạng Việt Nam lên màn hình app
        _birthdayController.text = DateFormat('dd/MM/yyyy').format(picked);
      });

      // [KIỂM TRA 1]: In ngay lập tức ra console khi người dùng vừa chọn ngày xong
      print('=== NGƯỜI DÙNG VỪA CHỌN NGÀY ===');
      print('Giá trị DateTime gốc: $_selectedDateTime');
      print('Chuỗi định dạng hiển thị: ${_birthdayController.text}');
    }
  }

  @override
  void dispose() {
    _birthdayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng Ký Ngày Sinh'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _birthdayController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Ngày sinh',
                hintText: 'Chạm để chọn ngày sinh',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              onTap: () => _selectDate(context),
            ),

            const SizedBox(height: 30),

            // NÚT BẤM XÁC NHẬN ĐỂ IN KIỂM TRA DỮ LIỆU TOÀN DIỆN
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              onPressed: () {
                // [KIỂM TRA 2]: In toàn bộ thông tin khi bấm nút gửi thông tin
                print('===================================');
                print('BUTTON XÁC NHẬN ĐƯỢC NHẤN');

                if (_selectedDateTime != null) {
                  print('Trạng thái: Hợp lệ');
                  print('Ngày sinh (Chuỗi): ${_birthdayController.text}');
                  print('Năm sinh: ${_selectedDateTime!.year}');
                  print('Tháng sinh: ${_selectedDateTime!.month}');
                  print('Ngày sinh: ${_selectedDateTime!.day}');
                } else {
                  print('Trạng thái: Thất bại (Người dùng chưa chọn ngày sinh!)');
                }
                print('===================================');
              },
              child: const Text('Gửi dữ liệu kiểm tra', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
