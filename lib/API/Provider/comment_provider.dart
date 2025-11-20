import 'package:blog_app/API/Service/Service.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String? _token;

  // এই getter টা যোগ করো
  String? get userToken => _token;

  // লগইন করার সময় টোকেন সেভ করো
  Future<bool> loginUser(String email, String password) async {
    // তোমার API কল...
    final success = await ApiService.loginUser(email, password);

    if (success) {
      _token = ApiService.token;   // অথবা যেখান থেকে টোকেন আসছে সেখান থেকে
      notifyListeners();
      return true;
    }
    return false;
  }

  // লগআউট করলে টোকেন ক্লিয়ার করো (অপশনাল)
  void logout() {
    _token = null;
    notifyListeners();
  }
}
