import 'package:WEB_flutter/models/modelsViews/userInfo.dart';
import 'package:WEB_flutter/screens/userProfile/picAndEdit.dart';
import 'package:WEB_flutter/screens/userProfile/userInformation.dart';
import 'package:WEB_flutter/screens/userProfile/userPosts.dart';
import 'package:flutter/material.dart';

class ProfileBodyDesktop extends StatefulWidget {
  final UserInfo user;

  const ProfileBodyDesktop({this.user});

  @override
  _ProfileBodyDesktopState createState() => _ProfileBodyDesktopState(user);
}

class _ProfileBodyDesktopState extends State<ProfileBodyDesktop> {
  UserInfo user;
  _ProfileBodyDesktopState(UserInfo user) {
    this.user = user;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.black26),
      padding: EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: PicAndEdit(
                name: user.name,
                lastname: user.lastname,
                city: user.cityName,
                profilePhoto: user.profilePhoto,
                id: user.id,
              )),
          SizedBox(
            width: 20,
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 620,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                      flex: 6,
                      child: UserInformation(
                        username: user.username,
                        email: user.email,
                        points: user.points,
                        rankName: user.rankName,
                      )),
                  SizedBox(
                    height: 18,
                  ),
                  Expanded(
                      flex: 7,
                      child: UserPosts2(
                        user: user,
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
