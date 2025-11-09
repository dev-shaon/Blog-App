import 'package:blog_app/Screens/Bookmarks_Screen.dart';
import 'package:blog_app/Screens/Home_Screen.dart';
import 'package:flutter/material.dart';

class BottomNavScreens extends StatefulWidget {
  const BottomNavScreens({super.key});

  @override
  State<BottomNavScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<BottomNavScreens> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    HomeScreen(),
    BookmarksScreen(),
    Center(child: Text("hujhh")),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 72, 71, 71),
        fixedColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex=index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home,size: 30,), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.bookmarks_outlined,size: 30), label: "bookmarks"),
          BottomNavigationBarItem(icon: Icon(Icons.person,size: 30), label: "Profile"),
        ],
      ),
    );
  }
}
