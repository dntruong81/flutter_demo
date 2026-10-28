import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Popup Menu Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Hàm tiện ích để hiển thị thông báo nhanh khi bấm nút
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ứng dụng Menu'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // Nút 3 dấu chấm đứng (Popup Menu)
          PopupMenuButton<String>(
            onSelected: (String value) {
              // Xử lý logic khi người dùng chọn từng mục
              switch (value) {
                case 'settings':
                  _showSnackBar(context, 'Bạn đã chọn: Cài đặt');
                  break;
                case 'help':
                  _showSnackBar(context, 'Bạn đã chọn: Trợ giúp');
                  break;
                case 'logout':
                  _showSnackBar(context, 'Bạn đã chọn: Đăng xuất');
                  break;
                case 'info':
                  _showSnackBar(context, 'Bạn đã chọn: Thông tin');
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'settings',
                  child: Row(
                    children: [
                      Icon(Icons.settings, color: Colors.black54),
                      SizedBox(width: 10),
                      Text('Cài đặt'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'help',
                  child: Row(
                    children: [
                      Icon(Icons.help_outline, color: Colors.black54),
                      SizedBox(width: 10),
                      Text('Trợ giúp'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'info',
                  child: Row(
                    children: [
                      Icon(Icons.info, color: Colors.black54),
                      SizedBox(width: 10),
                      Text('Thông tin'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(Icons.logout, color: Colors.red),
                      SizedBox(width: 10),
                      Text('Đăng xuất', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Nhấn vào nút 3 dấu chấm ở góc trên bên phải',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
