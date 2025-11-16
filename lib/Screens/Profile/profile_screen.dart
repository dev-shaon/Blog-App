import 'package:blog_app/Screens/Details_screen.dart';
import 'package:blog_app/Screens/Profile/edit_screen.dart';
import 'package:blog_app/Screens/Profile/update_pass_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 10),
              Center(
                child: Image(image: AssetImage("assets/images/boyprofile.png")),
              ),
              SizedBox(height: 14),
              Text(
                "Ethan Carter",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              Text(
                "ethan.carter@email.com \nSoftware Engineer",
                style: TextStyle(color: Colors.grey, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 18),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 56,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding:  EdgeInsets.all(14),
                    child: Row(
                      children: [
                        Container(
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 80, 80, 80), 
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child:  Icon(Icons.edit, color: Colors.white),
                        ),
                         SizedBox(width: 16),
                         Text(
                          "Edit Profile",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 6,),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdatePassScreen()));
                },
                child: Container(
                  height: 56,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding:  EdgeInsets.all(14),
                    child: Row(
                      children: [
                        Container(
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 80, 79, 79), 
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child:  Icon(Icons.lock, color: Colors.white),
                        ),
                         SizedBox(width: 16),
                         Text(
                          "Update Password",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 240,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  minimumSize: Size(358, 40),
                  backgroundColor: const Color.fromARGB(255, 37, 47, 52)
                ),
                
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen()));
                }, 
              child: Text("Logout"))
            ],
          ),
        ),
      ),
    );
  }
}
