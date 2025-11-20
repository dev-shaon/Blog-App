import 'package:blog_app/API/Service/Service.dart';
import 'package:blog_app/Wigets/button_Wigets.dart';
import 'package:blog_app/Wigets/textField_wiget.dart';
import 'package:flutter/material.dart';

class UpdatePassScreen extends StatefulWidget {
  const UpdatePassScreen({super.key});

  @override
  State<UpdatePassScreen> createState() => _UpdatePassScreenState();
}

class _UpdatePassScreenState extends State<UpdatePassScreen> {
  final TextEditingController currentPassController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  bool isLoading = false;

  void showMessage(String title, String msg) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  void updatePassword() async {
    final current = currentPassController.text.trim();
    final newPass = newPassController.text.trim();
    final confirm = confirmPassController.text.trim();

    if (current.isEmpty || newPass.isEmpty || confirm.isEmpty) {
      return showMessage("Error", "Please fill all fields");
    }

    if (newPass != confirm) {
      return showMessage("Error", "New password and confirm password do not match");
    }

    if (ApiService.token == null) {
      return showMessage("Error", "User not logged in");
    }

    setState(() => isLoading = true);

    final result = await ApiService.changePassword(
      currentPassword: current,
      newPassword: newPass,
    );

    setState(() => isLoading = false);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(result["success"] ? "Success" : "Error"),
        content: Text(result["message"] ?? "Something went wrong"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (result["success"]) Navigator.pop(context);
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    currentPassController.dispose();
    newPassController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Update Password",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text("Current Password", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 12),
              CustomTextfield(controller: currentPassController, text: "Enter your current password", obscureText: true),

              const SizedBox(height: 16),
              const Text("New Password", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 12),
              CustomTextfield(controller: newPassController, text: "Enter your new password", obscureText: true),

              const SizedBox(height: 16),
              const Text("Confirm New Password", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 12),
              CustomTextfield(controller: confirmPassController, text: "Confirm your new password", obscureText: true),

              const SizedBox(height: 30),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButton(text: "Update Password", onPressed: updatePassword),
            ],
          ),
        ),
      ),
    );
  }
}
