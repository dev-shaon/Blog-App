import 'package:blog_app/API/Provider/Provider.dart';
import 'package:blog_app/API/Service/Comment_service.dart';
import 'package:blog_app/API/Service/Service.dart';
import 'package:blog_app/Screens/BottomNav_Screens.dart';
import 'package:blog_app/Screens/signUp_Screen.dart';
import 'package:blog_app/Wigets/textField_wiget.dart';
import 'package:blog_app/wigets/button_Wigets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
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
              SizedBox(height: 30),
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
              CustomTextfield(
                controller: emailController,
                text: 'Email or username',
              ),
              SizedBox(height: 14),
              CustomTextfield(
                controller: passController,
                text: 'Password',
                obscureText: true,
              ),
              SizedBox(height: 50),
              CustomButton(
                text: "Sign in",
                onPressed: () async {
                  if (emailController.text.isEmpty ||
                      passController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please fill all fields")),
                    );
                    return;
                  }

                  final success = await auth.loginUser(
                    emailController.text.trim(),
                    passController.text.trim(),
                  );

                  if (!mounted) return;

                  if (success) {
                    CommentService.token = ApiService.token;

                    //token Save in SharedPreferences.
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setString("token", ApiService.token!);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green,
                        content: Text("Login Successful"),
                      ),
                    );

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => BottomNavScreens()),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text("Login Failed"),
                        content: Text("Email or password is incorrect"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("OK"),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),

              Spacer(),
              
              Text(
                "Don't have an account?",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
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
