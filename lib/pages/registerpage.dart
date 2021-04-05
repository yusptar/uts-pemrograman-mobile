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
        title: Text("Register Page", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(5),
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
              margin: EdgeInsets.all(5),
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
              margin: EdgeInsets.all(5),
              child: Padding(
                padding: EdgeInsets.all(4),
                child: Material(
                  shadowColor: Colors.black54,
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
