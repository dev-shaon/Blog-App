class PostModel {
  final String title;
  final String excerpt;
  final String technology;
  final String featuredImage;
  final String content; 

  PostModel({
    required this.title,
    required this.excerpt,
    required this.technology,
    required this.featuredImage,
    required this.content,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      title: json['title'] ?? '',
      excerpt: json['excerpt'] ?? '',
      technology: json['categories'] is List
          ? (json['categories'] as List).join(', ')
          : '',
      featuredImage: json['featured_image'] ?? '',
      content: json['content'] ?? '',
    );
  }
}
