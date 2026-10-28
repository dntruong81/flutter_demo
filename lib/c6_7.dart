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
      title: 'Danh Sách Học Sinh',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.indigo,
      ),
      home: const StudentListTableScreen(),
    );
  }
}

// 1. Lớp đối tượng Học sinh (Student Model)
class Student {
  final String name;
  final String subject;
  final double marks;

  Student({required this.name, required this.subject, required this.marks});
}

// 2. Màn hình hiển thị bảng từ List
class StudentListTableScreen extends StatelessWidget {
  const StudentListTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Khởi tạo một List học sinh (Dữ liệu này có thể lấy từ biến local, state hoặc server)
    final List<Student> studentList = [
      Student(name: 'Alex', subject: 'Toán (Math)', marks: 8.5),
      Student(name: 'Henry', subject: 'Vật lý (Physics)', marks: 9.0),
      Student(name: 'Luke', subject: 'Hóa học (Chemistry)', marks: 7.5),
      Student(name: 'Sophia', subject: 'Ngữ văn (Literature)', marks: 8.8),
      Student(name: 'Oliver', subject: 'Tiếng Anh (English)', marks: 9.5),
      Student(name: 'Anh', subject: 'Nhạc (Music', marks: 10),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bảng Điểm Sinh Từ List'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tổng số học sinh: ${studentList.length}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // ================= BẢNG HIỂN THỊ DỮ LIỆU =================
            Table(
              border: TableBorder.all(
                color: Colors.grey.shade400,
                width: 1,
              ),
              columnWidths: const {
                0: FlexColumnWidth(3),
                1: FlexColumnWidth(4),
                2: FlexColumnWidth(3),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [

                // HÀNG TIÊU ĐỀ CỐ ĐỊNH
                TableRow(
                  decoration: BoxDecoration(color: Colors.grey.shade200),
                  children: const [
                    _BuildTableCell(text: 'Tên (Name)', isHeader: true),
                    _BuildTableCell(text: 'Môn học (Subject)', isHeader: true),
                    _BuildTableCell(text: 'Điểm số (Marks)', isHeader: true),
                  ],
                ),

                // HÀNG TỰ ĐỘNG SINH TỪ LIST HỌC SINH
                // Dấu ba chấm (...) giúp giải nén danh sách các TableRow vào thuộc tính children
                ...studentList.map((student) {
                  return TableRow(
                    children: [
                      _BuildTableCell(text: student.name),
                      _BuildTableCell(text: student.subject),
                      _BuildTableCell(text: student.marks.toString()),
                    ],
                  );
                }).toList(), // Chuyển đổi kết quả map thành một List các TableRow

              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Widget định dạng cho từng ô trong hàng
class _BuildTableCell extends StatelessWidget {
  final String text;
  final bool isHeader;

  const _BuildTableCell({required this.text, this.isHeader = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontSize: isHeader ? 15 : 14,
          color: isHeader ? Colors.indigo.shade900 : Colors.black87,
        ),
      ),
    );
  }
}
