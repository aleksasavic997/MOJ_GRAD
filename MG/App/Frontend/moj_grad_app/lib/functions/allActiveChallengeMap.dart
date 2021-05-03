import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong/latlong.dart';
import 'package:mojgradapp/models/category.dart';
import 'package:mojgradapp/models/modelsViews/postInfo.dart';
import 'package:mojgradapp/screens/posts/postReview.dart';
import 'package:mojgradapp/services/APIPosts.dart';
import 'package:mojgradapp/services/APIServices.dart';
import 'package:mojgradapp/services/token.dart';
import '../main.dart';
import 'package:mojgradapp/screens/posts/showPosts.dart';

class MapPageAll extends StatefulWidget {
  static var conn;
  final double postLatitude;
  final double postLongitude;
  MapPageAll({this.postLatitude = 0, this.postLongitude = 0});
  @override
  _MapPageAllState createState() =>
      _MapPageAllState(postLatitude, postLongitude);
}

class _MapPageAllState extends State<MapPageAll> {
  double postLatitude;
  double postLongitude;

  _MapPageAllState(double postLatitude1, double postLongitude1) {
    postLatitude = postLatitude1;
    postLongitude = postLongitude1;
  }

  List<PostInfo> listPosts = [];
  List<PostInfo> list = [];
  List<Category> categories = [];

  _getCategories() async {
    List<Category> listCategory = await APIServices.fetchCategories(Token.jwt);
    setState(() {
      categories = listCategory;
    });
  }

  _getPosts() async {
    List<Category> categories = new List<Category>();
    List<PostInfo> newlistPosts = await APIPosts.getFilteredPosts(
        Token.jwt, loginUser.cityId, 0, 1, 0, categories);
    for (var item in newlistPosts) {
      if(item.cityID == loginUser.cityId)
      list.add(item);
    }
    setState(() {
      listPosts = list;
    });
  }

  @override
  void initState() {
    super.initState();
    _getPosts();
    _getCategories();
  }

  @override
  Widget build(BuildContext context) {
    List<Marker> markers = [];
    if (listPosts != null)
      for (var i = 0; i < listPosts.length; i++) {
        print('OVDE SAAAAAM BLA BLA BLAAAA');
        markers.add(
          new Marker(
            point: new LatLng(listPosts[i].latitude, listPosts[i].longitude),
            builder: (ctx) => new Container(
                child: IconButton(
              icon: FaIcon(FontAwesomeIcons.mapPin, size: 40.0),
              iconSize: 40.0,
              color: _setColor(listPosts[i].categoryId),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => PostReview(post: listPosts[i]),
                  /*onTap: () {
                    ViewPost.postId = listPosts[i].id;
                    Navigator.of(MapPageAll.conn).pushNamed('/viewPost');
                    
                  },*/
                );
              },
            )),
          ),
        );
      }

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            _legendPopUp(),
          ],
        ),
        body: (list == null || (list != null && list.length == 0)) ? Center(child: Text('Trenutno nema aktivnih izazova za odabrani grad.'),) : FlutterMap(
          options: new MapOptions(
            center: new LatLng(list[0].latitude, list[0].longitude),
          ),
          layers: [
            new TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
            new MarkerLayerOptions(markers: markers),
          ],
        ));
  }

  Color _setColor(int categoryId) {
    var color;
    switch (categoryId) {
      case 1:
        color = Colors.amber;
        break;
      case 2:
        color = Colors.cyan;
        break;
      case 3:
        color = Colors.pink;
        break;
      case 4:
        color = Colors.purple;
        break;
      default:
    }
    return color;
  }

  Widget _legendPopUp() {
    return PopupMenuButton<String>(
      icon: FaIcon(FontAwesomeIcons.mapPin, size: 20.0),
      onSelected: (String value) {},
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        for (var cat in categories)
          PopupMenuItem<String>(
              child: Row(
            children: <Widget>[
              FaIcon(
                FontAwesomeIcons.squareFull,
                size: 40.0,
                color: _setColor(cat.id),
              ),
              SizedBox(
                width: 10,
              ),
              Text(cat.name),
            ],
          )),
      ],
    );
  }
}
