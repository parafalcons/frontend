// User Model Class
class User {
  final String? fullName;
  final String? userName;
  final String? phoneNumber;
  final String? email;
  final String? token;

  User({
    this.fullName,
    this.userName,
    this.phoneNumber,
    this.email,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullName: json['fullName'] as String?,
      userName: json['userName'] as String?,
      phoneNumber: json['phoneNumber']?.toString(),
      email: json['email'] as String?,
      token: json['token'] as String?,
    );
  }
}
