import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:mojgradapp/models/city.dart';
import 'package:mojgradapp/services/APIServices.dart';
import '../models/userData.dart';
import 'loginPage.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String name = "";
  String lastname = "";
  String email = "";
  String phone = "";
  int cityId = 1;
  int points = 0;
  String username = "";
  String password = "";
  String password2 = "";
  String profilePhoto = "Upload//UserProfileImage//profileDefault.png";
  var _currentCity;

  final GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();

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
      child: SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(top: 50.0, right: 20.0, left: 20.0, bottom: 20.0),
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
              SizedBox(
                height: 30.0,
              ),
              _cities(),
              SizedBox(
                height: 20.0,
              ),
              textFieldBuilder('Ime*', Icon(Icons.person)),
              SizedBox(
                height: 20.0,
              ),
              textFieldBuilder('Prezime*', Icon(Icons.person_outline)),
              SizedBox(
                height: 20.0,
              ),
              textFieldBuilder('Email*', Icon(Icons.email)),
              SizedBox(
                height: 20.0,
              ),
              textFieldBuilder('Korisničko ime*', Icon(Icons.person_pin)),
              SizedBox(
                height: 20.0,
              ),
              textFieldBuilder('Lozinka*', Icon(Icons.lock)),
              SizedBox(
                height: 20.0,
              ),
              textFieldBuilder('Potvrdi lozinku*', Icon(Icons.vpn_key)),
              SizedBox(
                height: 20.0,
              ),
              textFieldBuilder('Broj telefona', Icon(Icons.phone_android)),
              SizedBox(
                height: 20.0,
              ),
              buildButtonContainer('REGISTRACIJA'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cities() {
    return Container(
      padding: EdgeInsets.all(10),
      height: 56,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: FutureBuilder<List<City>>(
          future: APIServices.fetchCity(),
          builder: (BuildContext context, AsyncSnapshot<List<City>> snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
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
                    _currentCity = value;
                  });
                },
                isExpanded: false,
                hint: Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_city,
                      color: Colors.grey[600],
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      _currentCity == null
                          ? 'Izaberite grad*'
                          : _currentCity.name,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget textFieldBuilder(String hintText, Icon icon) {
    return TextField(
        onChanged: (val) async {
          setState(() {
            switch (hintText) {
              case 'Ime*':
                name = val;
                break;
              case 'Prezime*':
                lastname = val;
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
              case 'Broj telefona':
                phone = val;
                break;
            }
          });
        },
        decoration: InputDecoration(
          prefixIcon: icon,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[800], fontSize: 16.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        obscureText: (hintText == 'Lozinka*' || hintText == 'Potvrdi lozinku*')
            ? true
            : false);
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
          print('blblabla');
          if (username.isEmpty ||
              name.isEmpty ||
              lastname.isEmpty ||
              email.isEmpty ||
              password.isEmpty ||
              password2.isEmpty ||
              _currentCity == null)
            _showSnakBarMsg('Niste uneli sve podatke.');
          else if ((await UserData.checkEmail(email)) == "true")
            _showSnakBarMsg('Email adresa je zauzeta.');
          else if (UserData.isEmail(email) == false)
            _showSnakBarMsg('Email adresa nije u ispravnom formatu.');
          else if (UserData.isNameOrLastName(name) == false)
            _showSnakBarMsg('Ime može sadržati samo slova.');
          else if (UserData.isNameOrLastName(lastname)==false)
            _showSnakBarMsg('Prezime može sadržati samo slova.');
          else if ((await UserData.checkUsername(username)) == "true")
            _showSnakBarMsg('Korisničko ime je zauzeto.');
          else if (password2 != password)
            _showSnakBarMsg('Lozinke se ne poklapaju.');
          else if (UserData.isPass(password) == false)
            _showSnakBarMsg(
                'Lozinka mora imati najmanje 8 karaktera, jedno slovo i jedan broj.');
          else if (phone != "" && UserData.isPhone(phone) == false)
            _showSnakBarMsg('Broj telefona nije u ispravnom formatu.');
          else {
            var shaPass1 = utf8.encode(password);
            var shaPass = sha1.convert(shaPass1);
            UserData u = new UserData(
                name,
                lastname,
                username,
                shaPass.toString(),
                email,
                phone,
                _currentCity.id,
                profilePhoto,
                1,
                false);
            //ProfilePage().setUser(u);
            bool res = await UserData.registration(u);
            if (res == true) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            } else {
              _showSnakBarMsg('Došlo je do greške. Pokušajte ponovo.');
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

  void _showSnakBarMsg(String msg) {
    _scaffoldstate.currentState
        .showSnackBar(new SnackBar(content: new Text(msg)));
  }
}
