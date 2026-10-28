class UserModel {
  final String id;
  final String name;
  final int age;
  final String email;

  UserModel({required this.id, required this.name, required this.age, required this.email});

  // Chuyển Object thành Map để sử dụng với SQL Helper (insert, update)
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'age': age, 'email': email};
  }

  // Chuyển Map từ SQL Helper (query) đọc lên thành Object UserModel
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      name: map['name'] as String,
      age: map['age'] as int,
      email: map['email'] as String,
    );
  }
}
