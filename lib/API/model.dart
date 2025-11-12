class UserModel {
  final String name;
  final String email;
  final String phone;
  final String password;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    };
  }
}

// Separate PostModel class
class PostModel {
  final String title;
  final String excerpt;
  final String technology;
  final String avatar;

  PostModel({
    required this.title,
    required this.excerpt,
    required this.technology,
    required this.avatar,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      title: json['title'] ?? '',
      excerpt: json['excerpt'] ?? '',
      technology: (json['categories'] as List).join(', '), // categories list to string
      avatar: json['author'] != null ? json['author']['avatar'] ?? '' : '',
    );
  }
}
