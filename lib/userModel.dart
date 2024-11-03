// user_model.dart
class User {
  final int id;
  final String name;
  final String email;
  final String profileImage;
  final String birthDate;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImage,
    required this.birthDate,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['firstName'] + ' ' + json['lastName'],
      email: json['email'],
      profileImage: json['image'],
      birthDate: json['birthDate'], // Expecting "yyyy-mm-dd" format
    );
  }
}
