import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import '../models/user.dart';
class UserProvider with ChangeNotifier{
  User? _user;
  //not keeping user private may cause random bugs in the app!
  final AuthMethods _authMethods = AuthMethods();
  Future<void> refreshUser() async{
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }

  User get getUser => _user!;
}