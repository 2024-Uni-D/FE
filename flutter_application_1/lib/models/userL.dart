class UserL {
  final String userId;
  final String password;

  UserL({
    required this.userId,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'password': password,
    };
  }
}
