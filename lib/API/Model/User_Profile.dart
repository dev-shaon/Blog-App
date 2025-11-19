class UserProfile {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String registeredDate;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.registeredDate,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      phone: json["phone"] ?? "",
      registeredDate: json["registered_date"] ?? "",
    );
  }
}
