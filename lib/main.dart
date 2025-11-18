import 'package:blog_app/API/Provider/Provider.dart';
import 'package:blog_app/API/Provider/bookmark_provider.dart';
import 'package:blog_app/Screens/onboding.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => BookmarkProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      home: const Onboding(),
      debugShowCheckedModeBanner: false,
    );
  }
}
