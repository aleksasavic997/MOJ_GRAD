import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mojgradapp/config/config.dart';
import 'package:mojgradapp/main.dart';
import 'package:mojgradapp/models/city.dart';
import 'package:mojgradapp/models/userData.dart';
import 'package:mojgradapp/screens/profilePage.dart';
import 'package:mojgradapp/services/APIServices.dart';
import 'package:mojgradapp/services/APIUsers.dart';
import 'package:mojgradapp/services/token.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
//import 'dart:io';

class ChangeInfo extends StatefulWidget {
  @override
  _ChangeInfoState createState() => _ChangeInfoState();
}

class _ChangeInfoState extends State<ChangeInfo> {
  //File _image;
  final GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();
  //bool isHidden = true;
  TextEditingController controllerInfo = new TextEditingController();
  TextEditingController controllerSifra = new TextEditingController();
  TextEditingController controllerOldPass = new TextEditingController();
  String name = loginUser.name; //"Kristina Z";
  String lastname = loginUser.lastname;
  String username = loginUser.username; //'K.Zajic';
  String pass = loginUser.password; //'*********';
  String email = loginUser.email; //'kkkk@gmail.com';
  String number = loginUser.phone; //'063/*****';
  String profilePhoto = loginUser.profilePhoto;

  File _image;

  Future<String> changeInfo(BuildContext context, String text, int br) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(text,style: TextStyle(color: Colors.black),),
            content: br == 3
                ? SizedBox(
                    height: 250.0,
                    child: SingleChildScrollView(
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Trenutna lozinka',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0,color: Colors.black)),
                          TextField(
                            controller: controllerOldPass,
                            obscureText: true,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(text,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          TextField(
                            controller: controllerInfo,
                            obscureText: true,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text('Potvrdite lozinku',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          TextField(
                            controller: controllerSifra,
                            obscureText: true,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox(
                    height: 70.0,
                    child: Column(
                      children: <Widget>[
                        Text(text,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0)),
                        TextField(
                          controller: controllerInfo,
                        ),
                      ],
                    ),
                  ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text('Promeni'),
                onPressed: () async {
                  switch (br) {
                    case (1):
                      setState(() {
                        name = controllerInfo.text;
                        if (UserData.isNameOrLastName(name) == false) {
                          _showSnakBarMsg('Ime može sadržati samo slova.');
                          name = loginUser.name;
                        }
                      });
                      break;
                    case (2):
                      //setState(() async {
                      setState(() {
                        username = controllerInfo.text;
                      });
                      if ((await UserData.checkUsername(username)) == "true") {
                        _showSnakBarMsg('Korisničko ime je zauzeto.');
                        setState(() {
                          username = loginUser.username;
                        });
                      }

                      // });
                      break;
                    case (3):
                      var pass1 = utf8.encode(controllerOldPass.text);
                      var pass2 = sha1.convert(pass1);
                      if (pass2.toString() != loginUser.password.toString())
                        _showSnakBarMsg('Trenutna lozinka nije tačna.');
                      else if (UserData.isPass(controllerInfo.text) == false)
                        _showSnakBarMsg(
                            'Lozinka mora imati najmanje 8 karaktera, jedno slovo i jedan broj.');
                      //mora ovo lepse da se kaze
                      else if (controllerInfo.text == controllerSifra.text) {
                        var shaPass1 = utf8.encode(controllerSifra.text);
                        var shaPass = sha1.convert(shaPass1);
                        pass = shaPass.toString();
                      } else
                        _showSnakBarMsg('Lozinke se ne poklapaju');
                      break;
                    case (4):
                      //setState(() {
                      setState(() {
                        email = controllerInfo.text;
                      });
                      if ((await UserData.checkEmail(email)) == "true") {
                        _showSnakBarMsg('Email adresa je zauzeta.');
                        setState(() {
                          email = loginUser.email;
                        });
                      } else if (UserData.isEmail(email) == false) {
                        _showSnakBarMsg(
                            'Email adresa nije u ispravnom formatu.');
                        setState(() {
                          email = loginUser.email;
                        });
                      }

                      //});
                      break;
                    case (5):
                      setState(() {
                        number = controllerInfo.text;
                        if (UserData.isPhone(number) == false) {
                          _showSnakBarMsg(
                              'Broj telefona nije u ispravnom formatu.');
                          number = loginUser.phone;
                        }
                      });
                      break;
                    case (6):
                      setState(() {
                        lastname = controllerInfo.text;
                        if (UserData.isNameOrLastName(lastname) == false) {
                          _showSnakBarMsg('Prezime može sadržati samo slova.');
                          lastname = loginUser.lastname;
                        }
                      });
                      break;
                    //case (6) : setState((){imePrezime = controllerInfo.text;}); break;
                  }
                  controllerInfo.text = "";
                  controllerSifra.text = "";
                  controllerOldPass.text = "";
                  Navigator.of(context).pop(controllerInfo.text.toString());
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // Future getImage() async
    // {
    //   var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    //   setState(()
    //   {
    //     _image = image;
    //   });
    // }

    return Scaffold(
        key: _scaffoldstate,
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text('Izmena Profila'),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                //Navigator.of(context).pushNamed('/profile');}),
                Navigator.pop(context);
              }),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () async {
                var city =
                    _currentCity == null ? loginUser.cityId : _currentCity.id;
                print('$name $lastname $username $email $pass $profilePhoto');
                if ((await APIUsers.changeUserInformation(
                        Token.jwt,
                        name,
                        lastname,
                        username,
                        email,
                        pass,
                        profilePhoto,
                        city,
                        number)) ==
                    true) {
                  loginUser =
                      await APIUsers.getUserInfoById(loginUserID, Token.jwt);
                  ProfilePage.user = loginUser;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => new ProfilePage(),
                    ),
                  );
                  _showSnakBarMsg('Uspešno ste zamenili podatke.');
                } else {
                  _showSnakBarMsg('Došlo je do greške.\nPokušajte ponovo.');
                }
                /*uploadPicture(context)*/
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                      child: SizedBox(
                    width: 150.0,
                    height: 150.0,
                    child: FloatingActionButton(
                      onPressed: () {
                        showAlertDialog(context);
                      },
                      child: Stack(
                        children: <Widget>[
                          _image == null
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    wwwrootURL + loginUser.profilePhoto,
                                  ),
                                  radius: 100.0,
                                )
                              : new CircleAvatar(
                                  backgroundImage: new FileImage(_image),
                                  radius: 100.0,
                                ),
                          CircleAvatar(
                            backgroundColor: Colors.grey[100].withOpacity(0.4),
                            radius: 100.0,
                          ),
                          Center(
                            child: Icon(
                              Icons.photo_camera,
                              size: 40.0,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
                  SizedBox(
                    height: 30.0,
                  ),
                  Center(child: _buildCityList()),
                  Text('Ime', style: TextStyle(color: Colors.blueGrey)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                          child: Text(
                        name,
                        style: TextStyle(fontSize: 22.0),
                      )),
                      IconButton(
                        icon: Icon(Icons.create),
                        onPressed: () {
                          changeInfo(context, 'Ime', 1);
                        },
                      )
                    ],
                  ),
                  Text('Prezime', style: TextStyle(color: Colors.blueGrey)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                          child: Text(
                        lastname,
                        style: TextStyle(fontSize: 22.0),
                      )),
                      IconButton(
                        icon: Icon(Icons.create),
                        onPressed: () {
                          changeInfo(context, 'Prezime', 6);
                        },
                      )
                    ],
                  ),
                  Text('Korisničko ime',
                      style: TextStyle(color: Colors.blueGrey)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                          child: Text(
                        username,
                        style: TextStyle(fontSize: 22.0),
                      )),
                      IconButton(
                        icon: Icon(Icons.create),
                        onPressed: () {
                          changeInfo(context, 'Korisničko ime', 2);
                        },
                      )
                    ],
                  ),
                  Text('Lozinka', style: TextStyle(color: Colors.blueGrey)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                          child: Text(
                        'Promenite lozinku',
                        style: TextStyle(fontSize: 22.0),
                      )),
                      IconButton(
                        icon: Icon(Icons.create),
                        onPressed: () {
                          changeInfo(context, 'Lozinka', 3);
                        },
                      )
                    ],
                  ),
                  Text('Email', style: TextStyle(color: Colors.blueGrey)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                          child: Text(
                        email,
                        style: TextStyle(fontSize: 22.0),
                      )),
                      IconButton(
                        icon: Icon(Icons.create),
                        onPressed: () {
                          changeInfo(context, 'Email', 4);
                        },
                      )
                    ],
                  ),
                  Text('Broj telefona',
                      style: TextStyle(color: Colors.blueGrey)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                          child: Text(
                        number,
                        style: TextStyle(fontSize: 22.0),
                      )),
                      IconButton(
                        icon: Icon(Icons.create),
                        onPressed: () {
                          changeInfo(context, 'Broj telefona', 5);
                        },
                      )
                    ],
                  ),
                ],
              )),
        ));
  }

  var _currentCity;
  Widget _buildCityList() {
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
                hint: Text(
                  _currentCity == null ? loginUser.cityName : _currentCity.name,
                  style: TextStyle(fontSize: 17.0, color: Colors.blueGrey),
                ),
                //underline: UnderlineInputBorder(),
              ),
            );
          }),
    );
  }

  void _showSnakBarMsg(String msg) {
    _scaffoldstate.currentState
        .showSnackBar(new SnackBar(content: new Text(msg)));
  }

  showAlertDialog(BuildContext context) {
    Widget camera = FloatingActionButton.extended(
      label: Text('Kamera'),
      icon: Icon(Icons.camera),
      backgroundColor: Colors.teal[900],
      autofocus: true,
      hoverColor: Colors.white70,
      onPressed: () async {
        getImageFromCamera();
      },
    );

    Widget gallery = FloatingActionButton.extended(
        label: Text('Galerija'),
        icon: Icon(Icons.photo),
        backgroundColor: Colors.teal[900],
        hoverColor: Colors.white70,
        onPressed: () async {
          getImageFromGallery();
        });

    AlertDialog alertDialog = AlertDialog(
      content: Container(
        height: 70,
        alignment: Alignment.center,
        child: Text(
          "Promenite profilnu sliku",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        ),
      ),
      actions: <Widget>[camera, gallery],
    );

    showDialog(context: context, child: alertDialog);
  }

  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
    upload(_image);
    if (_image != null)
      profilePhoto = "Upload//UserProfileImage//${basename(_image.path)}";
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
    upload(_image);
    if (_image != null)
      profilePhoto = "Upload//UserProfileImage//${basename(_image.path)}";
  }

  upload(File imageFile) async {
    if (imageFile != null) {
      var stream = new ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();
      var uri = Uri.parse(urlImageUploadProfilePhoto);

      var request = new MultipartRequest("POST", uri);
      var multipartFile = new MultipartFile('files', stream, length,
          filename: basename(imageFile.path));
      //contentType: new MediaType('image', 'png'));
      request.files.add(multipartFile);
      var response = await request.send();
      print(response.statusCode);
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
    }
  }
}
