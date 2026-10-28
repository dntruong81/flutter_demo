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
      home: TravelTabScreen(),
    );
  }
}

class TravelTabScreen extends StatelessWidget {
  const TravelTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Khai báo DefaultTabController quản lý 4 Tab (length: 4)
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Travel App - Phương tiện'),
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,

          // 2. Đặt TabBar ở phần bottom của AppBar
          bottom: const TabBar(
            indicatorColor: Colors.white, // Màu thanh gạch chân dưới Tab đang chọn
            labelColor: Colors.white,      // Màu biểu tượng khi được chọn
            unselectedLabelColor: Colors.white60, // Màu biểu tượng khi chưa chọn
            tabs: [
              Tab(icon: Icon(Icons.directions_car)),     // Biểu tượng xe hơi
              Tab(icon: Icon(Icons.directions_transit)), // Biểu tượng tàu hỏa
              Tab(icon: Icon(Icons.directions_bike)),    // Biểu tượng xe đạp
            ],
          ),
        ),

        // 3. TabBarView chứa nội dung hiển thị tương ứng với từng Tab ở trên
        body: const TabBarView(
          children: [
            // Nội dung hiển thị cho Tab 1: Xe hơi
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.directions_car, size: 80, color: Colors.blueAccent),
                  SizedBox(height: 16),
                  Text('Chuyến đi bằng Xe hơi', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('Tự do khám phá các cung đường tự lái.', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),

            // Nội dung hiển thị cho Tab 2: Tàu hỏa
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.directions_transit, size: 80, color: Colors.orange),
                  SizedBox(height: 16),
                  Text('Chuyến đi bằng Tàu hỏa', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('Ngắm cảnh thiên nhiên qua ô cửa sổ hành trình.', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),

            // Nội dung hiển thị cho Tab 3: Xe đạp
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.directions_bike, size: 80, color: Colors.green),
                  SizedBox(height: 16),
                  Text('Chuyến đi bằng Xe đạp', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('Trải nghiệm du lịch xanh và rèn luyện sức khỏe.', style: TextStyle(color: Colors.grey)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
