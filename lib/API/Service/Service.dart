import 'dart:convert';
import 'package:blog_app/API/Model/PostModel.dart';
import 'package:blog_app/API/Model/User_Profile.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://api.zhndev.site/wp-json/blog-app/v1";
  static String? token;

  //////////for Register
  static Future<void> postCall(
    String name,
    String email,
    String phone,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/register"),
        headers: {
          "Content-Type": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "name": name,
          "email": email,
          "phone": phone,
          "password": password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodeData = jsonDecode(response.body);
        print("Post successful: $decodeData");
      } else {
        print("Post failed: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception(
          "Post request failed with status ${response.statusCode}",
        );
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  /////////fon login
  static Future<void> loginUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/login"),
        headers: {
          "Content-Type": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        },
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        token = data["data"]["token"];
        print("Login Token Saved: $token");
      } else {
        print("Post failed: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception(
          "Post request failed with status ${response.statusCode}",
        );
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  ///////for get Api
  static Future<List<PostModel>> getPosts() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/posts"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = jsonDecode(response.body);
        final postsData = decoded['data']['posts'] as List;
        return postsData.map((json) => PostModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to fetch posts: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
      return [];
    }
  }

 //Get User Profile
static Future<UserProfile?> getProfile(String token) async {
  final url = Uri.parse("$baseUrl/user/profile");

  final response = await http.get(
    url,
    headers: {"Authorization": "Bearer $token"},
  );

  print("Profile Response: ${response.body}");

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);

    // Correct path to user object
    final userJson = jsonData["data"]["user"];

    return UserProfile.fromJson(userJson);
  } else {
    print("Failed to fetch profile: ${response.body}");
    return null;
  }
}




  // 🔹 Update User Profile
  static Future<bool> updateProfile({
    required String token,
    required String name,
    required String phone,
  }) async {
    final url = Uri.parse("$baseUrl/user/profile");

    final response = await http.put(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({"name": name, "phone": phone}),
    );

    return response.statusCode == 200;
  }
}