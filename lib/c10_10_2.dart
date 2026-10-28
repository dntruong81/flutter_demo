// main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(const GrabSimulationApp());
}

class GrabSimulationApp extends StatelessWidget {
  const GrabSimulationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grab Simulation Yield Control',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: const GrabMapScreen(),
    );
  }
}

class GrabMapScreen extends StatefulWidget {
  const GrabMapScreen({super.key});

  @override
  State<GrabMapScreen> createState() => _GrabMapScreenState();
}

class _GrabMapScreenState extends State<GrabMapScreen> {
  double _positionX = 20.0; // Biến lưu vị trí để có thể Reset về ban đầu
  bool _isRunning = false;  // Biến trạng thái kiểm tra xe có đang chạy hay không

  // Hàm Generator phát dữ liệu tọa độ theo thời gian thực
  Stream<double> getDriverLocationStream() async* {
    // Trả về vị trí ban đầu ngay lập tức khi Stream được lắng nghe
    yield _positionX;

    while (true) {
      // Đợi 1 giây trước chu kỳ di chuyển tiếp theo
      await Future.delayed(const Duration(seconds: 1));

      // Nếu trạng thái đang cho phép chạy, tiến hành tăng tọa độ
      if (_isRunning) {
        if (_positionX > 320.0) {
          _positionX = 20.0; // Reset vị trí khi chạy gần hết màn hình
        } else {
          _positionX += 10.0; // Tiến lên 40 đơn vị
        }
        yield _positionX; // Đẩy tọa độ mới vào luồng
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const double roadHeight = 12.0;
    const double carSize = 50.0;
    final double screenCenterY = MediaQuery.of(context).size.height / 2;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Grab - Điều khiển xe chạy', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          // 1. Con đường màu xám nằm chính giữa màn hình
          Positioned(
            top: screenCenterY - (roadHeight / 2),
            left: 0,
            right: 0,
            child: Container(
              height: roadHeight,
              color: Colors.grey,
            ),
          ),

          // 2. StreamBuilder lắng nghe luồng dữ liệu dịch chuyển của xe
          StreamBuilder<double>(
            stream: getDriverLocationStream(),
            initialData: _positionX,
            builder: (context, snapshot) {
              double currentPos = snapshot.data ?? 20.0;

              return Positioned(
                left: currentPos,
                top: screenCenterY - carSize + (roadHeight / 2),
                child: const Icon(
                  Icons.directions_car,
                  color: Colors.green,
                  size: carSize,
                ),
              );
            },
          ),

          // 3. Thanh điều khiển chứa nút Bắt đầu / Tạm dừng và Reset đặt ở đáy màn hình
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Nút Bắt đầu / Tạm dừng
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isRunning ? Colors.orange : Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
                  label: Text(_isRunning ? 'Tạm Dừng' : 'Bắt Đầu'),
                  onPressed: () {
                    setState(() {
                      _isRunning = !_isRunning; // Đảo trạng thái chạy/dừng
                    });
                  },
                ),
                const SizedBox(width: 20),

                // Nút Đặt lại (Reset)
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Đặt Lại (Reset)'),
                  onPressed: () {
                    setState(() {
                      _isRunning = false; // Dừng xe lại
                      _positionX = 20.0;  // Đưa xe về vạch xuất phát
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
