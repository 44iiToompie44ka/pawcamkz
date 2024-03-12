

import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String _username = '';
  String _email = '';

  bool get isLoggedIn => _isLoggedIn;
  String get username => _username;
  String get email => _email;



  void setLoginStatus(bool status, String username, String email) {
    _isLoggedIn = status;
    _username = username;
    _email = email;
    notifyListeners();
  }

  void updateUserData(String username, String email) {
    if (_isLoggedIn == false){
      _username = 'Гость';
    }
    else{
      _username = username;
    }
    _email = email;
    notifyListeners();
  }
}
