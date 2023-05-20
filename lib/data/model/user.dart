class User {
  final int id;
  final String username;
  final String email;
  final String tel;
  final String role;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.tel,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      tel: json['tel'],
      role: json['role'],
    );
  }
}
