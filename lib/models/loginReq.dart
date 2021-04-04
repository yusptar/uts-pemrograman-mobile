import 'dart:async';
import 'package:uts/dbhelper/dbhelper.dart';
import 'package:uts/models/login.dart';

class LoginRequest {
  DbHelper dbh = new DbHelper();
  Future<Login> getLogin(String username, String password) {
    var result = dbh.getLogin(username, password);
    return result;
  }
}
