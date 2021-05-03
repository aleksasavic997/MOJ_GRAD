import 'package:WEB_flutter/screens/homePage/navigatinBar.dart';
import 'package:flutter/material.dart';

import 'newAdminDataPageBody.dart';

class NewAdminData extends StatefulWidget {
  @override
  _NewAdminDataState createState() => _NewAdminDataState();
}

class _NewAdminDataState extends State<NewAdminData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: SmallNavigationBar(),
            ),
            NewAdminDataPageBody()
          ],
        ),
      ),
    );
  }
}
