class LoginRequestModel {
  final String email;
  final String senha;

  LoginRequestModel({required this.email, required this.senha});

  Map<String, dynamic> toJson() => {
        'email': email,
        'senha': senha,
      };
}

class UserModel {
  final int id;
  final String name;
  final String email;
  final String role;
  final int? branchId;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.branchId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      branchId: json['branchId'] != null ? json['branchId'] as int : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'branchId': branchId,
    };
  }
}
