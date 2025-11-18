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
    final user = json["data"]["user"];

    return UserProfile(
      id: user["id"],
      name: user["name"],
      email: user["email"],
      phone: user["phone"],
      registeredDate: user["registered_date"],
    );
  }
}
