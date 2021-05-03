import 'package:WEB_flutter/models/modelsViews/userInfo.dart';
import 'package:WEB_flutter/screens/userProfile/userInformation.dart';
import 'package:WEB_flutter/screens/userProfile/userPosts.dart';
import 'package:flutter/material.dart';
import 'package:WEB_flutter/screens/userProfile/picAndEdit.dart';

class ProfileBodyTabletMobile extends StatefulWidget {
  final UserInfo user;

  const ProfileBodyTabletMobile({this.user});

  @override
  _ProfileBodyTabletMobileState createState() =>
      _ProfileBodyTabletMobileState(user);
}

class _ProfileBodyTabletMobileState extends State<ProfileBodyTabletMobile> {
  UserInfo user;
  _ProfileBodyTabletMobileState(UserInfo user) {
    this.user = user;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1280,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.black26),
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
              flex: 10,
              child: PicAndEdit(
                name: user.name,
                lastname: user.lastname,
                city: user.cityName,
                profilePhoto: user.profilePhoto,
              )),
          SizedBox(
            height: 20,
          ),
          Expanded(
              flex: 5,
              child: UserInformation(
                username: user.username,
                email: user.email,
                points: user.points,
              )),
          Expanded(
            flex: 6,
            child: UserPosts2(user: user),
          )
        ],
      ),
    );
  }
}
