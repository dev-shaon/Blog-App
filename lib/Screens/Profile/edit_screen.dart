
import 'package:blog_app/API/Service/Service.dart';
import 'package:blog_app/Wigets/button_Wigets.dart';
import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  final String currentName;
  final String currentEmail;

  const EditScreen({
    super.key,
    required this.currentName,
    required this.currentEmail,
  });

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.currentName);
    emailController = TextEditingController(text: widget.currentEmail);
  }

  Future<void> saveProfile() async {
    setState(() => isLoading = true);

    final success = await ApiService.updateProfile(
      token: ApiService.token!,
      name: nameController.text,
      phone: "", // API requires phone, keep empty or add field
    );

    setState(() => isLoading = false);

    if (success) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Profile updated successfully")));
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Failed to update profile")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 10),
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("assets/images/boyprofile.png"),
              ),
            ),
            SizedBox(height: 22),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Name",
                filled: true,
                fillColor: Colors.grey[800],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                filled: true,
                fillColor: Colors.grey[800],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            SizedBox(height: 50),
            isLoading
                ? CircularProgressIndicator()
                : CustomButton(
                    text: "Save Changes",
                    onPressed: saveProfile,
                  ),
          ],
        ),
      ),
    );
  }
}
