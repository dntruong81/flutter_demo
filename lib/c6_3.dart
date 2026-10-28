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
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Avatar Online Demo'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: const Center(
          child: UserAvatarWithStatus(),
        ),
      ),
    );
  }
}

class UserAvatarWithStatus extends StatelessWidget {
  const UserAvatarWithStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. Ảnh đại diện nằm ở dưới cùng
        const CircleAvatar(
          radius: 35, // Độ rộng của Avatar
          backgroundColor: Colors.blueGrey,
          child: Icon(
            Icons.person,
            size: 40,
            color: Colors.white,
          ),
        ),

        // 2. Chấm xanh báo trạng thái "Online" nằm đè ở góc trên bên phải
        Positioned(
          bottom: 0, // Đẩy cách mép dưới một chút để bo theo đường tròn
          right: -1,  // Đẩy cách mép phải một chút để bo theo đường tròn
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.green, // Màu xanh báo trạng thái Online
              shape: BoxShape.circle,
              // Tạo thêm viền trắng xung quanh chấm xanh để tách biệt với ảnh đại diện
              border: Border.all(
                color: Theme.of(context).scaffoldBackgroundColor,
                width: 2.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
