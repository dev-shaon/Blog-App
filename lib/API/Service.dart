import 'dart:convert';
import 'package:blog_app/API/Model/PostModel.dart';
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

  ///////for get Api
static Future<List<PostModel>> getPosts() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/posts"),
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final postsData = decoded['data']['posts'] as List;
        return postsData.map((json) => PostModel.fromJson(json)).toList();
      } else {
        throw Exception(
            "Failed to fetch posts: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
      return [];
    }
  }


}
