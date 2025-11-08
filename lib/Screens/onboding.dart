import 'package:blog_app/Screens/signin_Screen.dart';
import 'package:blog_app/Wigets/button_Wigets.dart';
import 'package:flutter/material.dart';

class Onboding extends StatefulWidget {
  const Onboding({super.key});

  @override
  State<Onboding> createState() => _OnbodingState();
}

class _OnbodingState extends State<Onboding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Image(
              image: AssetImage("assets/images/first.png"),
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "Welcome to Your Personal \nBlog Space",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 8,),
            Center(
              child: Text(
                "Discover articles, save your favorites, and engage \nwith the community.",
                style: TextStyle(color: Colors.grey, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 278,),
            CustomButton(text: "Get Started", onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SigninScreen()));
            })
          ],
        ),
      ),
    );
  }
}
