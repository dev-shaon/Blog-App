import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://api.zhndev.site/wp-json/blog-app/v1/auth/";
  static String? token;

  static Future<void> postCall(
    String endpoint,
    String name,
    String email,
    String password,
    int age,
    bool isActive,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl$endpoint"),
        headers: <String, String>{
          "Content-Type": "application/json",
           "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
          "age": age,
          "isActive": isActive,
        }),
      );

      if (response.statusCode == 201) {
        final decodeData = jsonDecode(response.body);
        print("Post successful: $decodeData");
      } else {
        print("Post failed: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception("Post request failed with status ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }
}
