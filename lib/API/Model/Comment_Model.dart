class CommentModel {
  final String id;           // আগে int ছিল → এখন String
  final String postId;       // আগে int ছিল → এখন String
  final String userId;       // আগে int ছিল → এখন String
  final String parentId;     // আগে int ছিল → এখন String
  final String content;
  final String authorName;
  final String createdAt;
  // অন্যান্য ফিল্ড থাকলে রাখো (likes_count, is_liked ইত্যাদি)

  CommentModel({
    required this.id,
    required this.postId,
    required this.userId,
    required this.parentId,
    required this.content,
    required this.authorName,
    required this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'].toString(),                    // String-এ কনভার্ট
      postId: json['post_id'].toString(),           // String-এ কনভার্ট
      userId: json['user_id'].toString(),           // String-এ কনভার্ট
      parentId: json['parent_id'].toString(),       // String-এ কনভার্ট
      content: json['content'] ?? '',
      authorName: json['author_name'] ?? json['author']?['name'] ?? 'Unknown',
      createdAt: json['created_at'] ?? '',
    );
  }
}