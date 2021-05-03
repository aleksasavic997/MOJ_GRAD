import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mojgradapp/config/config.dart';
import 'package:mojgradapp/models/modelsViews/postInfo.dart';
import 'package:mojgradapp/models/post.dart';
import 'package:mojgradapp/screens/posts/viewPostPage.dart';
import 'package:mojgradapp/services/APIChallengeAndSolution.dart';
import 'package:mojgradapp/services/token.dart';
import 'package:path/path.dart';
import 'package:mojgradapp/main.dart';

class SolutionDialog extends StatefulWidget {
  static PostInfo post;
  @override
  _SolutionDialogState createState() => _SolutionDialogState();
}

class _SolutionDialogState extends State<SolutionDialog> {
  TextEditingController controllerDescription = new TextEditingController();
  // TextEditingController controllerTitle = new TextEditingController();

  //final GlobalKey<ScaffoldState> _scaffoldstate =
  //  new GlobalKey<ScaffoldState>();

  File _image;

  @override
  Widget build(BuildContext context) {
    return Dialog(
        //key: _scaffoldstate,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: _buildChild(context));
  }

  _buildChild(BuildContext context) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          //height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white70.withOpacity(0.95),
          ),
          child: Column(
            children: <Widget>[
              /* TextField(
                decoration: InputDecoration(hintText: 'Naslov'),
                maxLines: null,
                controller: controllerTitle,
              ),
              SizedBox(
                height: 20.0,
              ),*/
              Container(
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
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.7,
                child: _image != null
                    ? new Image(image: FileImage(_image))
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
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                decoration: InputDecoration(hintText: 'Opis'),
                maxLines: null,
                controller: controllerDescription,
              ),
              SizedBox(
                height: 10.0,
              ),
              Align(
                alignment: Alignment.center,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.teal[800],
                    textColor: Colors.white,
                    child: Text('Objavi'),
                    onPressed: () async {
                      upload(_image);
                      DateTime time = DateTime.now();
                      ViewPost.solution = new Post(
                          loginUserID,
                          _makeTitle(),
                          //controllerTitle.text,
                          controllerDescription.text,
                          SolutionDialog.post.categoryId,
                          time,
                          SolutionDialog.post.location,
                          2,
                          "Upload//PostImages//${basename(_image.path)}",
                          SolutionDialog.post.longitude,
                          SolutionDialog.post.latitude,
                          SolutionDialog.post.cityID);
                      int postID = await APIChallengeOrSolution.addSolution(
                          Token.jwt, ViewPost.postId, ViewPost.solution);
                      if (postID != 0) {
                        print("Uspesno ste dodali resenje.");

                        /*int isApproved = 0;
                        if (await (APIServices.isSolutionApproved(
                                Token.jwt, ViewPost.solution.id)) ==
                            true) isApproved = 1;
                        PostInfo postInfo =
                            (await APIServices.getChallengeOrSolution(
                                Token.jwt, ViewPost.postId, 3, isApproved))[0]; */
                        ViewPost.postId = postID;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewPost(),
                          ),
                        ).then((value) =>
                            sendNotification(SolutionDialog.post.userId));
                      } else
                        print("Doslo je do greske.");
                    }),
              ),
            ],
          ),
        ),
      );

  String _makeTitle() {
    String title = "Rešenje izazova: ";
    title += SolutionDialog.post.title;
    return title;
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

  upload(File imageFile) async {
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

  /*void _showSnakBarMsg(String msg) {
    _scaffoldstate.currentState
        .showSnackBar(new SnackBar(content: new Text(msg)));
  }*/
}
