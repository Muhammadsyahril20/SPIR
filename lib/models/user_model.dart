class UserModel {
  final int id;
  final String name;
  final String phoneNumber;

  UserModel({required this.id, required this.name, required this.phoneNumber});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
    );
  }
}
