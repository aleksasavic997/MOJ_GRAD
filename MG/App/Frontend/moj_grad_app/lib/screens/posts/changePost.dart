import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mojgradapp/config/config.dart';
import 'package:mojgradapp/functions/loading.dart';
import 'package:mojgradapp/models/post.dart';
import 'package:mojgradapp/services/APIPosts.dart';
import 'package:mojgradapp/services/APIUsers.dart';
import 'package:mojgradapp/services/token.dart';
import 'package:path/path.dart';
import '../../models/modelsViews/postInfo.dart';
import '../homePage.dart';
import '../profilePage.dart';
import 'package:async/async.dart';

class ChangePost extends StatefulWidget {
  static PostInfo post;
  @override
  _ChangePostState createState() => _ChangePostState();
}

class _ChangePostState extends State<ChangePost> {
  bool pom = false;

  Post changePost = new Post.id(
      ChangePost.post.id,
      ChangePost.post.userId,
      ChangePost.post.title,
      ChangePost.post.description,
      ChangePost.post.categoryId,
      ChangePost.post.time,
      ChangePost.post.location,
      ChangePost.post.typeId,
      ChangePost.post.imagePath,
      ChangePost.post.longitude,
      ChangePost.post.latitude,
      ChangePost.post.cityID);

  File _image;

  TextEditingController controllerDescription =
      new TextEditingController(text: ChangePost.post.description);
  TextEditingController controllerTitle =
      new TextEditingController(text: ChangePost.post.title);

  final GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldstate,
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text('Izmena posta'),
          leading: IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () async {
                showDialog(context: context, builder: (context) => Loading());
                changePost.title = controllerTitle.text;
                changePost.description = controllerDescription.text;
                if ((await APIPosts.changePostInfo(Token.jwt, changePost)) ==
                    true) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage.fromBase64(Token.jwt),
                      ));
                } else {
                  _showSnakBarMsg("Doslo je do greske.");
                }
                print(
                    "OPIS  ${controllerDescription.text}  NASLOV ${controllerTitle.text}");
                //poziv fje
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: buildBody(context),
          scrollDirection: Axis.vertical,
        )
        //bottomNavigationBar: MyBottomNavigationBar(2),
        );
  }

  Widget buildBody(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            userSectioon(context),
            imageSectioon(context),
            //actionSectioon(context),
            descriptionSectioon(context),
          ],
        ));
  }

  Widget _profilePicture(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.only(top: 15.0),
      child: FloatingActionButton(
          onPressed: () async {
            ProfilePage.user = await APIUsers.getUserInfoById(
                ChangePost.post.userId, Token.jwt);
            Navigator.of(context).pushNamed('/profile');
            print("UserPictureClick");
          },
          elevation: 0.0,
          child: Container(
            //padding: EdgeInsets.only(top: 20.0),
            width: 55.0,
            height: 55.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    wwwrootURL + ChangePost.post.userProfilePhoto,
                  ),
                  fit: BoxFit.cover,
                ),
                //borderRadius: BorderRadius.circular(30.0),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black87, width: 1.0)),
          )),
    );
  }

  Widget userSectioon(BuildContext context) {
    return Container(
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(child: _profilePicture(context), flex: 1),
          SizedBox(
            width: 12.0,
          ),
          Expanded(
            flex: 4,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FlatButton(
                  padding: EdgeInsets.only(top: 8.0, left: 0.0),
                  onPressed: () async {
                    ProfilePage.user = await APIUsers.getUserInfoById(
                        ChangePost.post.userId, Token.jwt);
                    Navigator.of(context).pushNamed('/profile');
                    print("UsernameClick");
                  },
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        ChangePost.post.username,
                        style: TextStyle(fontSize: 22.0),
                      )),
                  // color: Colors.amber,
                ),
                Container(
                  padding: EdgeInsets.only(top: 0.0),
                  child: Text(ChangePost.post.location,
                      style: TextStyle(color: Colors.grey)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget imageSectioon(BuildContext context) {
    return Container(
      //padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 15.0),
          /*Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Text(
                  ChangePost.post.title,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              IconButton(
                icon: Icon(Icons.create),
                onPressed: () {},
              )
            ],
          ), */
          Container(
            child: TextField(
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.create),
              ),
              maxLines: null,
              controller: controllerTitle,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Stack(
            //alignment: Alignment.topLeft,
            children: <Widget>[
              _image == null
                  ? Image.network(
                      wwwrootURL + ChangePost.post.imagePath,
                      loadingBuilder: (context, child, progress) {
                        return progress == null
                            ? child
                            : CircularProgressIndicator();
                      },
                    )
                  : new Image(
                      image: FileImage(_image),
                    ),
              Padding(
                padding: const EdgeInsets.only(right: 5.0, top: 5.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      FloatingActionButton(
                        heroTag: 'FAB1',
                        onPressed: () {
                          setState(() {
                            pom = !pom;
                          });
                        },
                        child: Icon(
                          pom ? Icons.close : Icons.create,
                          color: Colors.grey[700],
                        ),
                        backgroundColor: Colors.grey[300],
                        //mini: true,
                      ),
                      pom
                          ? Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: Column(
                                children: <Widget>[
                                  FloatingActionButton(
                                    heroTag: 'FAB2',
                                    onPressed: () {
                                      getImageFromCamera();
                                      setState(() {
                                        pom = !pom;
                                      });
                                    },
                                    child: Icon(
                                      Icons.photo_camera,
                                      color: Colors.grey[700],
                                    ),
                                    backgroundColor: Colors.grey[300],
                                    mini: true,
                                  ),
                                  FloatingActionButton(
                                    heroTag: 'FAB3',
                                    onPressed: () {
                                      getImageFromGallery();
                                      setState(() {
                                        pom = !pom;
                                      });
                                    },
                                    child: Icon(
                                      Icons.photo_library,
                                      color: Colors.grey[700],
                                    ),
                                    backgroundColor: Colors.grey[300],
                                    mini: true,
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget actionSectioon(BuildContext context) {
  //   return Container(
  //     child: Row(
  //       children: <Widget>[
          // Padding(
          //   padding: const EdgeInsets.only(top: 7.0),
          //   child: Text(
          //     ChangePost.post.reactionsNumber.toString(),
          //     style: TextStyle(fontSize: 20.0),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 10.0),
          //   child: Text(
          //     ' people reacted to your post',
          //     style: TextStyle(fontSize: 15.0),
          //   ),
          // ),
  //       ],
  //     ),
  //   );
  // }

  Widget descriptionSectioon(BuildContext context) //da se doda google translate
  {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      /*child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
              child: Text(
            ChangePost.post.description,
            style: TextStyle(fontSize: 18),
          )),
          IconButton(
            icon: Icon(Icons.create),
            onPressed: () {},
          )
        ],
      ),*/
      child: TextField(
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.create),
        ),
        maxLines: null,
        controller: controllerDescription,
      ),
      //Text(snapshot.data.description,style: TextStyle(fontSize: 18),)
    );
  }

  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      if (image != null) _image = image;
    });
    upload(_image);
    if(_image != null) changePost.imagePath = "Upload//PostImages//${basename(_image.path)}";
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (image != null) _image = image;
    });
    upload(_image);
    if(_image != null) changePost.imagePath = "Upload//PostImages//${basename(_image.path)}";
  }

  upload(File imageFile) async {
    if (imageFile != null) {
      var stream = new ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();
      var uri = Uri.parse(urlImageUpload);

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

  void _showSnakBarMsg(String msg) {
    _scaffoldstate.currentState
        .showSnackBar(new SnackBar(content: new Text(msg)));
  }
}
