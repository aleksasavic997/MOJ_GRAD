import 'package:flutter/material.dart';
import 'package:myapp6/signUp.dart';
import 'package:myapp6/home.dart';

import 'logIn.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => MyHomePage(),
        '/signUp': (BuildContext context) => SignUpPage(),
        '/home': (BuildContext context) => Home()
      },
    );
  }
}
