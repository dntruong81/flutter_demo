import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'c11_firebase_realtime_database_usermodel.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase CRUD Standard Commands',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const UserListScreen(),
    );
  }
}

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final DatabaseReference _userRef = FirebaseDatabase.instance.ref().child('users');

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  List<UserModel> _userList = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchUsers(); // Tải danh sách ban đầu bằng lệnh get()
  }

  // ---------------------------------------------------------------------------
  // [READ] LỆNH LẤY DỮ LIỆU: .get()
  // ---------------------------------------------------------------------------
  Future<void> _fetchUsers() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final DataSnapshot snapshot = await _userRef.get();
      final data = snapshot.value;

      List<UserModel> tempList = [];
      if (data != null) {
        final Map<dynamic, dynamic> usersMap = data as Map<dynamic, dynamic>;
        usersMap.forEach((key, value) {
          tempList.add(UserModel.fromMap(value as Map<dynamic, dynamic>));
        });
      }

      setState(() {
        _userList = tempList;
      });
    } catch (e) {
      _showSnackBar('Lỗi tải dữ liệu: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // ---------------------------------------------------------------------------
  // [CREATE] LỆNH TẠO MỚI: .set()
  // ---------------------------------------------------------------------------
  void _createUser() async {
    final String name = _nameController.text.trim();
    final String email = _emailController.text.trim();
    final int? age = int.tryParse(_ageController.text.trim());

    if (name.isEmpty || email.isEmpty || age == null) {
      _showSnackBar('Vui lòng điền đầy đủ thông tin hợp lệ!');
      return;
    }

    final String newCustomId = 'USER_${DateTime.now().millisecondsSinceEpoch}';
    UserModel newUser = UserModel(id: newCustomId, name: name, age: age, email: email);

    // Ghi dữ liệu mới vào node con
    await _userRef.child(newCustomId).set(newUser.toMap());

    _clearFormAndPop();
    _showSnackBar('Thêm người dùng mới thành công!');
    _fetchUsers();
  }

  // ---------------------------------------------------------------------------
  // [UPDATE] LỆNH CẬP NHẬT: .update()
  // ---------------------------------------------------------------------------
  void _updateUser(String existingUserId) async {
    final String name = _nameController.text.trim();
    final String email = _emailController.text.trim();
    final int? age = int.tryParse(_ageController.text.trim());

    if (name.isEmpty || email.isEmpty || age == null) {
      _showSnackBar('Vui lòng điền đầy đủ thông tin hợp lệ!');
      return;
    }

    // Khởi tạo Map chứa giá trị cập nhật
    Map<String, dynamic> updatedFields = {
      'name': name,
      'email': email,
      'age': age,
    };

    // Sử dụng chính xác lệnh .update() để cập nhật cục bộ các trường thay đổi
    await _userRef.child(existingUserId).update(updatedFields);

    _clearFormAndPop();
    _showSnackBar('Cập nhật thông tin thành công!');
    _fetchUsers();
  }

  // ---------------------------------------------------------------------------
  // [DELETE] LỆNH XÓA: .remove()
  // ---------------------------------------------------------------------------
  void _deleteUser(String userId) async {
    // Sử dụng chính xác lệnh .remove() để hủy node dữ liệu
    await _userRef.child(userId).remove();
    _showSnackBar('Đã xóa người dùng thành công!');
    _fetchUsers();
  }

  // ---------------------------------------------------------------------------
  // HÀM BỔ TRỢ GIAO DIỆN
  // ---------------------------------------------------------------------------
  void _showSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  void _clearFormAndPop() {
    _nameController.clear();
    _emailController.clear();
    _ageController.clear();
    if (mounted) Navigator.pop(context);
  }

  void _showUserBottomSheet({UserModel? user}) {
    final bool isEditMode = user != null;

    if (isEditMode) {
      _nameController.text = user.name;
      _emailController.text = user.email;
      _ageController.text = user.age.toString();
    } else {
      _nameController.clear();
      _emailController.clear();
      _ageController.clear();
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                isEditMode ? 'Cập Nhật Thông Tin' : 'Thêm Người Dùng Mới',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Age', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => isEditMode ? _updateUser(user.id) : _createUser(),
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(15)),
                child: Text(isEditMode ? 'Update User' : 'Add User'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Standard'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchUsers,
          )
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _userList.isEmpty
          ? const Center(child: Text('Chưa có dữ liệu. Hãy bấm [+] để thêm.'))
          : RefreshIndicator(
        onRefresh: _fetchUsers,
        child: ListView.builder(
          itemCount: _userList.length,
          itemBuilder: (context, index) {
            final user = _userList[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: ListTile(
                leading: CircleAvatar(child: Text(user.age.toString())),
                title: Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('${user.email}\nID: ${user.id}'),
                isThreeLine: true,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => _showUserBottomSheet(user: user),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteUser(user.id),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showUserBottomSheet(),
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    super.dispose();
  }
}
