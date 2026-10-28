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
      title: 'Danh Bạ Mượt Mà',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ContactListScreen(),
    );
  }
}

// 1. Định nghĩa cấu trúc dữ liệu cho một Liên hệ (Contact)
class Contact {
  final String name;
  final String phone;
  final String email;

  Contact({required this.name, required this.phone, required this.email});
}

// 2. Màn hình chính chứa danh bạ điện thoại
class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  // Tạo danh sách giả lập gồm 20 liên hệ
  final List<Contact> _contacts = List.generate(
    10,
        (index) => Contact(
      name: 'Người dùng thứ ${index + 1}',
      phone: '0908 ${100000 + index}',
      email: 'user${index + 1}@example.com',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh bạ (${_contacts.length} liên hệ)'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      // Sử dụng ListView.builder để tối ưu hóa hiệu năng cuộn
      body: ListView.builder(
        itemCount: _contacts.length, // Tổng số lượng phần tử trong danh sách
        itemBuilder: (context, index) {
          // Lấy dữ liệu của liên hệ hiện tại theo chỉ mục (index)
          final contact = _contacts[index];

          // Trả về widget đại diện cho một hàng (giao diện của từng dòng)
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            elevation: 3,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue.shade100,
                child: Text(
                  contact.name[0], // Lấy chữ cái đầu tiên của tên làm avatar
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ),
              title: Text(
                contact.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${contact.phone} \n${contact.email}'),
              isThreeLine: true,
              trailing: IconButton(
                icon: const Icon(Icons.phone, color: Colors.green),
                onPressed: () {
                  // Hành động khi nhấn vào nút gọi
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Đang gọi cho ${contact.name}...')),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
