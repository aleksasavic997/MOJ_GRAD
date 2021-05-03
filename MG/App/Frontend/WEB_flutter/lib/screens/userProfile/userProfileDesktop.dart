import 'package:WEB_flutter/models/modelsViews/userInfo.dart';
import 'package:WEB_flutter/screens/userProfile/profileBodyDesktop.dart';
import 'package:flutter/material.dart';

import '../homePage/centeredView.dart';
import '../homePage/navigatinBar.dart';

class UserProfileDesktop extends StatefulWidget {

  final UserInfo user;

  const UserProfileDesktop({this.user});

  @override
  _UserProfileDesktopState createState() => _UserProfileDesktopState(user);
}

class _UserProfileDesktopState extends State<UserProfileDesktop> {
  
  UserInfo user;
  _UserProfileDesktopState(UserInfo user){
    this.user=user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: CenteredView(
          child: Column(
            children: <Widget>[
              SmallNavigationBar(),
              SizedBox(height: 20,),
              ProfileBodyDesktop(user: user,)
            ],
          ),
        ),
      ),
    );
  }
}