import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  // Cấu trúc Singleton đảm bảo chỉ có 1 thực thể quản lý DB trong toàn app
  static final DatabaseService _databaseService = DatabaseService._internal();

  //factory: Dù bạn có gọi hàm khởi tạo này bao nhiêu lần đi chăng nữa,
  // hệ thống cũng chỉ trả về duy nhất một thực thể (instance) đã được tạo sẵn.
  factory DatabaseService() => _databaseService;

  //Hàm xây dựng đặt tên Ẩn (dùng dấu _ trước tên) để tạo ra thực thể _databaseService ở câu lệnh bên trên.
  DatabaseService._internal();
  static Database? _database; // Database: khai báo trong thư viện sqflite

  // Hàm lấy database hiện tại, nếu chưa có thì khởi tạo mới
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  // Khởi tạo file database và tạo bảng dữ liệu cục bộ
  Future<Database> _initDB() async {
    // Tìm thư mục lưu trữ database trên bộ nhớ thiết bị
    //Hàm join này nằm trong thư viện path.
    //Nó có nhiệm vụ nối thư mục hệ thống (ở mục 1) và tên file (ở mục 2) lại với nhau để tạo thành một đường dẫn hoàn chỉnh.
    String path = join(await getDatabasesPath(), 'finance_local.db');

    // Mở database, nếu chạy lần đầu tiên sẽ tự tạo bảng 'transactions'
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE transactions(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            amount REAL,
            date TEXT
          )
        ''');
      },
    );
  }

  // Hàm THÊM một giao dịch chi tiêu mới vào SQLite
  Future<void> insertTransaction(String title, double amount) async {
    final db = await database;
    Map<String, dynamic> data = {
      'title': title,
      'amount': amount,
      'date': DateTime.now().toIso8601String(), // Lưu thời gian dưới dạng chuỗi String
    };

    await db.insert('transactions', data);
    print("Đã lưu thành công vào SQLite: $title");
  }

  // Hàm ĐỌC toàn bộ danh sách giao dịch từ SQLite ra (Xếp giao dịch mới nhất lên đầu)
  Future<List<Map<String, dynamic>>> getTransactions() async {
    final db = await database;
    return await db.query('transactions', orderBy: 'id DESC');
  }
}
