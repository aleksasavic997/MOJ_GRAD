import 'package:WEB_flutter/models/modelsViews/userInfo.dart';
import 'package:WEB_flutter/screens/userProfile/profileBodyTabletMobile.dart';
import 'package:flutter/material.dart';
import '../homePage/navigatinBar.dart';

class UserProfileTabletMobile extends StatefulWidget {

  final UserInfo user;

  const UserProfileTabletMobile({this.user});

  @override
  _UserProfileTabletMobileState createState() => _UserProfileTabletMobileState(user);
}

class _UserProfileTabletMobileState extends State<UserProfileTabletMobile> {

  UserInfo user;
  _UserProfileTabletMobileState(UserInfo user){
    this.user=user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              SmallNavigationBar(),
              SizedBox(height: 20,),
              ProfileBodyTabletMobile(user: user,)
            ],
          ),
        ),
      ),
    );
  }
}