import 'package:flutter/material.dart';
import 'package:blog_app/API/Model/PostModel.dart';

class BookmarkProvider extends ChangeNotifier {
  List<PostModel> _bookmarks = [];

  List<PostModel> get bookmarks => _bookmarks;

  // bookmark add/remove toggle
  void toggleBookmark(PostModel post) {
    if (isBookmarked(post)) {
      _bookmarks.removeWhere((p) => p.id == post.id);
    } else {
      _bookmarks.add(post);
    }
    notifyListeners();
  }

  bool isBookmarked(PostModel post) {
    return _bookmarks.any((p) => p.id == post.id);
  }
}
