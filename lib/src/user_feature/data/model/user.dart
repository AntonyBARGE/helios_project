/// A placeholder class that represents an entity or model.
class User {
  final String name;
  final String email;
  final String pictureUrl;

  User({required this.name, required this.email, required this.pictureUrl});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: "${json['name']['first']} ${json['name']['last']}",
      email: json['email'],
      pictureUrl: json['picture']['thumbnail'],
    );
  }
}
