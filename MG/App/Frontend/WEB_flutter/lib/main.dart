import 'dart:convert';
import 'package:WEB_flutter/models/admin.dart';
import 'package:WEB_flutter/screens/homePage/home.dart';
import 'package:WEB_flutter/screens/institutions/homePageInstitutions.dart';
import 'package:WEB_flutter/services/token.dart';
import 'package:flutter/material.dart';
import 'package:WEB_flutter/screens/login/loginPage.dart';
import 'models/institution.dart';
import 'screens/institutions/signupPage.dart';

void main() {
  runApp(MyApp());
}

Admin admin;
String loginAdmin = "";
int loginInstitutionID;
Institution loginInstitution;
int idUserFilter =
    0; //za flitriranje, 0 za sve korisnike, u suprotnom id korisnika

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      /*
      title: 'Moj grad',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login(),
      */

      //debugShowCheckedModeBanner: false,
      home: FutureBuilder(
          future: Token.jwtOrEmpty,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            if (snapshot.data != "") {
              var str = snapshot.data;
              var jwt = str.split(".");

              if (jwt.length != 3) {
                return LoginPage();
              } else {
                var payload = json.decode(
                    ascii.decode(base64.decode(base64.normalize(jwt[1]))));
                if (DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
                    .isAfter(DateTime.now())) {
                  if (loginInstitution == null)
                    return HomePage(str, payload);
                  else
                    return HomePageInstitutions();
                } else {
                  return LoginPage();
                }
              }
            } else {
              return LoginPage();
            }
          }),

      //LoginPage(),
      //nemojte slati 0! Ne postoji korisnik ciji je id 0
      //SignUpPage(),
      routes: {
        '/signup': (BuildContext context) => new SignUpPage(),
        '/login': (BuildContext context) => new LoginPage(),
      },
    );
  }
}
