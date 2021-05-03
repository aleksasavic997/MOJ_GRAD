import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:WEB_flutter/screens/homePage/homePageDesktop.dart';
import 'package:WEB_flutter/screens/homePage/homePageTabletMobile.dart';


class HomePage extends StatefulWidget {
  final String jwt;
  final Map<String, dynamic> payload;
  static bool menuShow = false;
  static bool notificationShow = false;

  HomePage(this.jwt, this.payload);

  factory HomePage.fromBase64(String jwt) => HomePage(
        jwt,
        json.decode(
          ascii.decode(
            base64.decode(
              base64.normalize(jwt.split(".")[1]),
            ),
          ),
        ),
      );
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GestureDetector(
        onTap: (){
          setState(() {
            HomePage.menuShow = false;
            HomePage.notificationShow = false;
          });
        },
        child: ScreenTypeLayout(
          desktop: HomePageDesktop(),
          tablet: HomePageTabletMobile(),
          mobile: HomePageTabletMobile(),
        ),
      )
    );
  }
}
