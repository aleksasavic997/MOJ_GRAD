import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:mojgradapp/config/config.dart';
import 'package:mojgradapp/functions/bottomNavigationBar.dart';
import 'package:mojgradapp/functions/loading.dart';
import 'package:mojgradapp/models/category.dart';
import 'package:mojgradapp/models/post.dart';
import 'package:mojgradapp/services/APIPosts.dart';
import 'package:mojgradapp/services/APIServices.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:mojgradapp/services/token.dart';
import 'package:path/path.dart';

import '../../main.dart';
import '../../models/city.dart';
import '../homePage.dart';

class NewPost extends StatefulWidget {
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  Geolocator get geolocator => Geolocator()..forceAndroidLocationManager;

  Position _currentPosition;
  String _currentAddress = "";

  File _image;

  String _title;
  String _description;
  String _location;
  DateTime _time;
  //List<Category> _categories = getCategories();
  Category _currentCategory;
  int _cityId = loginUser.cityId;
  String _category = "Kategorija";

  City _currentCity;

  final GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();

  //--------------------ZA TESTIRANJE---------------------------
  int _userId = loginUserID;
  int _typeId = 1;
  //------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    //_selectedRadio = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldstate,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: buildAppBar(context),
      body: buildBody1(context),
      bottomNavigationBar: MyBottomNavigationBar(
        value: 2,
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        'Kreiranje objave',
        style: Theme.of(context).textTheme.title,
      ),
      //centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.send),
          onPressed: () async {
            if (_title == null)
              _showSnakBarMsg('Morate uneti naslov objave');
            else if (_currentCategory == null)
              _showSnakBarMsg('Morate odabrati kategoriju');
            else if (_description == null)
              _showSnakBarMsg('Morate uneti opis');
            else if (_image == null)
              _showSnakBarMsg('Morate dodati sliku');
            else if (_currentPosition == null || _currentAddress == "")
              _showSnakBarMsg('Morate označiti na mapi, gde se nalazi problem');
            else {
              showDialog(context: context, builder: (context) => Loading());
              upload(_image);
              _time = DateTime.now();
              Post post = new Post(
                  _userId,
                  _title,
                  _description,
                  _currentCategory.id,
                  _time,
                  _location,
                  _typeId,
                  "Upload//PostImages//${basename(_image.path)}",
                  _currentPosition.longitude,
                  _currentPosition.latitude,
                  _currentCity.id);
              print(
                  'LOKACIJAAAAAA ${_currentPosition.longitude}   ${_currentPosition.latitude}');
              print(
                  "$_userId $_title $_description ${_currentCategory.id} $_time $_location $_typeId");
              print(basename(_image.path));
              var response = await APIPosts.addPost(post);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage.fromBase64(Token.jwt),
                  ));
            }
          },
        )
      ],
    );
  }

  showAlertDialog(BuildContext context) {
    Widget camera = FloatingActionButton(
      backgroundColor: Colors.transparent,
      child: Icon(Icons.camera),
      autofocus: true,
      hoverColor: Colors.white70,
      onPressed: () async {
        getImageFromCamera();
      },
    );

    Widget gallery = FloatingActionButton(
        backgroundColor: Colors.transparent,
        child: Icon(Icons.photo),
        hoverColor: Colors.white70,
        onPressed: () async {
          getImageFromGallery();
        });

    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.transparent,
      content: Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[camera, gallery],
          ),
        ),
      ),
      // actions: <Widget>[camera, gallery],
      
    );

    showDialog(context: context, child: alertDialog);
  }

  Widget buildBody1(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        color: Theme.of(context).backgroundColor,
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                buildCategory(),
                buildCityList(),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                labelText: 'Naslov',
              ),
              onChanged: (String text) {
                setState(() {
                  _title = text;
                });
              },
            ),
            SizedBox(
              height: 15,
            ),
            _imageSection(context),
            // _image == null
            //     ? SizedBox(
            //         height: 20.0,
            //       )
            //     :
            Align(
              alignment: Alignment.centerLeft,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  child: _currentAddress == ""
                      ? IconButton(
                          icon: Icon(Icons.location_off),
                          onPressed: () {
                            _getCurrentLocation();
                          })
                      : Row(
                          children: <Widget>[
                            IconButton(
                                icon: Icon(
                                  Icons.location_on,
                                  color: Colors.redAccent,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _currentAddress = "";
                                  });
                                }),
                            Text(_currentAddress),
                          ],
                        ),
                ),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                labelText: 'Opis',
              ),
              onChanged: (String text) {
                setState(() {
                  _description = text;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: _image == null
            ? LinearGradient(
                colors: [
                  Colors.teal[100].withOpacity(0.5),
                  Colors.teal[900].withOpacity(0.5)
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
            : null,
      ),
      //height:
      height: 200,
      child: _image != null
          ? InkWell(
              child: new Image(image: FileImage(_image)),
              onTap: () {
                showAlertDialog(context);
              },
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.photo_camera),
                  iconSize: 50.0,
                  color: Colors.white,
                  onPressed: () {
                    getImageFromCamera();
                  },
                ),
                SizedBox(
                  width: 20.0,
                ),
                IconButton(
                  icon: Icon(Icons.photo_library),
                  color: Colors.white,
                  iconSize: 50.0,
                  onPressed: () {
                    getImageFromGallery();
                  },
                ),
              ],
            ),
    );
  }

  Widget buildCityList() {
    return Container(
      child: FutureBuilder<List<City>>(
          future: APIServices.fetchCity(),
          builder: (BuildContext context, AsyncSnapshot<List<City>> snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return DropdownButtonHideUnderline(
              child: DropdownButton<City>(
                //icon: Icon(Icons.location_city),
                items: snapshot.data
                    .map((city) => DropdownMenuItem<City>(
                          child: Text(city.name),
                          value: city,
                        ))
                    .toList(),
                onChanged: (City value) {
                  setState(() {
                    _currentCity = value;
                  });
                },
                isExpanded: false,
                //value: _currentUser,
                hint: Row(
                  children: <Widget>[
                    Icon(Icons.location_city),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      _currentCity == null
                          ? loginUser.cityName
                          : _currentCity.name,
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.teal[900],
                      ),
                    ),
                  ],
                ),
                //underline: UnderlineInputBorder(),
              ),
            );
          }),
    );
  }

  Widget buildCategory() {
    return Container(
      child: FutureBuilder<List<Category>>(
          future: APIServices.fetchCategories(Token.jwt),
          builder:
              (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return DropdownButtonHideUnderline(
              child: DropdownButton<Category>(
                items: snapshot.data
                    .map((category) => DropdownMenuItem<Category>(
                          child: Text(category.name),
                          value: category,
                        ))
                    .toList(),
                onChanged: (Category value) {
                  setState(() {
                    _currentCategory = value;
                  });
                },
                isExpanded: false,
                //value: _currentUser,
                hint: Row(
                  children: <Widget>[
                    Icon(Icons.category),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      _currentCategory == null
                          ? _category
                          : _currentCategory.name,
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.teal[900],
                      ),
                    ),
                  ],
                ),
                //underline: UnderlineInputBorder(),
              ),
            );
          }),
    );
  }

  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  _getCurrentLocation() async {
    await geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = placemarks[0];

      String address = "";
      if (place.locality != null) address += place.locality;

      if (place.thoroughfare != "")
        address += ", " + place.thoroughfare + " " + place.subThoroughfare;

      if (place.country != null) address += ", " + place.country;

      setState(() {
        _currentAddress = address;
        //"${place.locality},${place.thoroughfare} ${place.subThoroughfare},${place.country}";
        _location = _currentAddress;
      });
    } catch (e) {
      print(e);
    }
  }

  upload(File imageFile) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse(urlImageUpload);

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('files', stream, length,
        filename: basename(imageFile.path));
    //contentType: new MediaType('image', 'png'));
    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  void _showSnakBarMsg(String msg) {
    _scaffoldstate.currentState
        .showSnackBar(new SnackBar(content: new Text(msg)));
  }
}
