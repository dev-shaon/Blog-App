import 'package:blog_app/API/Model/User_Profile.dart';
import 'package:blog_app/API/Service/Service.dart';
import 'package:blog_app/Screens/Profile/edit_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserProfile? userProfile;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    // Check if token exists
    if (ApiService.token == null) {
      print("Token is null. User not logged in!");
      setState(() {
        isLoading = false;
        userProfile = null;
      });
      return;
    }

    setState(() => isLoading = true);
    final profile = await ApiService.getProfile(ApiService.token!);
    setState(() {
      userProfile = profile;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : userProfile == null
              ? Center(
                  child: Text(
                    "Failed to load profile",
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage("assets/images/boyprofile.png"),
                        ),
                      ),
                      SizedBox(height: 14),
                      Text(
                        userProfile!.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      Text(
                        userProfile!.email,
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 18),
                      InkWell(
                        onTap: () async {
                          final updated = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditScreen(
                                currentName: userProfile!.name,
                                currentEmail: userProfile!.email,
                              ),
                            ),
                          );

                          if (updated == true) {
                            fetchUserProfile();
                          }
                        },
                        child: Container(
                          height: 56,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey[800]),
                          child: Padding(
                            padding: EdgeInsets.all(14),
                            child: Row(
                              children: [
                                Icon(Icons.edit, color: Colors.white),
                                SizedBox(width: 16),
                                Text(
                                  "Edit Profile",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}