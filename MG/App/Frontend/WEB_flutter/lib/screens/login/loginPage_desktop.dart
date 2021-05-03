import 'dart:convert';
import 'package:WEB_flutter/main.dart';
import 'package:WEB_flutter/screens/homePage/home.dart';
import 'package:WEB_flutter/screens/institutions/homePageInstitutions.dart';
import 'package:WEB_flutter/services/APIAdmin.dart';
import 'package:WEB_flutter/services/APIInstitutions.dart';
import 'package:WEB_flutter/services/token.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:WEB_flutter/models/institution.dart' as institution;
import 'package:WEB_flutter/hover_extensions.dart';
import 'package:flutter/services.dart';
import 'package:universal_html/html.dart';
import '../institutions/signupPage.dart';
import 'package:WEB_flutter/models/admin.dart' as a;

class LoginDesktopTablet extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginDesktopTablet> {
  String username;
  String password;
  bool isHidden = true;
  final GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();

  bool autoPass = false;
  bool autoUsername = true;

  void _showSnakBarMsg(String msg) {
    _scaffoldstate.currentState
        .showSnackBar(new SnackBar(content: new Text(msg)));
  }

  final FocusNode _focusNode = new FocusNode();

  void _handleKeyEvent(RawKeyEvent event) {
    setState(() {
      if (event.logicalKey == LogicalKeyboardKey.enter) {
        print("Enterrr");
        _pressLoginButton();
      }
    });
  }

  _pressLoginButton() async {
    var shaPass1 = utf8.encode(password);
    var shaPass = sha1.convert(shaPass1);
    var jwt =
        await institution.Institution.checkUser(username, shaPass.toString());
    if (jwt != "false") {
      Token.setToken = jwt;
      print(jwt);
      var token = json.decode(
          ascii.decode(base64.decode(base64.normalize(jwt.split('.')[1]))));
      print(token['sub']);
      loginInstitutionID = int.parse(token['sub']);
      loginInstitution =
          await APIInstitutions.getInstitutionByID(loginInstitutionID, jwt);
      if (loginInstitution.isVerified == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePageInstitutions()),
        );
      } else {
        autoPass = false;
        autoUsername = true;
        _showSnakBarMsg("Jos uvek nije odobren vas zahtev za registraciju.");
      }

      print('ok');
    } else {
      var jwt = await a.Admin.checkAdmin(username, shaPass.toString());
      if (jwt != 'false') {
        Token.setToken = jwt;
        print(jwt);
        var token = json.decode(
            ascii.decode(base64.decode(base64.normalize(jwt.split('.')[1]))));
        //print(token['sub']);
        loginAdmin = token['sub'];
        admin =
            await APIAdmin.getAdminByID(Token.jwt, int.parse(token['nameid']));
        print('ID ADMINA $loginAdmin');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage.fromBase64(Token.jwt),
          ),
        );
        print('ok');
      } else {
        autoPass = false;
        autoUsername = true;
        _showSnakBarMsg('Pogrešno korisničko ime ili lozinka');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        key: _scaffoldstate,
        body: Container(
          color: Colors.grey[300],
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  top: 60, bottom: 95.0, left: 50.0, right: 50.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0)),
                elevation: 5.0,
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        padding: EdgeInsets.only(
                            top: 150, right: 50.0, left: 50.0, bottom: 300),
                        color: Color.fromRGBO(24, 74, 69, 1),
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: <Widget>[
                              Container(
                                //padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                                child: Text(
                                  "Moj Grad    ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28.0,
                                    //fontWeight: FontWeight.w900,
                                    fontFamily: 'Pacifico',
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                  padding:
                                      EdgeInsets.only(top: 5.0, bottom: 5.0),
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      if (constraints.maxWidth < 300) {
                                        return Text(
                                          "Dobro došli na našu web \naplikaciju!",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                          ),
                                          textAlign: TextAlign.center,
                                        );
                                      } else {
                                        return Text(
                                          "Dobro došli na našu web aplikaciju!",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                          ),
                                          textAlign: TextAlign.center,
                                        );
                                      }
                                    },
                                  )),
                              SizedBox(
                                height: 50.0,
                              ),
                              //////////////////////////////////////////////
                              // RaisedButton(
                              //         onPressed: () {
                              //           return showDialog(
                              //             context: context,
                              //             builder: (context) =>
                              //                 LoginAdministrator(),
                              //           );
                              //         },
                              //         child: Text('Admin'),
                              //         shape: RoundedRectangleBorder(
                              //             borderRadius:
                              //                 BorderRadius.circular(11)))
                              //     .showPointerOnHover,
                              //////////////////////////////////////////////
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.1,
                          padding: EdgeInsets.only(top: 0.0, bottom: 5.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Prijava",
                                style: TextStyle(
                                    color: Color.fromRGBO(24, 74, 69, 1),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 35.0,
                                    fontFamily: 'Merriweather'),
                              ),
                              const SizedBox(height: 21.0),
                              buildTextField('Korisničko ime'),
                              SizedBox(height: 20.0),
                              buildTextField('Lozinka'),
                              SizedBox(height: 20.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  FlatButton(
                                          padding: EdgeInsets.fromLTRB(
                                              60, 15, 60, 15),
                                          color: Color.fromRGBO(24, 74, 69, 1),
                                          onPressed: () async {
                                            _pressLoginButton();
                                          },
                                          child: Text(
                                            "Prijava",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(11)))
                                      .showPointerOnHover,
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('Nemate nalog? '),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  InkWell(
                                    child: Text(
                                      'Registrujte se',
                                      style: TextStyle(
                                        color: Color.fromRGBO(24, 74, 69, 1),
                                      ),
                                    ).showPointerOnHover,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SignUpPage()));
                                    },
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
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
        child: RawKeyboardListener(
          focusNode: _focusNode,
          onKey: _handleKeyEvent,
          // child: RawKeyboardListener(
          //   focusNode: FocusNode(),
          //   onKey: (event) {
          //     if (event.runtimeType == RawKeyDownEvent &&
          //         event.logicalKey.keyId == 54 &&
          //         hintText == 'Lozinka'){
          //           print('KKKKKKKKKKKKKKKKK');
          //            _pressLoginButton();
          //            print('AAAAAAAAAAAAAAAAAAA');
          //         }
          //   },
          child: TextFormField(
            autofocus: hintText == 'Lozinka' ? autoPass : autoUsername,
            // autovalidate: true,
            // validator: (value) {
            //   if (value.contains('\n')) {
            //     print('ENTEEEEER');
            //     if (hintText == 'Lozinka') _pressLoginButton();
            //   }
            // },
            onChanged: (val) async {
              setState(() {
                hintText == 'Korisničko ime' ? username = val : password = val;
              });
            },
            onFieldSubmitted: (val) {
              if (hintText == 'Lozinka' &&
                  password.isNotEmpty &&
                  username.isNotEmpty)
                _pressLoginButton();
              else
                setState(() {
                  autoPass = true;
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
      ),
    );
  }
}
