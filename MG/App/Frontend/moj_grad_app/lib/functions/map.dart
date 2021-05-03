import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class Map extends StatelessWidget {
  double longitude;
  double latitude;
  Map(double aa, double bb) {
    longitude = bb;
    latitude = aa;
  }
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
        options: new MapOptions(
            center: new LatLng(latitude, longitude), minZoom: 10.0),
        layers: [
          new TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          new MarkerLayerOptions(markers: [
            new Marker(
                width: 45.0,
                height: 45.0,
                point: new LatLng(latitude, longitude),
                builder: (context) => new Container(
                  child: ListTile(
                    title: IconButton(
                      icon: Icon(Icons.location_on),
                      color: Colors.red,
                      iconSize: 45.0,
                      onPressed: () {
                        print("Koordinate: ($longitude, $latitude)");
                      },
                    ),
                  ),
                ))
          ])
        ],

    );
  }
}
