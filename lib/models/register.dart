import 'package:flutter/material.dart';
import 'package:uts/models/login.dart';

class RegisterPage extends StatefulWidget {
  // deklarasi class login
  final Login login;
  RegisterPage(this.login);
  @override
  RegisterPageState createState() => RegisterPageState(this.login);
}

class RegisterPageState extends State<RegisterPage> {
  // controller form username & password
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // instansiasi class login dan registerpagestate
  Login login;
  RegisterPageState(this.login);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Page"),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            Container(
              child: TextFormField(
                keyboardType: TextInputType.text,
                autofocus: false,
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: 'Username',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
            ),
            Container(
              child: TextFormField(
                autofocus: false,
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  shadowColor: Colors.lightBlueAccent.shade100,
                  child: ElevatedButton(
                    onPressed: () {
                      if (login == null) {
                        login = Login(
                            usernameController.text, passwordController.text);
                      } else {
                        login.username = usernameController.text;
                        login.password = passwordController.text;
                      }
                      Navigator.pop(context, login);
                    },
                    child:
                        Text('Register', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
