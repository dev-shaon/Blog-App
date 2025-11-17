import 'package:flutter/material.dart';
import 'package:blog_app/API/Model/PostModel.dart';

class DetailsScreen extends StatelessWidget {
  
  final PostModel post;

  const DetailsScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.bookmark_add, size: 30),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              post.featuredImage,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              post.title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(
                        "assets/images/girlprofile.png",
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Author",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Olivia Harper",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            // Text(
            //   'Technology: ${post.technology}',
            //   style: TextStyle(fontWeight: FontWeight.bold),
            // ),
            SizedBox(height: 16),
            Text(post.excerpt, style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
                Text("123"),
                SizedBox(width: 20),
                IconButton(onPressed: () {}, icon: Icon(Icons.comment)),
                Text("45"),
              ],
            ),
            SizedBox(height: 16),
            Text(
              "Comments",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: AssetImage("assets/images/boyprofile.png"),
                  height: 50,
                ),
                SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Liam Walker",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 6),
                          Text(
                            "2d",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 6),

                      Text(
                        "Great article! I'm particularly interested in the section on renewable energy. Do you have any recommendations for further reading on the topic?",
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: AssetImage("assets/images/girlprofile.png"),
                  height: 50,
                ),
                SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Liam Walker",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 6),
                          Text(
                            "1d",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 6),

                      Text(
                        "Thanks for your feedback, Liam! I'd recommend checking out the latest reports from the International Renewable Energy Agency (IRENA) for comprehensive data and insights.",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      //bottomNavigationBar comment section create kora
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage("assets/images/girlprofile.png"),
              ),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.send, color: Colors.white),
                    ),
                    hintText: "Write a comment...",
                    filled: true,
                    fillColor: Colors.blueGrey,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
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
