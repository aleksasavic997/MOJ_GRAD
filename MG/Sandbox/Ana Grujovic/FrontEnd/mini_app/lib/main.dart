import 'dart:convert';
import 'dart:ui';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'UI/Filmovi.dart';
import 'signup.dart';
import 'package:miniapp/Models/Korisnik.dart' as korisnik;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFFC51162),
        fontFamily: "DellaRespira",
      ),
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => new SignupPage(),
        '/homeScreen': (BuildContext context) => new Filmovi(),
        '/loginScreen':(BuildContext context) => new MyApp()
      },
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String email;
  String password;

  bool isHidden = true;

  void toggleVisibility() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        padding:
            EdgeInsets.only(top: 100.0, right: 20.0, left: 20.0, bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                constraints: BoxConstraints.expand(
                  height: 200.0,
                ),
                child: Image.asset('assets/img/logo.png'),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Text(
              'Moji filmovi',
              style: TextStyle(
                  fontSize: 45.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
            SizedBox(
              height: 40.0,
            ),
            buildTextField('Email'),
            SizedBox(
              height: 20.0,
            ),
            buildTextField('Lozinka'),
            SizedBox(
              height: 20.0,
            ),
            buildButtonContainer('PRIJAVA'),
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Nemate nalog?"),
                    SizedBox(
                      width: 10.0,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed('/signup');
                      },
                      child: Text(
                        'Registrujte se ovde',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String hintText) {
    return new TextField(
      onChanged: (val) async {
        setState(() {
          hintText == 'Email' ? email = val : password = val;
        });
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey[800],
          fontSize: 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        prefixIcon: hintText == 'Email' ? Icon(Icons.email) : Icon(Icons.lock),
        suffixIcon: hintText == 'Lozinka'
            ? IconButton(
                onPressed: toggleVisibility,
                icon: isHidden == true
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
              )
            : null,
      ),
      obscureText: hintText == 'Lozinka' ? isHidden : false,
    );
  }

  Widget buildButtonContainer(String hintText) {
    return Container(
      height: 56.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(23.0),
        gradient: LinearGradient(
          colors: [Color(0XFF004D40),
           Color(0XFF00E676)],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
      ),
      child: FlatButton(
        onPressed: () async{
          var shaPass1 = utf8.encode(password);
          var shaPass = sha1.convert(shaPass1);
          var rez =
              await korisnik.Korisnik.proveriKorisnika(email, shaPass.toString());
          if (rez == 'true')
              Navigator.of(context).pushNamed('/homeScreen');
          else
            print('Greska!');
        },
        child: Center(
          child: Text(
            hintText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );
  }
}
