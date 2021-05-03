import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mojgradapp/config/config.dart';
import 'package:mojgradapp/functions/themes.dart';
import 'package:mojgradapp/screens/allSponsorsPage.dart';
import 'package:mojgradapp/screens/changeInfo.dart';
import 'package:mojgradapp/screens/loginPage.dart';
import 'package:mojgradapp/screens/profilePage.dart';
import 'package:mojgradapp/screens/usersPage.dart';
import 'package:mojgradapp/services/APIServices.dart';
import 'package:mojgradapp/services/token.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../services/APIUsers.dart';

class DrawerProfile extends StatefulWidget {
  @override
  _DrawerProfileState createState() => _DrawerProfileState();
}

class _DrawerProfileState extends State<DrawerProfile> {
  bool darkThemeEnabled = MyApp.ind == 0 ? false : true;

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);

    return Drawer(
        child: ListView(
      children: <Widget>[
        DrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: <Color>[
              Theme.of(context).backgroundColor,
              Theme.of(context).primaryColor,
            ])),
            child: Container(
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      wwwrootURL + loginUser.profilePhoto,
                    ),
                    radius: 50,
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    loginUser.username,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            )),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade400)),
            ),
            height: 50.0,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.settings_brightness),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Tamna tema",
                          style: TextStyle(fontSize: 17.0),
                        ),
                      ),
                      Switch(
                        value: darkThemeEnabled,
                        onChanged: (changedTheme) {
                          //print('pre==$darkThemeEnabled');
                          setState(() {
                            darkThemeEnabled = changedTheme;
                            MyApp.ind = changedTheme ? 1 : 0;
                          });
                          //print('posle==$darkThemeEnabled');
                          changedTheme
                              ? _themeChanger.setTheme(MyApp.basicThameDark())
                              : _themeChanger.setTheme(MyApp.basicThameLight());
                        },
                        activeColor: Colors.white,
                      )
                      /* Switch(
                        value: val,
                        onChanged: (bool e) => something(e),
                        activeColor: Colors.teal[700],
                      )*/
                    ],
                  )
                ]),
          ),
        ),
        CustomizeListTile(
            Icons.edit,
            "Izmena profila",
            () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChangeInfo()))
                }),
        CustomizeListTile(
            Icons.person_add,
            "Otkrijte ljude",
            () => {
                  UsersPage.filterIndex = 0,
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UsersPage()))
                }),
        CustomizeListTile(
            MdiIcons.accountArrowLeftOutline,
            "Pratioci",
            () => {
                  UsersPage.filterIndex = 1,
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UsersPage()))
                }),
        CustomizeListTile(
            MdiIcons.accountArrowRightOutline,
            "Pratite",
            () => {
                  UsersPage.filterIndex = 2,
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UsersPage()))
                }),
        CustomizeListTile(
            Icons.supervisor_account,
            "Sponzori",
            () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AllSponsorsPage()))
                }),
        CustomizeListTile(
            Icons.highlight_off,
            "Deaktivirajte nalog",
            () => {
                  createAlertDialogForDeleteAccount(context, loginUserID),
                }),
        CustomizeListTile(
            Icons.power_settings_new,
            "Odjavite se",
            () => {
                  showAlertDialog(context),
                }),
      ],
    ));
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget yesButton = FlatButton(
       child: Text(
        "DA",
        style: TextStyle(
          color: Colors.teal[800],
          fontSize: 20.0,
          //fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () async {
        // LoginPage().setUsernameAndPassword();
        await APIServices.logOut(Token.jwt, loginUserID);
        await Token.storage.delete(key: "jwt");
        loginUser = null;
        loginUserID = null;

        Navigator.pushNamedAndRemoveUntil(context, "/loginPage", (r) => false);
        
      },
    );

    Widget noButton = FlatButton(
     child: Text(
        "NE",
        style: TextStyle(
          color: Colors.teal[800],
          fontSize: 20.0,
          //fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pushNamed('/profile');
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Odjava", style: TextStyle(color: Colors.black),),
      content: Text("Da li ste sigurni da želite da se odjavite?",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black
          )),
      backgroundColor: Colors.white, //Theme.of(context).primaryColor,
      shape:
      RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25)),
      actions: [
        yesButton,
        noButton,
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

  createAlertDialogForDeleteAccount(BuildContext context, int id) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content:
                Text('Da li ste sigurni da želite trajno da izbrišete nalog?',
                textAlign: TextAlign.center,
              style: TextStyle(
                   fontSize: 20.0,
                   color: Colors.black
                ),
              ),
            backgroundColor: Colors.white, //Theme.of(context).primaryColor,
            shape:
            RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25)),
            actions: <Widget>[
              FlatButton(
                onPressed: () async {
                  await APIServices.logOut(Token.jwt, loginUserID);
                  await APIUsers.deleteUserById(id, Token.jwt);
                  await Token.storage.delete(key: "jwt");
                  loginUser = null;
                  loginUserID = null;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                child: Text(
                  "DA",
                  style: TextStyle(
                    color: Colors.teal[800],
                    fontSize: 20.0,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                color: Colors.white,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "NE",
                  style: TextStyle(
                    color: Colors.teal[800],
                    fontSize: 20.0,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                color: Colors.white,
              )
            ],
          );
        });
  }

  //F-ja za dugme kod promene teme na tamnu ili svetlu
  bool val = true;
  void something(bool e) {
    setState(() {
      if (e) {
        val = true;
        e = true;
      } else {
        val = false;
        e = false;
      }
    });
  }
}
