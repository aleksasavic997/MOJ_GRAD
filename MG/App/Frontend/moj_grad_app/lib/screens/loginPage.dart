import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:mojgradapp/functions/forgottenPassword.dart';
import 'package:mojgradapp/functions/loading.dart';
import 'package:mojgradapp/models/userData.dart' as user;
import 'package:flutter/material.dart';
import 'package:mojgradapp/screens/homePage.dart';
import 'package:mojgradapp/services/APIUsers.dart';
import 'package:mojgradapp/services/token.dart';
import '../main.dart';

String username;
String password;

class LoginPage extends StatefulWidget {
  //static var userD;
  /*setUsernameAndPassword() {
    username = null;
    password = null;
  }*/
  String getUsername() {
    return username;
  }

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // UserData userD = UserData("", "", "", "", "", "", 1, 0);

  final GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();

  var shaPass;

  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldstate,
      resizeToAvoidBottomPadding: false,
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return KeyboardAvoider(
        autoScroll: true,
        child: Container(
          padding:
              EdgeInsets.only(top: 40.0, right: 20.0, left: 20.0, bottom: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Image.asset(
                  "assets/Logo.png",
                  fit: BoxFit.cover,
                  // scale: 1.5,
                  height: 100.0,
                  // width: 150.0,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Center(
                child: Text(
                  'Moj Grad',
                  style: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pacifico',
                      color: Theme.of(context).primaryColor),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              buildTextField('Korisničko ime'),
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
                  child: Column(
                    children: <Widget>[
                      Row(
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
                              'Registrujte se ovde.',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Zaboravili ste lozinku?"),
                          SizedBox(
                            width: 10.0,
                          ),
                          InkWell(
                            onTap: () {
                              //Navigator.of(context).pushNamed('/signup');
                              showDialog(
                                  context: context,
                                  builder: (context) => ForgottenPassword());
                            },
                            child: Text(
                              'Promenite lozinku ovde.',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void toggleVisibility() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  Widget buildTextField(String hintText) {
    return new TextField(
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
          colors: [Colors.amber[400], Colors.amber[800]],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
      ),
      child: FlatButton(
        onPressed: () async {
          var shaPass1 = utf8.encode(password);
          var shaPass = sha1.convert(shaPass1);
          var jwt = await user.UserData.checkUser(username, shaPass.toString());
          if (jwt != 'false') {
            showDialog(context: context, builder: (context) => Loading());
            // storage.write(key: "jwt", value: jwt);
            Token.setSecureStorage("jwt", jwt);
            print(jwt);
            var token = json.decode(ascii
                .decode(base64.decode(base64.normalize(jwt.split('.')[1]))));
            //print(token['sub']);
            loginUserID = int.parse(token['sub']);
            print('ID KORISNIKA $loginUserID');
            Token.jwt = jwt;
            // if ((await APIUsers.isUserLogged(Token.jwt, loginUserID)) ==
            //     true) {
            loginUser = await APIUsers.getUserInfoById(loginUserID, Token.jwt);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage.fromBase64(Token.jwt),
              ),
            );
            // } else {
            //   _showSnakBarMsg("Korisnik je vec prijavljen na drugom uredjaju.");
            // }
          } else
            _showSnakBarMsg('Pogrešno korisničko ime ili lozinka.');
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

  void _showSnakBarMsg(String msg) {
    _scaffoldstate.currentState
        .showSnackBar(new SnackBar(content: new Text(msg)));
  }
}
