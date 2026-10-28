import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DialogDemoPage(),
    );
  }
}

class DialogDemoPage extends StatefulWidget {
  const DialogDemoPage({super.key});

  @override
  State<DialogDemoPage> createState() => _DialogDemoPageState();
}

class _DialogDemoPageState extends State<DialogDemoPage> {
  String _dialogResult = "Chưa lựa chọn";

  // Hàm dùng để kích hoạt và hiển thị Dialog
  void _showSampleDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // false = bắt buộc bấm nút mới tắt được dialog, true = bấm ra ngoài để tắt
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận xóa'),
          content: const Text('Bạn có chắc chắn muốn xóa mục này không? Hành động này không thể hoàn tác.'),
          actions: <Widget>[
            // Nút Hủy bỏ
            TextButton(
              onPressed: () {
                // Đóng dialog và truyền về giá trị 'Cancel'
                Navigator.of(context).pop('Cancel');
              },
              child: const Text('Hủy', style: TextStyle(color: Colors.grey)),
            ),
            // Nút Đồng ý
            ElevatedButton(
              onPressed: () {
                // Đóng dialog và truyền về giá trị 'Confirm'
                Navigator.of(context).pop('Confirm');
              },
              child: const Text('Đồng ý'),
            ),
          ],
        );
      },
    ).then((value) {
      // Nhận giá trị trả về từ Navigator.pop sau khi Dialog đóng
      if (value != null) {
        setState(() {
          _dialogResult = value == 'Confirm' ? 'Bạn đã bấm ĐỒNG Ý' : 'Bạn đã bấm HỦY';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hướng dẫn Sample Dialog')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _showSampleDialog(context),
              child: const Text('Mở Hộp Thoại (Dialog)'),
            ),
            const SizedBox(height: 30),
            const Text('Trạng thái hiện tại:', style: TextStyle(fontSize: 16)),
            Text(
              _dialogResult,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
