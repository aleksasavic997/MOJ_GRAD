import 'dart:convert';

import 'package:WEB_flutter/models/category.dart';
import 'package:WEB_flutter/models/institution.dart';
import 'package:WEB_flutter/models/userData.dart';
import 'package:WEB_flutter/screens/institutions/showCategoryDialog.dart';
import 'package:WEB_flutter/screens/institutions/signupPage.dart';
import 'package:WEB_flutter/screens/login/loginPage.dart';
import 'package:WEB_flutter/services/APIInstitutions.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../models/city.dart';
import '../../services/APIServices.dart';

class SignUpTablet extends StatefulWidget {
  @override
  _SignUpTabletState createState() => _SignUpTabletState();
}

class _SignUpTabletState extends State<SignUpTablet> {
  String name = "";
  String username = "";
  String password = "";
  String email = "";
  String phone = "";
  int cityID;
  String photo = "Upload//UserProfileImage//profileDefault.png";
  String address = "";
  String password2 = "";
  int userTypeID = 2;

  int points = 0;
  int rankID = 3;

  //bool isHidden = true;
  bool isHiddenPass1 = true;
  bool isHiddenPass2 = true;

  String hintCity = "";

  final GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();

  RegExp usernameCorrect =
      new RegExp(r'^(?=[a-zA-Z0-9._]{4,22}$)(?!.*[_.]{2})[^_.].*[^_.]$');
  //username admina sadrzi od 4-22 alfanumerickih karaktera, crtica ili tacki, tacka i crtica ne mogu biti na pocetku/kraju ili jedan za drugim.

  RegExp passCorrect = new RegExp(
      r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{8,}$'); //sadrzi najmanje jedno slovo, najmanje jedan broj i 8 ili vise karaktera

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldstate,
      //backgroundColor: Theme.of(context).backgroundColor,
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Container(
      color: Colors.grey[300],
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0)),
            elevation: 5.0,
            child: Container(
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Color.fromRGBO(24, 74, 69, 1),
                    padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 40.0,
                          ),
                          Container(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              'Moj grad',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40.0,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Container(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              "Dobro došli na našu web aplikaciju!",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          // Center(
                          //   child: FlatButton(
                          //     child: SizedBox(
                          //       child: Icon(
                          //         Icons.camera_alt,
                          //         size: 50,
                          //         color: Colors.grey[500],
                          //       ),
                          //       width: 70,
                          //       height: 80,
                          //     ),
                          //     onPressed: () {}, //uploadPhoto
                          //     color: Colors.blue[50],
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: EdgeInsets.only(top: 30, bottom: 100),
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Registracija",
                            style: TextStyle(
                                color: Color.fromRGBO(24, 74, 69, 1),
                                fontWeight: FontWeight.w900,
                                fontSize: 40.0,
                                fontFamily: 'Merriweather'),
                          ),
                          const SizedBox(height: 30.0),
                          inputField('Naziv*'),
                          const SizedBox(height: 10.0),
                          inputField('Korisničko ime*'),
                          const SizedBox(height: 10.0),
                          inputField('Lozinka*'),
                          const SizedBox(height: 10.0),
                          inputField('Potvrdi lozinku*'),
                          const SizedBox(height: 10.0),
                          inputField('Email*'),
                          const SizedBox(height: 10.0),
                          inputField('Broj telefona*'),
                          const SizedBox(height: 10.0),
                          grad(),
                          const SizedBox(height: 10.0),
                          inputField('Adresa*'),
                          const SizedBox(height: 10.0),
                          categories(),
                          const SizedBox(height: 30.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RaisedButton(
                                  child: Text('Odustani'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  color: Colors.blue[50],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(11))),
                              SizedBox(
                                width: 30,
                              ),
                              RaisedButton(
                                  onPressed: () {
                                    _register();
                                  },
                                  child: Text(
                                    'Registrujte se',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Color.fromRGBO(24, 74, 69, 1),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(11)))
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ])),
          ),
        ),
      ),
    );
  }

  Widget categories() {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            width: 120.0,
            child: Text(
              'Kategorija*',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color.fromRGBO(24, 74, 69, 1), fontSize: 17.0),
            ),
          ),
          SizedBox(
            width: 40.0,
          ),
          Container(
              width: MediaQuery.of(context).size.width / 2.5,
              color: Colors.teal[100],
              child: buildCategoryList())
          //buildCityList()
        ],
      ),
    );
  }

  Widget buildCategoryList() {
    return InkWell(
      child: Container(
        height: 45.0,
        decoration: BoxDecoration(
            border:
                Border.all(color: Color.fromRGBO(24, 74, 69, 0.5), width: 1.0),
            borderRadius: BorderRadius.circular(5.0)),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
            child: Text("Izaberite kategorije",
                style: TextStyle(
                  color: Color.fromRGBO(24, 74, 69, 1),
                ))),
      ),
      onTap: () {
        showDialog(
            context: context, builder: (context) => ShowCategoryDialog());
      },
    );
  }

  Future<void> _register() async {
    print('Regiiiii');
    if (username.isEmpty ||
            name.isEmpty ||
            phone.isEmpty ||
            email.isEmpty ||
            password.isEmpty ||
            password2.isEmpty ||
            cityID == null ||
            address.isEmpty ||
            SignUpPage.categoryList==null
        )
      _showSnakBarMsg('Niste uneli sve podatke.');
    else if ((await Institution.checkEmail(email)) == "true")
      _showSnakBarMsg('Email adresa je zauzeta.');
    else if (Institution.isEmail(email) == false)
      _showSnakBarMsg('Email adresa nije u ispravnom formatu.');
    else if ((await Institution.checkUsername(username)) == "true")
      _showSnakBarMsg('Korisničko ime je zauzeto.');
    else if (password2 != password)
      _showSnakBarMsg('Lozinke se ne poklapaju.');
    else if (usernameCorrect.hasMatch(username) == false) {
      _showSnakBarMsg(
          'Korisničko ime mora da sadrži od 4 do 22 karaktera, alfanumeričkih ili tačku ili donju crtu');
    } else if (passCorrect.hasMatch(password) == false) {
      _showSnakBarMsg(
          'Lozinka mora imati najmanje 8 karaktera, jedno slovo i jedan broj.');
    } else if (phone != "" && UserData.isPhone(phone) == false)
      _showSnakBarMsg('Broj telefona nije u ispravnom formatu.');
    else {
      var shaPass1 = utf8.encode(password);
      var shaPass = sha1.convert(shaPass1);
      Institution u = new Institution(name, username, shaPass.toString(), email,
          phone, cityID, photo, userTypeID, address, false);
      bool res = await Institution.registration(u);
      if (res == true) {
        List<Category> categories = [];
        for (var category in SignUpPage.categoryList) {
          if (category.value == true) categories.add(category.category);
        }
        if ((await APIInstitutions.followCategories(u.username, categories)) ==
            true) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
        } else
          _showSnakBarMsg("Došlo je do greške. Pokušajte ponovo.");
      } else {
        _showSnakBarMsg('Došlo je do greške. Pokušajte ponovo.');
      }
    }
  }

  Widget grad() {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            width: 120.0,
            child: Text(
              'Grad*',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color.fromRGBO(24, 74, 69, 1), fontSize: 17.0),
            ),
          ),
          SizedBox(
            width: 40.0,
          ),
          Container(
              width: MediaQuery.of(context).size.width / 2.5,
              color: Colors.teal[100],
              child: buildCityList())
          //buildCityList()
        ],
      ),
    );
  }

  Widget buildCityList() {
    return Container(
      decoration: BoxDecoration(
          border:
              Border.all(color: Color.fromRGBO(24, 74, 69, 0.5), width: 1.0),
          borderRadius: BorderRadius.circular(5.0)),
      child: FutureBuilder<List<City>>(
          future: APIServices.getCity(),
          builder: (BuildContext context, AsyncSnapshot<List<City>> snapshot) {
            //print('alooooo');
            if (!snapshot.hasData) {
              return Center(
                child: Container(
                  child: SpinKitFadingCircle(
                    color: Color.fromRGBO(24, 74, 69, 1),
                    size: 30,
                  ),
                ),
              );
            } //print('aloooooooooo');
            return DropdownButtonHideUnderline(
              child: DropdownButton<City>(
                items: snapshot.data
                    .map((city) => DropdownMenuItem<City>(
                          child: Text(city.name),
                          value: city,
                        ))
                    .toList(),
                onChanged: (City value) {
                  setState(() {
                    cityID = value.id;
                    hintCity = value.name;
                  });
                },
                isExpanded: false,
                //value: _currentUser,
                //underline: UnderlineInputBorder(),
                hint: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    hintCity,
                    style: TextStyle(
                      color: Color.fromRGBO(24, 74, 69, 1),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget inputField(String text) {
    return Container(
      child: Theme(
        data: Theme.of(context).copyWith(
          primaryColor: Color.fromRGBO(24, 74, 69, 1),
          cursorColor: Color.fromRGBO(24, 74, 69, 1),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 120.0,
              child: Text(
                text,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Color.fromRGBO(24, 74, 69, 1), fontSize: 17.0),
              ),
            ),
            SizedBox(
              width: 40.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2.5,
              color: Colors.teal[100],
              child: TextField(
                  onChanged: (val) async {
                    setState(() {
                      switch (text) {
                        case 'Naziv*':
                          name = val;
                          break;
                        case 'Adresa*':
                          address = val;
                          break;
                        case 'Email*':
                          email = val;
                          break;
                        case 'Korisničko ime*':
                          username = val;
                          break;
                        case 'Lozinka*':
                          password = val;
                          break;
                        case 'Potvrdi lozinku*':
                          password2 = val;
                          break;
                        case 'Broj telefona*':
                          phone = val;
                          break;
                      }
                    });
                  },
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    // enabledBorder: OutlineInputBorder(
                    //   borderSide: BorderSide(
                    //     color: Colors.blue[50],
                    //   ),
                    //   borderRadius: BorderRadius.circular(5.0),
                    // ),
                    //hintText: "$content",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.teal[900],
                        width: 2.5,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    fillColor: Color.fromRGBO(24, 74, 69, 1),
                    suffixIcon:
                        (text == 'Lozinka*' || text == 'Potvrdi lozinku*')
                            ? text == 'Lozinka*'
                                ? (isHiddenPass1 == true
                                    ? visibilityOff(1)
                                    : visibilityOn(1))
                                : (isHiddenPass2 == true
                                    ? visibilityOff(2)
                                    : visibilityOn(2))
                            : null,
                  ),
                  obscureText: text == 'Lozinka*'
                      ? (isHiddenPass1 == true ? true : false)
                      : text == 'Potvrdi lozinku*'
                          ? (isHiddenPass2 == true ? true : false)
                          : false),
            ),
          ],
        ),
      ),
    );
  }

  Widget visibilityOn(int ind) {
    return IconButton(
        icon: Icon(Icons.visibility),
        onPressed: () {
          setState(() {
            ind == 1 ? isHiddenPass1 = true : isHiddenPass2 = true;
          });
        });
  }

  Widget visibilityOff(int ind) {
    return IconButton(
      icon: Icon(Icons.visibility_off),
      onPressed: () {
        setState(() {
          ind == 1 ? isHiddenPass1 = false : isHiddenPass2 = false;
        });
      },
    );
  }

  void _showSnakBarMsg(String msg) {
    _scaffoldstate.currentState
        .showSnackBar(new SnackBar(content: new Text(msg)));
  }
}