import 'package:WEB_flutter/models/modelsViews/userInfo.dart';
import 'package:WEB_flutter/screens/userProfile/userProfileDesktop.dart';
import 'package:WEB_flutter/screens/userProfile/userProfileTabletMobile.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class UserProfile extends StatefulWidget {

  final UserInfo user;

  const UserProfile({this.user});

  @override
  _UserProfileState createState() => _UserProfileState(user);
}

class _UserProfileState extends State<UserProfile> {
  
  UserInfo user;
  _UserProfileState(UserInfo user){
    this.user=user;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      desktop: UserProfileDesktop(user: user,),
      tablet: UserProfileTabletMobile(user: user,),
      mobile: UserProfileTabletMobile(user: user,),
    );
  }
}