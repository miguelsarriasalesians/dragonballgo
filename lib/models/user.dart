class User {
  final String email;
  final String name;
  final String birthdate;

  User(this.email, this.name, this.birthdate);

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        birthdate = json['birthdate'];

  Map<String, dynamic> toJson() =>
      {'email': email, 'name': name, 'birthdate': birthdate};
}
