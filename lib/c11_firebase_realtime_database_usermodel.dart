class UserModel {
  final String id;
  final String name;
  final int age;
  final String email;

  UserModel({
    required this.id,
    required this.name,
    required this.age,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<dynamic, dynamic> map) {
    return UserModel(
      id: (map['id'] ?? '').toString(),
      name: (map['name'] ?? '').toString(),
      age: int.tryParse(map['age'].toString()) ?? 0,
      email: (map['email'] ?? '').toString(),
    );
  }
}
