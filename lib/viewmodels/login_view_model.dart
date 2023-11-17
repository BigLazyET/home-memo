import 'package:flutter/material.dart';

class LoginViewModel with ChangeNotifier {
  String? userName;
  String? password;

  void setUserName(String value) {
    userName = value;
    notifyListeners();
  }

  bool login({required String userName, required String password}) {
    if (userName.isEmpty || password.isEmpty) {
      return false;
    }

    return true;
  }
}
