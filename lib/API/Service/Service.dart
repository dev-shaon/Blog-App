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
  static Future<bool> loginUser(String email, String password) async {
  try {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data["success"] == true && data["data"]["token"] != null) {
        token = data["data"]["token"];
        return true; 
      } else {
        return false;
      }
    } else {
      return false;
    }
  } catch (e) {
    print("Login Exception: $e");
    return false;
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

  //////for Get User Profile
  static Future<UserProfile?> getProfile(String token) async {
    final url = Uri.parse("$baseUrl/user/profile");

    final response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );

    print("Profile Response: ${response.body}");

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      final userJson = jsonData["data"]["user"];

      return UserProfile.fromJson(userJson);
    } else {
      print("Failed to fetch profile: ${response.body}");
      return null;
    }
  }

  //for Update User Profile
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

  //for Change Password
static Future<Map<String, dynamic>> changePassword({
  required String currentPassword,
  required String newPassword,
}) async {
  final url = Uri.parse("$baseUrl/user/change-password");

  try {
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "current_password": currentPassword,
        "new_password": newPassword,
      }),
    );

    print("Change Password Response: ${response.body}");

    final decoded = jsonDecode(response.body);

    return {
      "success": decoded["success"] ?? false,
      "message": decoded["message"] ?? "Something went wrong",
    };
  } catch (e) {
    print("Exception: $e");
    return {
      "success": false,
      "message": "Failed to change password",
    };
  }
}

//for logout

static Future<bool> logout(String token) async {
  final url = Uri.parse("$baseUrl/auth/logout");

  final response = await http.post(
    url,
    headers: {
      "Authorization": "Bearer $token",
    },
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    return true;
  } else {
    return false;
  }
}



}
