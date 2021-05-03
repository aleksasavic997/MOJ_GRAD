import 'dart:convert';
import 'package:WEB_flutter/models/admin.dart';
import 'package:WEB_flutter/services/APIAdmin.dart';
import 'package:WEB_flutter/services/token.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:WEB_flutter/hover_extensions.dart';
import 'package:WEB_flutter/main.dart';

class AdminChangeDataPageBody extends StatefulWidget {
  @override
  _AdminChangeDataPageBodyState createState() =>
      _AdminChangeDataPageBodyState();
}

class _AdminChangeDataPageBodyState extends State<AdminChangeDataPageBody> {
  String username = admin.username;
  String adminPassword = admin.password;
  String currentPassword; //trenuta sifra
  String newPassword = ''; //nova sifra
  String confirmNewPassword = ''; //potvrdi novu sifra
  bool isHidden1 = true; //za trenutnu sifru
  bool isHidden2 = true; //za novu sifru
  //bool isHidden3 = true; //za potvrdu nove sifre
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
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
              child: changeUsernameAndPasword(),
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
              onPressed: () {
                var shaPass1 = utf8.encode(currentPassword);
                var shaPass = sha1.convert(shaPass1);
                print(shaPass.toString());
                print(adminPassword);
                // if (username != loginAdmin) {
                //   print('Izmenjeno korisnicko ime');
                // }
                if (shaPass.toString() != adminPassword) {
                  wrongPassword(context);
                  print('pogresna lozinka');
                  // } else if (username.isEmpty || confirmNewPassword.isEmpty) {
                  //   emtptyFields(context);
                } else if (newPassword != confirmNewPassword) {
                  passwordsNotMatching(context);
                } else if (usernameCorrect.hasMatch(username) == false) {
                  showSnackBarUsername(context);
                } else if ((newPassword != '' || confirmNewPassword != '') && passCorrect.hasMatch(newPassword) == false) {
                  showSnackBarPassword(context);
                } else {
                  var shaPass;
                  if (newPassword == '') {
                    shaPass = admin.password;
                  } else {
                    var shaPass1 = utf8.encode(newPassword);
                    shaPass = sha1.convert(shaPass1);
                  }
                  var newAdmin =
                      Admin.id(admin.id, username, shaPass.toString());
                  APIAdmin.changeAdmin(Token.jwt, newAdmin);
                  admin = newAdmin;
                  username = admin.username;
                  adminPassword = admin.password;
                  setState(() {
                    
                  });
                  madeChanges(context);
                  _controller1.clear();
                  _controller2.clear();
                  _controller3.clear();
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute<void>(
                  //         builder: (context) =>
                  //             HomePage.fromBase64(Token.jwt)));
                }
              },
              child: Text(
                'Sačuvaj izmene',
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

  wrongPassword(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
        content: RichText(
            text: TextSpan(
      text: 'Uneta je pogrešna lozinka u polje Trenutna lozinka.',
      style: TextStyle(color: Colors.grey[200]),
    ))));
  }

  passwordsNotMatching(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
        content: RichText(
            text: TextSpan(
      text: 'Nova lozinka i njena potvrda se ne podudaraju.',
      style: TextStyle(color: Colors.grey[200]),
    ))));
  }

  showSnackBarUsername(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
        content: RichText(
            text: TextSpan(
      text:
          'Korisničko ime mora da sadrži od 4 do 18 karaktera, alfanumeričkih ili tačku ili donju crtu.',
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

  madeChanges(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
        content: RichText(
            text: TextSpan(
      text: 'Izmene su zapamćene.',
      style: TextStyle(color: Colors.grey[200]),
    ))));
  }

  emtptyFields(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
        content: RichText(
            text: TextSpan(
      text: 'Postoje prazna polja.',
      style: TextStyle(color: Colors.grey[200]),
    ))));
  }

  unallowedCharacters(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
        content: RichText(
            text: TextSpan(
      text:
          'Uneti su nedozvoljeni karakteri (/ * + - . , ( ) ! ? ` ~ # % \$ ^ &).',
      style: TextStyle(color: Colors.grey[200]),
    ))));
  }

  Widget changeUsernameAndPasword() {
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
                  'Korisničko ime ',
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
                  'Trenutna lozinka ',
                  style: TextStyle(fontSize: 20),
                )),
            Row(
              children: <Widget>[
                Expanded(child: currentPasswordTextField()),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                padding: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Nova lozinka ',
                  style: TextStyle(fontSize: 20),
                )),
            Row(
              children: <Widget>[
                Expanded(child: newPasswordTextField()),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                padding: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Potvrdite novu lozinku ',
                  style: TextStyle(fontSize: 20),
                )),
            Row(
              children: <Widget>[
                Expanded(child: confirmNewPasswordTextField()),
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
          initialValue: username, //ovde se prosledjuje korisnicko ime admina
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

  //za izmenu vidljivosti trenutne lozinke
  void toggleVisibility1() {
    setState(() {
      isHidden1 = !isHidden1;
    });
  }

  //za izmenu vidljivosti nove lozinke
  void toggleVisibility2() {
    setState(() {
      isHidden2 = !isHidden2;
    });
  }

  //za izmenu vidljivosti potvrdu nove lozinke
  // void toggleVisibility3() {
  //   setState(() {
  //     isHidden3 = !isHidden3;
  //   });
  // }

  Widget currentPasswordTextField() {
    return Container(
      width: 300,
      child: Theme(
        data: Theme.of(context).copyWith(
          primaryColor: Color.fromRGBO(24, 74, 69, 1),
          cursorColor: Color.fromRGBO(24, 74, 69, 1),
        ),
        child: TextField(
          controller: _controller1,
          onChanged: (val) async {
            setState(() {
              currentPassword = val;
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

  Widget newPasswordTextField() {
    return Container(
      width: 300,
      child: Theme(
        data: Theme.of(context).copyWith(
          primaryColor: Color.fromRGBO(24, 74, 69, 1),
          cursorColor: Color.fromRGBO(24, 74, 69, 1),
        ),
        child: TextField(
          controller: _controller2,
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

  Widget confirmNewPasswordTextField() {
    return Container(
      width: 300,
      child: Theme(
        data: Theme.of(context).copyWith(
          primaryColor: Color.fromRGBO(24, 74, 69, 1),
          cursorColor: Color.fromRGBO(24, 74, 69, 1),
        ),
        child: TextField(
          controller: _controller3,
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

/*
  String username;
  String password;
  bool isHidden=true;
  bool usernameChange=false;
  bool passwordChange=false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(40),
      child: buildAdmin()
    );
  }

  Widget buildAdmin(){
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.black12,
      ),      
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/administrator.png',
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(24, 74, 69, 1),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: changeInfo()
            ),
          )
        ],
      )
    );
  }


  Widget changeInfo(){
    return Container(
      margin: EdgeInsets.all(30),
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.grey[200],

      ),
      height: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Korisničko ime',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        IconButton(
                          onPressed: (){
                            setState(() {
                              usernameChange=!usernameChange;
                            });
                          },
                          icon: Icon(
                            Icons.edit,
                            size: 20,
                            color: Color.fromRGBO(24, 74, 69, 1),
                          ),
                        ).showPointerOnHover
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  usernameChange? changeUsername() : showUsername()
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Lozinka',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        IconButton(
                          onPressed: (){
                            setState(() {
                              passwordChange=!passwordChange;
                            });
                          },
                          icon: Icon(
                            Icons.edit,
                            size: 20,
                            color: Color.fromRGBO(24, 74, 69, 1),
                          )
                        ).showPointerOnHover
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  passwordChange? changePassword() : showPassword()
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
          usernameChange || passwordChange ? Center(
            child: FlatButton(  
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              color: Color.fromRGBO(24, 74, 69, 1),
              onPressed: (){

              },
              child: Text(
                'Sačuvaj izmene',
                style: TextStyle(
                  color: Colors.grey[200],
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1
                ),
              ),
            ).showPointerOnHover,
          ) : Text('')
        ],
      ),
    );
  }

  Widget changeUsername(){
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black26
        ),
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 180,
                child: Text(
                  'Novo korisničko ime: ', 
                  style: TextStyle(
                    fontSize: 16
                  ),
                )
              ),
              Expanded(child: buildTextField('Korisničko ime')),
            ],
          ),
        ],
      )
    );
  }

  Widget showUsername(){
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black26
        ),
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 180,
                child: Text(
                  'Trenutno korisničko ime: ', 
                  style: TextStyle(
                    fontSize: 16
                  ),
                )
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(19),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.black45
                    )
                  ),
                  child: Text(
                    'adminUsername',
                    style: TextStyle(
                      fontSize: 16
                    ),
                  ),
                )
              ),
            ],
          ),
        ],
      )
    );
  }

  Widget changePassword(){
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black26
        ),
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 180,
                child: Text(
                  'Nova lozinka: ',
                  style: TextStyle(
                    fontSize: 16
                  ),
                )
              ),
              Expanded(child: buildTextField('Lozinka')),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: <Widget>[
              Container(
                width: 180,
                child: Text(
                  'Potvrdite novu lozinku: ',
                  style: TextStyle(
                    fontSize: 16
                  ),
                )
              ),
              Expanded(child: buildTextField('Lozinka')),
            ],
          ),
        ],
      )
    );
  }

  Widget showPassword(){
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black26
        ),
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(       
                width: 180,
                child: Text(
                  'Trenutna lozinka: ', 
                  style: TextStyle(
                    fontSize: 16,
                  ),
                )
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.black45
                    )
                  ),
                  child: Text(
                    'adminPassword',
                    style: TextStyle(
                      fontSize: 16
                    ),
                  ),
                )
              ),
            ],
          ),
        ],
      )
    );
  }

  void toggleVisibility() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  Widget buildTextField(String hintText) {
    return Container(
      width: 300,
      child: Theme(
        data: ThemeData(
          cursorColor: Color.fromRGBO(24, 74, 69, 1),
          primaryColor: Color.fromRGBO(24, 74, 69, 1)
        ),
        child: TextField(
          onChanged: (val) async {
            setState(() {
              hintText == 'Korisničko ime' ? username = val : password = val;
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
            prefixIcon: hintText == 'Korisničko ime'
                ? Icon(Icons.person)
                : Icon(Icons.lock),
            suffixIcon: hintText == 'Lozinka'
                ? IconButton(
                    onPressed: toggleVisibility,
                    icon: isHidden == true
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                  ).showPointerOnHover
                : null,
          ),
          obscureText: hintText == 'Lozinka' ? isHidden : false,
        ).showPointerOnHover,
      ),
    );
  }
  */
}
