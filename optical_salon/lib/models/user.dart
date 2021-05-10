class User {
  final String name;
  final String phone;
  final String email;
  final String password;

  User({this.name, this.phone, this.email, this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        name: json['name'],
        phone: json['phone'],
        email: json['email'],
        password: json['password']);
  }
}
