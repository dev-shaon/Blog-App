import 'package:blog_app/Screens/BottomNav_Screens.dart';
import 'package:blog_app/Wigets/button_Wigets.dart';
import 'package:blog_app/Wigets/textField_wiget.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Account",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              "Username",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            CustomTextfield(text: 'username'),
            SizedBox(height: 16),
            Text(
              "E-mail",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            CustomTextfield(text: 'enter your email'),
            SizedBox(height: 16),
            Text(
              "Password",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            CustomTextfield(text: 'enter your password'),
            SizedBox(height: 16),
            Text(
              "Confirm Password",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            CustomTextfield(text: 'Confirm your Password'),
            SizedBox(height: 30),
            Center(child: CustomButton(text: "Register", onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavScreens()));
            })),
          ],
        ),
      ),
    );
  }
}
