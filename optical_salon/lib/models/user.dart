class User {
  int id;
  String name;
  String phone;
  String email;
  String password;
  List<User> userConsultations = [];

  User({this.id, this.name, this.phone, this.email, this.password});

  User.profile(this.id, this.name, this.phone, this.email,
      this.userConsultations);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        phone: json['phone'],
        email: json['email'],
        password: json['password']);
  }
}
