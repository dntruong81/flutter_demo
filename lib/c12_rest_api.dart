import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// --- LỚP APICALL KẾT NỐI INTERNET THẬT ---
class ApiCall {
  Future<String> getRandomFact() async {
    final url = Uri.parse('https://catfact.ninja/fact');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // jsonDecode() bóc tách chuỗi JSON nhận được từ máy chủ
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['fact'] ?? 'Không tìm thấy dữ liệu sự kiện.';
      } else {
        throw Exception('Lỗi từ máy chủ: Mã lỗi ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Lỗi kết nối internet: $e');
    }
  }
}

void main() {
  runApp(MyApp(apiCall: ApiCall()));
}

class MyApp extends StatelessWidget {
  final ApiCall apiCall;
  const MyApp({super.key, required this.apiCall});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: HomeScreen(apiCall: apiCall),
    );
  }
}

// --- GIAO DIỆN SỬ DỤNG FUTUREBUILDER ---
class HomeScreen extends StatefulWidget {
  final ApiCall apiCall;
  const HomeScreen({super.key, required this.apiCall});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Khai báo Future để FutureBuilder theo dõi
  late Future<String> _catFactFuture;

  @override
  void initState() {
    super.initState();
    // Khởi tạo luồng gọi API lần đầu tiên khi ứng dụng mở lên
    _catFactFuture = widget.apiCall.getRandomFact();
  }

  // Hàm kích hoạt gọi lại API khi người dùng nhấn nút làm mới
  void _refreshFact() {
    setState(() {
      _catFactFuture = widget.apiCall.getRandomFact();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cat Fact với FutureBuilder'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.pets, size: 80, color: Colors.orange),
              const SizedBox(height: 20),

              // --- SỬ DỤNG FUTUREBUILDER Ở ĐÂY ---
              FutureBuilder<String>(
                future: _catFactFuture, // Biến Future cần theo dõi
                builder: (context, snapshot) {
                  // Trường hợp 1: Dữ liệu đang được tải từ Internet
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  // Trường hợp 2: Quá trình gọi API xảy ra lỗi (mất mạng, lỗi server...)
                  if (snapshot.hasError) {
                    return Card(
                      color: Colors.red.shade50,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          '${snapshot.error}',
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }

                  // Trường hợp 3: Kết nối thành công và đã có dữ liệu trả về từ jsonDecode
                  if (snapshot.hasData) {
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          snapshot.data!, // Lấy chuỗi dữ liệu ra thông qua snapshot.data
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }

                  return const Text('Không có trạng thái nào phù hợp.');
                },
              ),

              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: _refreshFact,
                icon: const Icon(Icons.refresh),
                label: const Text('getRandomFact()'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
