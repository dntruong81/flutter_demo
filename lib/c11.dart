import 'package:flutter/material.dart';
import 'c11_database_service.dart'; // Nạp file DatabaseService vừa viết ở trên

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FinanceManagerScreen(),
    );
  }
}

class FinanceManagerScreen extends StatefulWidget {
  const FinanceManagerScreen({super.key});

  @override
  State<FinanceManagerScreen> createState() => _FinanceManagerScreenState();
}

class _FinanceManagerScreenState extends State<FinanceManagerScreen> {
  final DatabaseService _dbService = DatabaseService();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  List<Map<String, dynamic>> _transactions = [];

  @override
  void initState() {
    super.initState();
    _loadDataFromSQLite(); // Tự động tải dữ liệu khi vừa mở app
  }

  // Hàm lấy dữ liệu từ SQLite và cập nhật lên màn hình
  void _loadDataFromSQLite() async {
    final data = await _dbService.getTransactions();
    setState(() {
      _transactions = data;
    });
  }

  // Hàm xử lý khi người dùng ấn nút "Lưu Giao Dịch"
  void _addTransaction() async {
    if (_titleController.text.isEmpty || _amountController.text.isEmpty) return;

    String title = _titleController.text;
    double amount = double.parse(_amountController.text);

    // Lưu vào SQLite
    await _dbService.insertTransaction(title, amount);

    // Xóa chữ đã nhập trong ô
    _titleController.clear();
    _amountController.clear();

    // Tải lại danh sách mới nhất để hiển thị
    _loadDataFromSQLite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý Tài chính'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Ô nhập tên khoản chi
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Tên khoản chi tiêu (Ví dụ: Mua sách)'),
            ),
            // Ô nhập số tiền
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Số tiền (VNĐ)'),
            ),
            const SizedBox(height: 15),
            // Nút lưu dữ liệu
            ElevatedButton(
              onPressed: _addTransaction,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text('Lưu Giao Dịch', style: TextStyle(color: Colors.white)),
            ),
            const Divider(height: 40, thickness: 2),
            const Text('Danh sách chi tiêu trong SQLite:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),
            // Danh sách hiển thị dữ liệu đã lưu
            Expanded(
              child: _transactions.isEmpty
                  ? const Center(child: Text('Chưa có dữ liệu. Hãy thêm giao dịch đầu tiên!'))
                  : ListView.builder(
                itemCount: _transactions.length,
                itemBuilder: (context, index) {
                  final item = _transactions[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: const Icon(Icons.monetization_on, color: Colors.amber),
                      title: Text(item['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('${item['amount']} VNĐ'),
                      trailing: const Icon(Icons.phone_android, color: Colors.grey), // Biểu tượng lưu trên máy
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
