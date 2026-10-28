import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'c11_33_34_user_model.dart';

class DatabaseService {
  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;
  DatabaseService._internal();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'helper_user_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE users(id TEXT PRIMARY KEY, name TEXT, age INTEGER, email TEXT)'
        );
      },
    );
  }

  Future<int> insertUser(UserModel user) async {
    final db = await database;
    return await db.insert('users', user.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<UserModel>> getUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) => UserModel.fromMap(maps[i]));
  }

  // 🟢 HÀM TÌM KIẾM MỚI THÊM VÀO
  Future<List<UserModel>> searchUsers(String keyword) async {
    final db = await database;
    // Sử dụng SQL Helper `query` kết hợp từ khóa LIKE để tìm gần đúng theo tên hoặc email
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'name LIKE ? OR email LIKE ?',
      whereArgs: ['%$keyword%', '%$keyword%'],
    );
    return List.generate(maps.length, (i) => UserModel.fromMap(maps[i]));
  }

  Future<int> editUser(UserModel user) async {
    final db = await database;
    return await db.update('users', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
  }

  Future<int> deleteUser(String id) async {
    final db = await database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }
}
