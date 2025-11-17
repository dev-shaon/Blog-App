class CommentModel {
  final int id;
  final int postId;
  final int userId;
  final int parentId;
  final String content;
  final int likesCount;
  final String createdAt;
  final String updatedAt;
  final List<CommentModel> replies;
  final bool isLiked;
  final String authorName;

  CommentModel({
    required this.id,
    required this.postId,
    required this.userId,
    required this.parentId,
    required this.content,
    required this.likesCount,
    required this.createdAt,
    required this.updatedAt,
    required this.replies,
    required this.isLiked,
    required this.authorName,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    var repliesFromJson = json['replies'] as List? ?? [];
    List<CommentModel> replyList = repliesFromJson.map((r) => CommentModel.fromJson(r)).toList();

    return CommentModel(
      id: json['id'] ?? 0,
      postId: json['post_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      parentId: json['parent_id'] ?? 0,
      content: json['content'] ?? '',
      likesCount: json['likes_count'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      replies: replyList,
      isLiked: json['is_liked'] ?? false,
      authorName: json['author'] != null ? json['author']['name'] : 'Unknown',
    );
  }
}
