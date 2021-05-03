import 'dart:convert';

import 'package:WEB_flutter/models/admin.dart';
import 'package:WEB_flutter/services/APIAdmin.dart';
import 'package:WEB_flutter/services/token.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:WEB_flutter/hover_extensions.dart';

class NewAdminDataPageBody extends StatefulWidget {
  @override
  _NewAdminDataPageBodyState createState() => _NewAdminDataPageBodyState();
}

class _NewAdminDataPageBodyState extends State<NewAdminDataPageBody> {
  String username;
  String newPassword;
  String confirmNewPassword;
  bool isHidden1 = true;
  bool isHidden2 = true;

  RegExp usernameCorrect =
      new RegExp(r'^(?=[a-zA-Z0-9._]{4,18}$)(?!.*[_.]{2})[^_.].*[^_.]$');
  //username admina sadrzi od 4-18 alfanumerickih karaktera, crtica ili tacki, tacka i crtica ne mogu biti na pocetku/kraju ili jedan za drugim.

  RegExp passCorrect = new RegExp(
      r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{8,}$'); //sadrzi najmanje jedno slovo, najmanje jedan broj i 8 ili vise karaktera

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 800,
        padding: EdgeInsets.all(40),
        child: Center(
          child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(24, 74, 69, 1),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: changeInfo()),
        ));
  }

  Widget changeInfo() {
    return Container(
      margin: EdgeInsets.all(30),
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.grey[200],
      ),
      height: 600,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              child: usernamePasword(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              color: Color.fromRGBO(24, 74, 69, 1),
              onPressed: () async {
                if (username == null ||
                    newPassword == null ||
                    confirmNewPassword == null) {
                  emtptyFields(context);
                } else if (confirmNewPassword != newPassword) {
                  wrongPassword(context);
                } else if (usernameCorrect.hasMatch(username) == false) {
                  showSnackBarUsername(context);
                } else if (passCorrect.hasMatch(newPassword) == false) {
                  showSnackBarPassword(context);
                } else {
                  var shaPass1 = utf8.encode(newPassword);
                  var password = sha1.convert(shaPass1);
                  var newAdmin = Admin(username, password.toString());
                  if ((await APIAdmin.addAdmin(Token.jwt, newAdmin)) == true) {
                    success(context);
                    setState(() {
                      username = null;
                      newPassword = null;
                      confirmNewPassword = null;
                    });
                  } else {
                    error(context);
                  }
                }
              },
              child: Text(
                'Dodaj',
                style: TextStyle(
                    color: Colors.grey[200],
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ).showPointerOnHover,
          ),
        ],
      ),
    );
  }

  emtptyFields(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
        content: RichText(
            text: TextSpan(
      text: 'Postoje prazna polja. ',
      style: TextStyle(color: Colors.grey[200]),
    ))));
  }

  error(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
        content: RichText(
            text: TextSpan(
      text: 'Korisničko ime je zauzeto.',
      style: TextStyle(color: Colors.grey[200]),
    ))));
  }

  success(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
        content: RichText(
            text: TextSpan(
      text: 'Uspešno ste dodali novog administratora.',
      style: TextStyle(color: Colors.grey[200]),
    ))));
  }

  wrongPassword(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
        content: RichText(
            text: TextSpan(
      text: 'Lozinke se ne poklapaju.',
      style: TextStyle(color: Colors.grey[200]),
    ))));
  }

  showSnackBarUsername(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
        content: RichText(
            text: TextSpan(
      text:
          'Korisničko ime mora da sadrži od 4 do 18 karaktera, alfanumeričkih ili tačku ili donju crtu',
      style: TextStyle(color: Colors.grey[200]),
    ))));
  }

  showSnackBarPassword(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
        content: RichText(
            text: TextSpan(
      text:
          'Lozinka mora imati najmanje 8 karaktera, jedno slovo i jedan broj.',
      style: TextStyle(color: Colors.grey[200]),
    ))));
  }

  Widget usernamePasword() {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 10),
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  ' Dodavanje novog administratora',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[900]),
                )),
            Container(
                padding: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  // 'Korisničko ime ',
                  '  ',
                  style: TextStyle(fontSize: 20),
                )),
            Row(
              children: <Widget>[
                Expanded(child: usernameTextField()),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                padding: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  // 'Lozinka ',
                  '  ',
                  style: TextStyle(fontSize: 20),
                )),
            Row(
              children: <Widget>[
                Expanded(child: passwordTextField()),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                padding: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  // 'Ponovite lozinku',
                  '  ',
                  style: TextStyle(fontSize: 20),
                )),
            Row(
              children: <Widget>[
                Expanded(child: againPasswordTextField()),
              ],
            ),
          ],
        ));
  }

  Widget usernameTextField() {
    return Container(
      width: 300,
      child: Theme(
        data: ThemeData(
            cursorColor: Color.fromRGBO(24, 74, 69, 1),
            primaryColor: Color.fromRGBO(24, 74, 69, 1)),
        child: TextFormField(
          //promenjeno je u TextFormField zbog initialValue
          onChanged: (val) async {
            setState(() {
              username = val;
            });
          },
          decoration: InputDecoration(
              hintText: 'Korisničko ime',
              hintStyle: TextStyle(
                color: Colors.grey[800],
                fontSize: 16.0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              prefixIcon: Icon(Icons.person)),
        ).showPointerOnHover,
      ),
    );
  }

  void toggleVisibility1() {
    setState(() {
      isHidden1 = !isHidden1;
    });
  }

  void toggleVisibility2() {
    setState(() {
      isHidden2 = !isHidden2;
    });
  }

  Widget passwordTextField() {
    return Container(
      width: 300,
      child: Theme(
        data: Theme.of(context).copyWith(
          primaryColor: Color.fromRGBO(24, 74, 69, 1),
          cursorColor: Color.fromRGBO(24, 74, 69, 1),
        ),
        child: TextField(
          onChanged: (val) async {
            setState(() {
              newPassword = val;
            });
          },
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(24, 74, 69, 1),
                width: 2.5,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            hintText: 'Lozinka',
            hintStyle: TextStyle(
              color: Colors.grey[800],
              fontSize: 16.0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            prefixIcon: Icon(Icons.lock),
            suffixIcon: IconButton(
              onPressed: toggleVisibility1,
              icon: isHidden1 == true
                  ? Icon(Icons.visibility_off)
                  : Icon(Icons.visibility),
            ).showPointerOnHover,
          ),
          obscureText: isHidden1,
        ).showPointerOnHover,
      ),
    );
  }

  Widget againPasswordTextField() {
    return Container(
      width: 300,
      child: Theme(
        data: Theme.of(context).copyWith(
          primaryColor: Color.fromRGBO(24, 74, 69, 1),
          cursorColor: Color.fromRGBO(24, 74, 69, 1),
        ),
        child: TextField(
          onChanged: (val) async {
            setState(() {
              confirmNewPassword = val;
            });
          },
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(24, 74, 69, 1),
                width: 2.5,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            hintText: 'Ponovite lozinku',
            hintStyle: TextStyle(
              color: Colors.grey[800],
              fontSize: 16.0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            prefixIcon: Icon(Icons.lock),
            suffixIcon: IconButton(
              onPressed: toggleVisibility2,
              icon: isHidden2 == true
                  ? Icon(Icons.visibility_off)
                  : Icon(Icons.visibility),
            ).showPointerOnHover,
          ),
          obscureText: isHidden2,
        ).showPointerOnHover,
      ),
    );
  }
}
