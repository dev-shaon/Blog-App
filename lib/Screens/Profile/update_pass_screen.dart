// import 'package:blog_app/API/Service/Service.dart';
// import 'package:blog_app/Wigets/button_Wigets.dart';
// import 'package:blog_app/Wigets/textField_wiget.dart';
// import 'package:flutter/material.dart';

// class UpdatePassScreen extends StatefulWidget {
//   const UpdatePassScreen({super.key});

//   @override
//   State<UpdatePassScreen> createState() => _UpdatePassScreenState();
// }

// class _UpdatePassScreenState extends State<UpdatePassScreen> {
//   final TextEditingController currentPassController = TextEditingController();
//   final TextEditingController newPassController = TextEditingController();
//   final TextEditingController confirmPassController = TextEditingController();
//   bool isLoading = false;

//   void updatePassword() async {
//     final current = currentPassController.text.trim();
//     final newPass = newPassController.text.trim();
//     final confirm = confirmPassController.text.trim();

//     if (current.isEmpty || newPass.isEmpty || confirm.isEmpty) {
//       showDialog(
//         context: context,
//         builder: (_) => AlertDialog(
//           title: Text("Error"),
//           content: Text("Please fill all fields"),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text("OK"),
//             ),
//           ],
//         ),
//       );
//       return;
//     }

//     if (newPass != confirm) {
//       showDialog(
//         context: context,
//         builder: (_) => AlertDialog(
//           title: Text("Error"),
//           content: Text("New password and confirm password do not match"),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text("OK"),
//             ),
//           ],
//         ),
//       );
//       return;
//     }

//     if (ApiService.token == null) {
//       showDialog(
//         context: context,
//         builder: (_) => AlertDialog(
//           title: Text("Error"),
//           content: Text("User not logged in"),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text("OK"),
//             ),
//           ],
//         ),
//       );
//       return;
//     }

//     setState(() => isLoading = true);

//     final result = await ApiService.changePassword(
//       currentPassword: current,
//       newPassword: newPass,
//     );

//     setState(() => isLoading = false);

//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text(result["success"] ? "Success" : "Error"),
//         content: Text(result["message"]),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               if (result["success"]) Navigator.pop(context);
//             },
//             child: Text("OK"),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Update Password",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             children: [
//               SizedBox(height: 16),
//               Text("Current Password", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//               SizedBox(height: 12),
//               CustomTextfield(controller: currentPassController, text: "Enter your current password", obscureText: true),
//               SizedBox(height: 16),
//               Text("New Password", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//               SizedBox(height: 12),
//               CustomTextfield(controller: newPassController, text: "Enter your new password", obscureText: true),
//               SizedBox(height: 16),
//               Text("Confirm New Password", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//               SizedBox(height: 12),
//               CustomTextfield(controller: confirmPassController, text: "Confirm your new password", obscureText: true),
//               SizedBox(height: 30),
//               isLoading
//                   ? CircularProgressIndicator()
//                   : CustomButton(text: "Update Password", onPressed: updatePassword),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
