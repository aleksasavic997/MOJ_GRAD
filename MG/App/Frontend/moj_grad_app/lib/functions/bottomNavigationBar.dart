import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:mojgradapp/main.dart';
import 'package:mojgradapp/screens/profilePage.dart';
import 'package:mojgradapp/services/APINotifications.dart';
import 'package:mojgradapp/services/APIUsers.dart';
import 'package:mojgradapp/services/token.dart';

class MyBottomNavigationBar extends StatefulWidget {
  static Color colorNotificaion = Colors.white;
  @override
  int pageIndex = 0;
  final int value;
  MyBottomNavigationBar({this.value}) {
    pageIndex = value;
  }
  _MyBottomNavigationBarState createState() =>
      _MyBottomNavigationBarState(pageIndex);
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  void setColor() async {
    if ((await APINotification.getAllNotReadNotifications(Token.jwt)).length ==
        0) {
      setState(() {
        MyBottomNavigationBar.colorNotificaion = Colors.white;
      });
    } else {
      setState(() {
        MyBottomNavigationBar.colorNotificaion = Colors.red;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    setColor();
  }

  @override
  int _currentIndex = 0;

  _MyBottomNavigationBarState(value) {
    _currentIndex = value;
  }

  void callPage(int currentIndex) async {
    switch (currentIndex) {
      case 0:
        Navigator.of(context).pushNamed('/home');
        break;
      case 1:
        Navigator.of(context).pushNamed('/filter');
        break;
      case 2:
        Navigator.of(context).pushNamed('/newPost');
        break;
      case 3:
        Navigator.of(context).pushNamed('/notification');
        break;
      case 4:
        ProfilePage.user =
            await APIUsers.getUserInfoById(loginUser.id, Token.jwt);
        Navigator.of(context).pushNamed('/profile');
        break;
      default:
        Navigator.of(context).pushNamed('/home');
        break;
    }
  }

  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: _currentIndex,
      animationDuration: Duration(milliseconds: 200),
      animationCurve: Curves.bounceInOut,
      onTap: (index) {
        setState(() {
          callPage(index);
        });
      },
      color: Theme.of(context).primaryColor,
      backgroundColor: Theme.of(context).backgroundColor,
      buttonBackgroundColor: Theme.of(context).primaryColor,
      height: 50,
      items: <Widget>[
        Icon(Icons.home, size: 20, color: Colors.white),
        Icon(Icons.business_center, size: 20, color: Colors.white),
        Icon(Icons.add, size: 20, color: Colors.white),
        Icon(Icons.notifications,
            size: 20, color: MyBottomNavigationBar.colorNotificaion),
        Icon(Icons.person, size: 20, color: Colors.white),
      ],
    );
  }
}
