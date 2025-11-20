import 'package:blog_app/API/Service/Service.dart';
import 'package:blog_app/API/Model/UserModel.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  bool isLoading = false;

  // Registration method
  Future<bool> submit(UserModel user) async {
    try {
      isLoading = true;
      notifyListeners();

      await ApiService.postCall(
        user.name,
        user.email,
        user.phone,
        user.password,
      );

      return true;
    } catch (e) {
      print("Submit error: $e");
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Login method
  Future<bool> loginUser(String email, String password) async {
    try {
      // Call APIService loginUser
      final success = await ApiService.loginUser(email, password);
      return success; // true or false depending on login
    } catch (e) {
      print("Login error: $e");
      return false;
    }
  }
}
