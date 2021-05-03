import 'dart:convert';
import 'package:WEB_flutter/hover_extensions.dart';
import 'package:WEB_flutter/main.dart';
import 'package:WEB_flutter/screens/homePage/home.dart';
import 'package:WEB_flutter/services/APIAdmin.dart';
import 'package:WEB_flutter/services/token.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:WEB_flutter/models/admin.dart' as a;

class LoginAdministrator extends StatefulWidget {
  @override
  _LoginAdministratorState createState() => _LoginAdministratorState();
}

class _LoginAdministratorState extends State<LoginAdministrator> {
  String username;
  String password;
  bool isHidden = true;
  final GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        key: _scaffoldstate,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.close),
                ).showPointerOnHover,
              ],
            ),
            Center(
              child: Text(
                'Login',
                style: TextStyle(
                    color: Color.fromRGBO(24, 74, 69, 1),
                    fontSize: 30,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        content: Container(
          height: 250,
          child: Column(
            children: <Widget>[
              buildTextField('Korisničko ime'),
              SizedBox(height: 20.0),
              buildTextField('Lozinka'),
              SizedBox(height: 30.0),
              FlatButton(
                padding: EdgeInsets.fromLTRB(60, 15, 60, 15),
                color: Color.fromRGBO(24, 74, 69, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
                onPressed: () async {
                  var shaPass1 = utf8.encode(password);
                  var shaPass = sha1.convert(shaPass1);
                  print('blablablala');
                  var jwt = await a.Admin.checkAdmin(
                      username, shaPass.toString());
                  if (jwt != 'false') {
                    Token.setToken = jwt;
                    print(jwt);
                    var token = json.decode(ascii.decode(
                        base64.decode(base64.normalize(jwt.split('.')[1]))));
                    //print(token['sub']);
                    loginAdmin = token['sub'];
                    admin = await APIAdmin.getAdminByID(Token.jwt, int.parse(token['nameid']));
                    print('ID ADMINA $loginAdmin');
                    //Token.jwt = jwt;
                    Navigator.pop(
                        context); //da ne moze klikom na dugme back da se vrati na login deo
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage.fromBase64(Token.jwt),
                      ),
                    );
                    print('ok');
                  } else
                    showAlertDialog(context);
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ).showPointerOnHover
            ],
          ),
        ));
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("Ok"),
      onPressed: () {
        Navigator.of(context).pushNamed('/login');
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Greska!"),
      content: Text("Username i password se ne poklapaju!"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
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
        data: Theme.of(context).copyWith(
          primaryColor: Color.fromRGBO(24, 74, 69, 1),
          cursorColor: Color.fromRGBO(24, 74, 69, 1),
        ),
        child: TextField(
          onChanged: (val) async {
            setState(() {
              hintText == 'Korisničko ime' ? username = val : password = val;
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

}
