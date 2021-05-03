import 'package:WEB_flutter/models/modelsViews/postInfo.dart';
import 'package:WEB_flutter/models/modelsViews/userInfo.dart';
import 'package:WEB_flutter/screens/showPost/showPost_desktop.dart';
import 'package:WEB_flutter/screens/showPost/showPost_tablet.dart';
import 'package:WEB_flutter/services/APIUsers.dart';
import 'package:WEB_flutter/services/token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ShowPost extends StatefulWidget {
  static PostInfo post;
  static UserInfo user;
  @override
  _ShowPostState createState() => _ShowPostState();
}

class _ShowPostState extends State<ShowPost> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: APIUsers.fetchUserData(ShowPost.post.userId, Token.jwt),
        builder: (BuildContext context, AsyncSnapshot<UserInfo> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Container(
                child: SpinKitFadingCircle(
                  color: Color.fromRGBO(24, 74, 69, 1),
                  size: 30,
                ),
              ),
            );
          } else {
            ShowPost.user = snapshot.data;
            return ScreenTypeLayout(
              tablet: PostTablet(),
              mobile: PostTablet(),
              desktop: PostDesktop(),
            );
          }
        });
  }
}
