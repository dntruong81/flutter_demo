import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ==========================================
// 1. CÁC NGUỒN CẤP DỮ LIỆU GỐC (CÁC PHỤ THUỘC)
// ==========================================
class NameService {
  String getUserName() => "Nguyen Van A";
}

class RoleService {
  String getUserRole() => "Admin";
}

class NetworkService extends ChangeNotifier {
  String _signalStatus = "Online 🟢";
  String getSignalStatus() => _signalStatus;

  NetworkService() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      _signalStatus = (_signalStatus == "Online 🟢") ? "Offline ❌" : "Online 🟢";
      notifyListeners(); // Kích hoạt chạy lại hàm update của ProxyProvider
    });
  }
}

// ==========================================
// 2. LỚP HOME MODEL (Quản lý trạng thái UI và logic Tự động/Thủ công)
// ==========================================
class HomeModel extends ChangeNotifier {
  String finalDisplayMessage;
  bool isManuallyChanged;

  HomeModel({
    required this.finalDisplayMessage,
    this.isManuallyChanged = false,
  });

  // Hàm cập nhật dữ liệu từ các Service bên ngoài
  void updateServiceData({required String name, required String role, required String network}) {
    // Chỉ tự động cập nhật từ Service nếu người dùng CHƯA bấm nút thay đổi thủ công
    if (!isManuallyChanged) {
      finalDisplayMessage = "User: $name\nQuyền: $role\nMạng: $network";
      notifyListeners();
    }
  }

  // Chức năng xử lý khi bấm nút Thay đổi tại UI
  void changeTextFromUI() {
    isManuallyChanged = true;
    finalDisplayMessage = "Dữ liệu đã bị thay đổi thủ công từ giao diện (UI)! 🛠️";
    notifyListeners();
  }

  // BỔ SUNG: Chức năng kích hoạt lại trạng thái tự động cập nhật mạng
  void resetToAuto({required String name, required String role, required String network}) {
    isManuallyChanged = false;
    // Cập nhật ngay lập tức dữ liệu hiện tại của Service để UI đổi trạng thái lập tức
    notifyListeners();
  }
}

// ==========================================
// HÀM MAIN - ĐIỂM KHỞI CHẠY ỨNG DỤNG
// ==========================================
void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<NameService>(create: (_) => NameService()),
        Provider<RoleService>(create: (_) => RoleService()),
        ChangeNotifierProvider<NetworkService>(create: (_) => NetworkService()),

        ChangeNotifierProxyProvider<NetworkService, HomeModel>(
          create: (_) => HomeModel(finalDisplayMessage: "Đang tải..."),
          update: (context, networkService, previousHomeModel) {
            final name = context.read<NameService>().getUserName();
            final role = context.read<RoleService>().getUserRole();
            final network = networkService.getSignalStatus();

            previousHomeModel!.updateServiceData(name: name, role: role, network: network);
            /*
            // Lấy lại trạng thái nút bấm thủ công từ model cũ (nếu có)
            final wasManuallyChanged = previousHomeModel?.isManuallyChanged ?? false;
            final oldMessage = previousHomeModel?.finalDisplayMessage ?? "Đang tải...";
            HomeModel model = HomeModel(
                                          isManuallyChanged:wasManuallyChanged,
                                          finalDisplayMessage: wasManuallyChanged ? oldMessage : "User: $name\nQuyền: $role\nMạng: $network"
                                        );

             */
            return previousHomeModel;
          },
        ),
      ],
      child: const MyApp(),
    ),
  );
}

// ==========================================
// CẤU TRÚC GIAO DIỆN (UI)
// ==========================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Consumer lắng nghe HomeModel
            Consumer<HomeModel>(
              builder: (context, homeModel, child) {
                return Column(
                  children: [
                    Text(
                      homeModel.finalDisplayMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Đã đổi thủ công: ${homeModel.isManuallyChanged}",
                      style: const TextStyle(fontSize: 14, color: Colors.blueGrey),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 30),

            // NÚT BẤM THAY ĐỔI THỦ CÔNG
            ElevatedButton(
              onPressed: () {
                Provider.of<HomeModel>(context, listen: false).changeTextFromUI();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
              child: const Text("Thay đổi dữ liệu tại UI", style: TextStyle(color: Colors.white)),
            ),

            const SizedBox(height: 15),

            // NÚT BẤM BỔ SUNG: KÍCH HOẠT LẠI TỰ ĐỘNG
            OutlinedButton(
              onPressed: () {
                // Lấy nhanh dữ liệu hiện tại của các Service để truyền vào hàm reset
                final name = Provider.of<NameService>(context, listen: false).getUserName();
                final role = Provider.of<RoleService>(context, listen: false).getUserRole();
                final network = Provider.of<NetworkService>(context, listen: false).getSignalStatus();

                Provider.of<HomeModel>(context, listen: false).resetToAuto(
                  name: name,
                  role: role,
                  network: network,
                );
              },
              child: const Text("Kích hoạt lại Tự động cập nhật mạng"),
            ),

            const SizedBox(height: 30),
            const Text(
              "(Hệ thống sẽ tự động chuyển đổi trạng thái Online/Offline\ncứ sau mỗi 5 giây khi ở chế độ Tự động)",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
