import 'dart:convert';
import 'dart:typed_data';
import 'package:WEB_flutter/models/modelsViews/postInfo.dart';
import 'package:WEB_flutter/models/post.dart';
import 'package:WEB_flutter/screens/showPost/showPost.dart';
import 'package:WEB_flutter/services/APIChallengdeAndSolution.dart';
import 'package:WEB_flutter/services/APIPosts.dart';
import 'package:WEB_flutter/services/APIServices.dart';
import 'package:WEB_flutter/services/token.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/prefer_universal/html.dart' as html;
import '../../main.dart';

class SolutionDialog extends StatefulWidget {
  static PostInfo post;
  @override
  _SolutionDialogState createState() => _SolutionDialogState();
}

class _SolutionDialogState extends State<SolutionDialog> {
  TextEditingController controllerDescription = new TextEditingController();
  TextEditingController controllerTitle = new TextEditingController();

  String name = '';
  String error;
  Uint8List data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: _buildChild(context)),
      ),
    );
  }

  _buildChild(BuildContext context) => Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            //height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white70.withOpacity(0.95),
            ),
            child: Container(
              child: Column(
                children: <Widget>[
                  TextField(
                    cursorColor: Colors.teal[900],
                    decoration: InputDecoration(
                      hintText: 'Naslov',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(24, 74, 69, 1),
                          width: 2.5,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    maxLines: null,
                    controller: controllerTitle,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: name == ''
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
                    child: name != ''
                        ? new Image.memory(data)
                        : Container(
                            width: MediaQuery.of(context).size.width * 0.65,
                            child: IconButton(
                              icon: Icon(Icons.photo_library),
                              color: Colors.white,
                              iconSize: 50.0,
                              onPressed: () {
                                pickImage();
                              },
                            ),
                          ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    cursorColor: Colors.teal[900],
                    decoration: InputDecoration(
                      hintText: 'Opis',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(24, 74, 69, 1),
                          width: 2.5,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    maxLines: null,
                    controller: controllerDescription,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                            child: Text('Objavi'),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Colors.teal[800],
                            textColor: Colors.white,
                            onPressed: () async {
                              String base64Image = base64Encode(data);
                              APIServices.addImageForWeb(Token.jwt, base64Image)
                                  .then((value) async {
                                String _image = jsonDecode(value);
                                DateTime time = DateTime.now();
                                // ViewPost.solution
                                Post newPost = new Post(
                                    loginInstitutionID,
                                    controllerTitle.text,
                                    controllerDescription.text,
                                    SolutionDialog.post.categoryId,
                                    time,
                                    SolutionDialog.post.location,
                                    2,
                                    _image,
                                    SolutionDialog.post.longitude,
                                    SolutionDialog.post.latitude,
                                    SolutionDialog.post.cityID);
                                int postID = await APIChallengeAndSolution.addSolution(
                                    Token.jwt,
                                    ShowPost.post.id,
                                    newPost); //ViewPost.solution);
                                if (postID != 0) {
                                  print("Uspesno ste dodali resenje.");

                                  ShowPost.post = await APIPosts.getPostByID(
                                      postID, Token.jwt);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ShowPost(),
                                    ),
                                  );
                                } else
                                  print("Doslo je do greske.");
                              });
                            }),
                        SizedBox(
                          width: 10,
                        ),
                        FlatButton(
                          child: Text('Odustani'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  pickImage() {
    final html.InputElement input = html.document.createElement('input');
    input
      ..type = 'file'
      ..accept = 'image/*';

    input.onChange.listen((e) {
      if (input.files.isEmpty) return;
      final reader = html.FileReader();
      reader.readAsDataUrl(input.files[0]);
      reader.onError.listen((err) => setState(() {
            error = err.toString();
          }));
      reader.onLoad.first.then((res) {
        final encoded = reader.result as String;
        final stripped =
            encoded.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');

        setState(() {
          name = input.files[0].name;
          data = base64.decode(stripped);
          error = null;
        });
      });
    });

    input.click();
  }
}
