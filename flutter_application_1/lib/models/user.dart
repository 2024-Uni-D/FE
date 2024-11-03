import 'dart:convert';

class User {
  final String userId;
  final String password;
  final String? name;
  final String? birthday;
  final String gender;

  User({
    required this.userId,
    required this.password,
    this.name,
    this.birthday,
    this.gender = 'male', // gender 기본값을 'male'로 설정
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'password': password,
      'gender': gender, // 항상 포함되는 gender 필드
      if (name != null) 'name': name,
      if (birthday != null) 'birthday': birthday,
    };
  }
}
