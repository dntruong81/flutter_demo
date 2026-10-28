import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart'; // 🟢 Import lại thư viện UUID
import 'c11_33_34_user_model.dart';
import 'c11_33_34_database_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    home: SqfliteExampleScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class SqfliteExampleScreen extends StatefulWidget {
  const SqfliteExampleScreen({super.key});

  @override
  State<SqfliteExampleScreen> createState() => _SqfliteExampleScreenState();
}

class _SqfliteExampleScreenState extends State<SqfliteExampleScreen> {
  final DatabaseService dbService = DatabaseService();
  final Uuid uuid = const Uuid(); // 🟢 Khởi tạo instance của lớp Uuid

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  String _searchKeyword = '';

  // Hàm mở Bottom Sheet nhập thông tin (Thêm hoặc Sửa)
  void _openUserForm({UserModel? existingUser}) {
    if (existingUser != null) {
      _nameController.text = existingUser.name;
      _ageController.text = existingUser.age.toString();
      _emailController.text = existingUser.email;
    } else {
      _nameController.clear();
      _ageController.clear();
      _emailController.clear();
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 20, left: 20, right: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                existingUser == null ? 'Add New User' : 'Edit User',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Age', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
                onPressed: () async {
                  final String name = _nameController.text;
                  final int age = int.tryParse(_ageController.text) ?? 0;
                  final String email = _emailController.text;

                  if (existingUser == null) {
                    // `addUser()`: Tạo UUID tự động qua phương thức v4() của package uuid
                    final String newId = uuid.v4();
                    await dbService.insertUser(UserModel(id: newId, name: name, age: age, email: email));
                  } else {
                    // `editUser()`: Gọi hàm cập nhật dữ liệu
                    await dbService.editUser(UserModel(id: existingUser.id, name: name, age: age, email: email));
                  }

                  if (mounted) Navigator.pop(context);
                  setState(() {});
                },
                child: Text(existingUser == null ? 'Submit' : 'Update'),
              ),
              const SizedBox(height: 20),
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
        title: const Text('Sqflite Demo'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          // Thanh tìm kiếm dữ liệu
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by name or email...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchKeyword.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _searchKeyword = '';
                    });
                  },
                )
                    : null,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchKeyword = value;
                });
              },
            ),
          ),

          // Thân trang hiển thị dữ liệu
          Expanded(
            child: FutureBuilder<List<UserModel>>(
              future: _searchKeyword.isEmpty
                  ? dbService.getUsers()
                  : dbService.searchUsers(_searchKeyword),
              builder: (context, snapshot) {
                // Trạng thái chờ
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Danh sách rỗng
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No Users found', style: TextStyle(fontSize: 18, color: Colors.grey)),
                  );
                }

                // Danh sách có dữ liệu: Các thẻ Card màu vàng
                final List<UserModel> users = snapshot.data!;
                return ListView.builder(
                  itemCount: users.length,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return Card(
                      color: Colors.amber.shade100, // Thẻ Card màu vàng
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        title: Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('Age: ${user.age} \nEmail: ${user.email}'),
                        isThreeLine: true,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => _openUserForm(existingUser: user),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                // `deleteUser(id)`
                                await dbService.deleteUser(user.id);
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () => _openUserForm(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
