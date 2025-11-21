import 'package:blog_app/API/Service/Service.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String? _token;


  String? get userToken => _token;


  Future<bool> loginUser(String email, String password) async {

    final success = await ApiService.loginUser(email, password);

    if (success) {
      _token = ApiService.token; 
      notifyListeners();
      return true;
    }
    return false;
  }
  
  void logout() {
    _token = null;
    notifyListeners();
  }
}
