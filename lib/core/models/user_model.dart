class User {
  User({
    this.id,
    this.email,
    this.username,
    this.emailVerified,
    this.phoneNumberVerified
  });

  final String id;
  final String username;
  final String email;
  final bool emailVerified;
  final bool phoneNumberVerified;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["_id"],
      email: json["email"],
      username: json["username"],
      emailVerified: json["emailVerified"],
      phoneNumberVerified: json["phoneNumberVerified"],
    );
  }
}

