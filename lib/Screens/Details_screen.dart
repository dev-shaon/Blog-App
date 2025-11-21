import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blog_app/API/Provider/bookmark_provider.dart';
import 'package:blog_app/API/Service/Comment_service.dart';
import 'package:blog_app/API/Model/Comment_Model.dart';
import 'package:blog_app/API/Model/PostModel.dart';

class DetailsScreen extends StatefulWidget {
  final PostModel post;

  const DetailsScreen({super.key, required this.post});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<CommentModel> comments = [];
  bool isLoading = true;
  final TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchComments();
  }

  // Fetch comments from API
  Future<void> fetchComments() async {
    setState(() => isLoading = true);
    comments = await CommentService.getComments(postId: widget.post.id);
    setState(() => isLoading = false);
  }

  // Post a new comment
  Future<void> postComment() async {
    final content = commentController.text.trim();
    if (content.isEmpty) return;

    // Token check
    if (CommentService.token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("You must be logged in to comment")),
      );
      return;
    }

    final newComment = await CommentService.addComment(
      postId: widget.post.id,
      content: content,
    );

    if (newComment != null) {
      setState(() {
        comments.insert(0, newComment); // Show new comment at top
        commentController.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to post comment")),
      );
    }
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookmarkProvider = Provider.of<BookmarkProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Post Details"),
        actions: [
          IconButton(
            onPressed: () {
              bookmarkProvider.toggleBookmark(widget.post);
            },
            icon: Icon(
              bookmarkProvider.isBookmarked(widget.post)
                  ? Icons.bookmark
                  : Icons.bookmark_add,
              size: 30,
              color: bookmarkProvider.isBookmarked(widget.post)
                  ? Colors.red
                  : Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Post Image
            Image.network(
              widget.post.featuredImage,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            // Post Title
            Text(
              widget.post.title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            // Author info
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage("assets/images/girlprofile.png"),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Author",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Olivia Harper",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(widget.post.excerpt, style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
                Text("123"),
                SizedBox(width: 20),
                IconButton(onPressed: () {}, icon: Icon(Icons.comment)),
                Text("${comments.length}"),
              ],
            ),
            SizedBox(height: 16),
            Text(
              "Comments",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 16),
                                     //--> Loading indicator
            if (isLoading)
              Center(child: CircularProgressIndicator())
            else
              // Comment list
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  final comment = comments[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/boyprofile.png"),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(comment.authorName,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(height: 4),
                              Text(comment.content),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      ),
      // Bottom comment input
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage("assets/images/girlprofile.png"),
              ),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: commentController,
                  decoration: InputDecoration(
                    hintText: "Write a comment...",
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: postComment,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
