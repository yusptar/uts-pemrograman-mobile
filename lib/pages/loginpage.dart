import 'package:flutter/material.dart';
import 'package:uts/dbhelper/dbhelper.dart';
import 'package:uts/pages/home.dart';
import 'package:uts/models/login.dart';
import 'package:uts/models/loginResp.dart';
import 'package:uts/main.dart';
import 'package:uts/pages/registerpage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginCallBack {
  DbHelper dbHelper = DbHelper();
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String _username, _password;

  LoginResponse _response;

  _LoginPageState() {
    _response = new LoginResponse(this);
  }

  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _response.doLogin(usernameController.text, passwordController.text);
      });
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "RS POLINEMA",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        key: scaffoldKey,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 150),
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Text("RS POLINEMA",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50)),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: usernameController,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'Username',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: passwordController,
                autofocus: false,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4),
              child: Material(
                shadowColor: Colors.black87,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: Text(
                    'Log In',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            FlatButton(
              child: Text(
                'Create an Account',
                style: TextStyle(color: Colors.black54),
              ),
              onPressed: () async {
                var login = await navigateToRegisterPage(context, null);
                if (login != null) {
                  int result = await dbHelper.insertLogin(login);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<Login> navigateToRegisterPage(
      BuildContext context, Login login) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return RegisterPage(login);
    }));
    return result;
  }

  @override
  void onLoginError(String error) {
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLoginSuccess(Login login) async {
    if (login != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    } else {
      _showSnackBar("Username anda salah");
      setState(() {
        _isLoading = false;
      });
    }
  }
}
