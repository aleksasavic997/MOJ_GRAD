import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mojgradapp/functions/bottomNavigationBar.dart';
import 'package:mojgradapp/functions/filterDrawer.dart';
import 'package:mojgradapp/models/category.dart';
import 'package:mojgradapp/models/city.dart';
import 'package:mojgradapp/screens/posts/showPosts.dart';

class HomePage extends StatefulWidget {
  //static int filterIndex;
  static int fromFollowers=0;
  static bool activeChallenge=false;
  static String sortByReactions='Po vremenu';
  static City city;
  static List<Category> categories;

  final String jwt;
  final Map<String, dynamic> payload;
  static int ind = 5;
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
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text("Početna strana");

  TextEditingController _searchView = new TextEditingController();
  //  List<PostInfo> postList = new List<PostInfo>();
  //  List<PostInfo> filterPosts;
  static bool firstSearch = true;
  bool _searchActive = false;
  static String query = "";

  HomePageState() {
    _searchView.addListener(() {
      if (_searchView.text.isEmpty) {
        setState(() {
          firstSearch = true;
          query = "";
        });
      } else {
        setState(() {
          firstSearch = false;
          query = _searchView.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: _searchActive == false
          ? new AppBar(
              //leading: IconButton(icon: new Icon(Icons.arrow_back),onPressed: (){},),
              //automaticallyImplyLeading: false,
              title: cusSearchBar,
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    setState(() {
                      _searchActive = true;
                    });
                  },
                ),
                IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.mapMarkedAlt,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/mapPage');
                  },
                )
              ],
            )
          : new AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    _searchActive = false;
                    query = "";
                  });
                },
              ),
              title: //Expanded(
                  //width: 300,
                  TextField(
                //expands: true,
                style: TextStyle(color: Colors.white),
                autofocus: true,
                controller: _searchView,
                decoration: InputDecoration(
                  hintText: "Pretrazi",
                  hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.5), fontSize: 18),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                ),
                cursorColor: Colors.white,
                showCursor: true,
              ),
            ),
      drawer: FilterDrawer(),
      drawerEnableOpenDragGesture: true,
      body: ShowPosts(),
      bottomNavigationBar: MyBottomNavigationBar(
        value: 0,
      ),
    );
  }
}
