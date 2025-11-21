class CommentModel {
  final String id;           
  final String postId;       
  final String userId;       
  final String parentId;     
  final String content;
  final String authorName;
  final String createdAt;

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
      id: json['id'].toString(),                   
      postId: json['post_id'].toString(),           
      userId: json['user_id'].toString(),           
      parentId: json['parent_id'].toString(),      
      content: json['content'] ?? '',
      authorName: json['author_name'] ?? json['author']?['name'] ?? 'Unknown',
      createdAt: json['created_at'] ?? '',
    );
  }
}