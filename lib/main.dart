import 'package:blog_app/API/Provider/Provider.dart';
import 'package:blog_app/API/Provider/bookmark_provider.dart';
import 'package:blog_app/API/Service/Service.dart';
import 'package:blog_app/Screens/onboding.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  ApiService.token = prefs.getString("token");

  runApp(
    MultiProvider(
      providers: [

        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => BookmarkProvider()),
        
      ],
      child: BlogApp(),
    ),
  );
}

class BlogApp extends StatelessWidget {
  const BlogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      home: const Onboding(),
      debugShowCheckedModeBanner: false,
    );
  }
}
