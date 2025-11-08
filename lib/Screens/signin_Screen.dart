import 'package:blog_app/Screens/signUp_Screen.dart';
import 'package:blog_app/Wigets/textField_wiget.dart';
import 'package:blog_app/wigets/button_Wigets.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign in", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 40),
              Center(
                child: Text(
                  "Welcome Back!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 14),
              Textfield(text: 'Email  or username'),
              SizedBox(height: 14),
              Textfield(text: 'Password'),
              SizedBox(height: 50),
              CustomButton(text: "Sign in", onPressed: () {}),
              SizedBox(height: 350),
              Text(
                "Don't have an account?",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(height: 6),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupScreen()),
                  );
                },
                child: Text("Sign up", style: TextStyle(color: Colors.grey)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
