import 'package:blog_app/API/Service.dart';
import 'package:blog_app/API/model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  bool isLoading = false;

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
}
