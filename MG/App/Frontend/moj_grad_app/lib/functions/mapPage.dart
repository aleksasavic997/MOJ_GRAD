import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mojgradapp/functions/map.dart';

class MapPage extends StatelessWidget {
  double longitude;
  double latitude;
  MapPage(double aa, double bb) {
    longitude = aa;
    latitude = bb;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
        // leading: IconButton(
        //   icon: new Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
      ),
      body: Map(longitude, latitude),
    );
  }
}
