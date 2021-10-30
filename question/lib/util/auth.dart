import 'package:flutter/cupertino.dart';

class UserAuthentication extends ChangeNotifier{
  bool _isAuthenticated = false;

  bool get isAuthenticated {
    return this._isAuthenticated;
  }

  set isAuthenticated(bool newVal) {
    this._isAuthenticated = newVal;
    this.notifyListeners();
  }
}