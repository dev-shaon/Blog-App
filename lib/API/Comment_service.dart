import 'dart:convert';
import 'package:blog_app/API/Model/Comment_Model.dart';
import 'package:http/http.dart' as http;

class CommentService {
  static const String baseUrl = "https://api.zhndev.site/wp-json/blog-app/v1";
  static String? token;

  // For Get Comments
  static Future<List<CommentModel>> getComments({required int postId}) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/comments/post/$postId"),
        headers: {
          "Content-Type": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final commentsData = decoded['data']['comments'] as List;
        return commentsData.map((json) => CommentModel.fromJson(json)).toList();
      } else {
        print("Failed to fetch comments: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Exception: $e");
      return [];
    }
  }

  //for Add Comment
  static Future<CommentModel?> addComment({
    required int postId,
    required String content,
    required String authorName,
    required String email,
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
          "author_name": authorName,
          "author_email": email,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = jsonDecode(response.body);
        return CommentModel.fromJson(decoded['data']['comment']);
      } else {
        print("Failed to add comment: ${response.statusCode}");
        print(response.body);
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }
}
