import 'dart:convert';
import 'package:blog_app/API/Model/Comment_Model.dart';
import 'package:http/http.dart' as http;

class CommentService {
  static const String baseUrl = "https://api.zhndev.site/wp-json/blog-app/v1";
  static String? token; 

  // Fetch comments
  static Future<List<CommentModel>> getComments({required int postId}) async {
  try {
    print("Token আছে কি না: ${CommentService.token}"); // এটা দেখো

    final response = await http.get(
      Uri.parse("$baseUrl/comments/post/$postId"),
      headers: {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      },
    );

    print("Status Code: ${response.statusCode}");
    print("Full Comments API Response: ${response.body}");

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      List<dynamic> commentsData = [];

      if (decoded['data'] is List) {
        commentsData = decoded['data'];
      } else if (decoded['data']?['comments'] is List) {
        commentsData = decoded['data']['comments'];
      }

      return commentsData.map((json) => CommentModel.fromJson(json)).toList();
    } else {
      return [];
    [];
    }
  } catch (e) {
    print("Error fetching comments: $e");
    return [];
  }
}

  // Add comment
  static Future<CommentModel?> addComment({
    required int postId,
    required String content,
    String? authorName,
    String? authorEmail,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/comments"),
        headers: {
          "Content-Type": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "post_id": postId,
          "content": content,
          "parent_id": 0,
          if (authorName != null) "author_name": authorName,
          if (authorEmail != null) "author_email": authorEmail,
        }),
      );

      print("Add Comment Response: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = jsonDecode(response.body);
        return CommentModel.fromJson(decoded['data']['comment']);
      } else {
        print("Failed to add comment: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }
}
