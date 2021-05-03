import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myapp/Models/Korisnici.dart' as user;
import 'package:myapp/Models/Korisnici.dart';
import 'package:flutter/rendering.dart';
import 'package:crypto/crypto.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String username;
  String password;
  String password1;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 60.0, 0.0, 0.0),
                    child: Text(
                      'Signup',
                      style: TextStyle(
                        color: Colors.blue[300],
                        fontSize: 50.0, 
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    //SizedBox(height: 10.0),
                    TextField(
                      onChanged: (val) async {
                        setState(() => username = val);
                      },
                       style: new TextStyle ( color: Colors.white),
                      decoration: InputDecoration(
                          labelText: 'NICK NAME',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[100]
                            ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)
                              )
                            ),
                    ),
                    TextField(
                      onChanged: (val) async {
                        setState(() => password = val);
                      },
                       style: new TextStyle ( color: Colors.white),
                      decoration: InputDecoration(
                          labelText: 'PASSWORD',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[100]
                            ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)
                              )
                            ),
                          obscureText: true,
                    ),
                    TextField(
                      onChanged: (val) async {
                        setState(() => password1 = val);
                      }, style: new TextStyle ( color: Colors.white),
                      decoration: InputDecoration(
                          labelText: 'CONFIRM PASSWORD',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[100]
                            ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)
                              )
                            ),
                          obscureText: true,
                    ),
                    SizedBox(height: 40.0),
                    Container(
                        height: 40.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          //shadowColor: Colors.blue[300],
                          color: Colors.blue[300],
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: () async {
                              if (username.isEmpty || password.isEmpty || password1.isEmpty) { print('Username or password or password confirm are empty'); }
                              else
                              {
                                var sP1 = utf8.encode(password);
                                var sP = sha1.convert(sP1);
                                Korisnici k = new Korisnici(username, sP.toString());
                                var pom = await user.Korisnici.registerUser(k);
                                if(pom.toString() == "true") { Navigator.of(context).pushNamed('/prikaziSerije'); }
                                else { print("User with the same username already exists"); }
                              }
                            },
                            child: Center(
                              child: Text(
                                'SIGNUP',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                              ),
                            ),
                          ),
                        )),
                    SizedBox(height: 10.0),
                    Container(
                      height: 40.0,
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.blue[300],
                                style: BorderStyle.solid,
                                width: 2.0),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: 
                              Center(
                                child: Text(
                                  'Go Back',
                                  style: TextStyle(
                                    color: Colors.blue[300],
                                    fontWeight: FontWeight.bold,
                                    )
                                  ),
                              ),
                        ),
                      ),
                    ),
                  ],
                )
              ),
          ]
      ),
        )
    );
  }
}