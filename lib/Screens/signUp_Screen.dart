import 'package:blog_app/API/Provider.dart';
import 'package:blog_app/API/model.dart';
import 'package:blog_app/Screens/signin_Screen.dart';
import 'package:blog_app/Wigets/button_Wigets.dart';
import 'package:blog_app/Wigets/textField_wiget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController UsernameController = TextEditingController();
  final TextEditingController EmailController = TextEditingController();
  final TextEditingController PhoneController = TextEditingController();
  final TextEditingController PasswordController = TextEditingController();
  final TextEditingController CPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
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
            CustomTextfield(controller: UsernameController, text: 'username'),
            SizedBox(height: 16),

            Text(
              "E-mail",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            CustomTextfield(
              controller: EmailController,
              text: 'enter your email',
            ),
            SizedBox(height: 16),

            Text(
              "Phone Number",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            CustomTextfield(
              controller: PhoneController,
              text: 'enter your Number',
            ),
            SizedBox(height: 16),

            Text(
              "Password",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            CustomTextfield(
              controller: PasswordController,
              text: 'enter your password',
            ),
            SizedBox(height: 16),

            Text(
              "Confirm Password",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            CustomTextfield(
              controller: CPasswordController,
              text: 'Confirm your Password',
            ),
            SizedBox(height: 30),

            Center(
              child: CustomButton(
                text: "Register",
                onPressed: () async {
                  if (UsernameController.text.isEmpty ||
                      EmailController.text.isEmpty ||
                      PhoneController.text.isEmpty ||
                      PasswordController.text.isEmpty ||
                      CPasswordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please fill all fields")),
                    );
                    return;
                  }

                  // Password match varification
                  if (PasswordController.text != CPasswordController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Passwords do not match")),
                    );
                    return;
                  }
                  final success = await auth.submit(
                    UserModel(
                      name: UsernameController.text,
                      email: EmailController.text,
                      password: PasswordController.text,
                      phone: PhoneController.text,
                    ),
                  );

                  if (success) {
                  // If success, then show message & navigate to next screen
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("User Posted Successfully")),
                    );

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SigninScreen()),
                    );
                  } else {
                    ///////////////// If failure,then show error message
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("Failed to Post")));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
