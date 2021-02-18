class User {
  final String email;
  final String name;
  final String birthdate;

  User(this.email, this.name, this.birthdate);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['email'],
      json['name'],
      json['birthdate'],
    );
  }

  Map<String, dynamic> toJson() =>
      {'email': email, 'name': name, 'birthdate': birthdate};
}
