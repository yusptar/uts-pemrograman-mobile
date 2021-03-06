//kode utama Aplikasi tampilan awal
import 'package:flutter/material.dart';
import 'package:uts/pages/home.dart';
import 'package:uts/pages/loginpage.dart'; //package letak folder

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RS Polinema',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: LoginPage(),
    );
  }
}
