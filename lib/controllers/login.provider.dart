import 'package:flutter/material.dart';

//permettre de simuler ma connexion ceci permet decouter connexion deconnexion et averti le main pour afficher ou non le mainscreen
class LoginProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  void login() {
    _isLoggedIn = true;
    notifyListeners();
  }
  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}