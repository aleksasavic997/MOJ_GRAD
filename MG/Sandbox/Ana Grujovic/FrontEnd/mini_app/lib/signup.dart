import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:miniapp/Models/Korisnik.dart' as korisnik;
import 'package:miniapp/Models/Korisnik.dart';


class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  String name;
  String lastname;
  String email;
  String password;
  String password2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        padding: EdgeInsets.only(top: 50.0, right: 20.0, left: 20.0, bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'REGISTRACIJA',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30.0,),
            textFieldBuilder('Ime*'),
            SizedBox(height: 20.0,),
            textFieldBuilder('Prezime*'),
            SizedBox(height: 20.0,),
            textFieldBuilder('Email*'),
            SizedBox(height: 20.0,),
            textFieldBuilder('Lozinka*'),
            SizedBox(height: 20.0,),
            textFieldBuilder('Potvrdi lozinku*'),
            SizedBox(height: 20.0,),
            buildButtonContainer('REGISTRACIJA'),
          ],
        ),
      ),
    );
  }

  Widget textFieldBuilder(String hintText) {
    return TextField(
       onChanged: (val) async {
        setState(() {
          if(hintText == 'Ime*') name = val;
          else if(hintText == 'Prezime*') lastname = val;
          else if(hintText == 'Email*') email = val;
          else if(hintText == 'Lozinka*') password = val;
          else password2 = val;
        });
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
            color: Colors.grey[800],
            fontSize: 16.0
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }

  Widget buildButtonContainer(String hintText)
  {
    return Container(
      height: 56.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(23.0),
        gradient: LinearGradient(
          colors: [
            Color(0XFF004D40),
            Color(0XFF00796B)
          ],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
      ),
      child: FlatButton(
        onPressed: () async{
          if(password2 != password || name.isEmpty || lastname.isEmpty || email.isEmpty || password.isEmpty || password2.isEmpty)
            print('greska');
          else{
            var shaPass1 = utf8.encode(password);
            var shaPass = sha1.convert(shaPass1);
            Korisnik k = new Korisnik(name,lastname,email,shaPass.toString());
            var rez = await korisnik.Korisnik.registrujKorisnika(k);
            if(rez.toString() == "true")
              Navigator.of(context).pushNamed('/homeScreen');
            else{
              print('a');
            }
          }
            
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
