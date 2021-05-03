import 'dart:convert';
import 'dart:typed_data';

import 'package:WEB_flutter/models/sponsor.dart';
import 'package:WEB_flutter/screens/homePage/showSponsors.dart';
import 'package:WEB_flutter/services/token.dart';
import 'package:WEB_flutter/services/APIServices.dart';
import 'package:flutter/material.dart';
import 'package:WEB_flutter/hover_extensions.dart';
import 'package:universal_html/prefer_universal/html.dart' as html;

import 'showSponsors.dart';

class SponsorsDialog extends StatefulWidget {
  @override
  SponsorsDialogState createState() => SponsorsDialogState();
}

class SponsorsDialogState extends State<SponsorsDialog> {
  TextEditingController controllerName = new TextEditingController();
  TextEditingController controllerDescription = new TextEditingController();

  static BuildContext dialogContext;

  TextEditingController controllerWebSiteLink = new TextEditingController();
  TextEditingController controllerFacebookLink = new TextEditingController();
  TextEditingController controllerInstagramLink = new TextEditingController();
  TextEditingController controllerYouTubeLink = new TextEditingController();
  TextEditingController controllerTwitterLink = new TextEditingController();

  String sponsorName;
  String sponsorDescription;
  String sponsorImagePath;
  String sponsorFacebookLink;
  String sponsorTwitterLink;
  String sponsorYouTubeLink;
  String sponsorInstagramLink;
  String sponsorWebsiteLink;

  String name = '';
  String error;
  Uint8List data;

  bool setImage = false;
  bool setName = false;
  bool setDescription = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('Dodaj sponzora'),
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              Navigator.pop(dialogContext);
            },
            child: Icon(Icons.close),
          ).showPointerOnHover,
        ],
      ),
      content: Row(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildChildLeft(context),
            ],
          ),
          SizedBox(
            width: 20,
          ),
          _buildChildRight()
        ],
      ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: FlatButton(
            padding: EdgeInsets.symmetric(horizontal: 20),
            color: Color.fromRGBO(24, 74, 69, 1),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPressed: () async {
              if(controllerDescription.text.isEmpty)
              {
                setState(() {
                  setDescription = true;
                });
              }
              if(controllerName.text.isEmpty)
              {
                setState(() {
                  setName = true;
                });
              }
              if(name == "")
              {
                setState(() {
                  setImage = true;
                });
              }
              if (setName == false &&
                  setDescription == false &&
                  setImage == false) {
                String base64Image = base64Encode(data);
                APIServices.addImageForWeb(Token.jwt, base64Image)
                    .then((value) async {
                  String _image = jsonDecode(value);
                  print(_image);
                  //DateTime time = DateTime.now();
                  APIServices.addSponsor(
                      Token.jwt,
                      new Sponsor(
                          sponsorName,
                          sponsorDescription,
                          //sponsorImagePath,
                          _image,
                          sponsorFacebookLink,
                          sponsorTwitterLink,
                          sponsorYouTubeLink,
                          sponsorInstagramLink,
                          sponsorWebsiteLink));
                  Navigator.pop(dialogContext);
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ShowSponsors()));
                });
              }
              else
              {
                setState(() {
                  
                });
                SponsorsDialog();
              }
            },
            child: Text(
              'Dodaj',
              style: TextStyle(color: Colors.grey[200]),
            ),
          ),
        )
      ],
    );
  }

  Widget textFieldForLink(TextEditingController controller, String hintText) {
    if (controller == controllerWebSiteLink) {
      print('kontroller za web sajt');
    }
    return TextField(
      cursorColor: Color.fromRGBO(24, 74, 69, 1),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(24, 74, 69, 1),
            width: 2.5,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      // controller: controllerTitle,
      onChanged: (inputText) {
        if (controller == controllerWebSiteLink) {
          setState(() {
            sponsorWebsiteLink = inputText;
          });
        } else if (controller == controllerYouTubeLink) {
          setState(() {
            sponsorYouTubeLink = inputText;
          });
        }
        if (controller == controllerFacebookLink) {
          setState(() {
            sponsorFacebookLink = inputText;
          });
        }
        if (controller == controllerInstagramLink) {
          setState(() {
            sponsorInstagramLink = inputText;
          });
        }
        if (controller == controllerTwitterLink) {
          setState(() {
            sponsorTwitterLink = inputText;
          });
        }
      },
    );
  }

  Widget _buildChildRight() {
    return Container(
        height: 500,
        width: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text('Link do sajta sponzora'),
            ),
            textFieldForLink(controllerWebSiteLink, 'Link sajta'),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text('Link do Facebook stranice sponzora'),
            ),
            textFieldForLink(controllerFacebookLink, 'Facebook link'),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text('Link do Instagram stranice sponzora'),
            ),
            textFieldForLink(controllerInstagramLink, 'Instagram link'),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text('Link do YouTube stranice sponzora'),
            ),
            textFieldForLink(controllerYouTubeLink, 'YouTube link'),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text('Link do Twitter stranice sponzora'),
            ),
            textFieldForLink(controllerTwitterLink, 'Twitter link')
          ],
        ));
  }

  Widget _buildChildLeft(BuildContext context) {
    return Center(
      child: Container(
        //padding: EdgeInsets.all(20.0),
        //height: MediaQuery.of(context).size.height * 0.7,
        width: 430,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          //color: Colors.white70.withOpacity(0.95),
          //color: Colors.red,
        ),
        child: Container(
          child: Column(
            children: <Widget>[
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
                height: MediaQuery.of(context).size.height * 0.3,
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
              setImage == true
                  ? Text(
                      'Morate uneti sliku.',
                      style: TextStyle(color: Colors.red),
                    )
                  : Container(),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                cursorColor: Color.fromRGBO(24, 74, 69, 1),
                controller: controllerName,
                decoration: InputDecoration(
                  hintText: 'Naziv sponzora',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(24, 74, 69, 1),
                      width: 2.5,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                // controller: controllerTitle,
                onChanged: (inputText) {
                  setState(() {
                    sponsorName = inputText;
                    setName = inputText == "" ? true : false;
                  });
                },
              ),
              setName == true
                  ? Text(
                      'Morate uneti naziv sponzora.',
                      style: TextStyle(color: Colors.red),
                    )
                  : Container(),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                cursorColor: Color.fromRGBO(24, 74, 69, 1),
                controller: controllerDescription,
                decoration: InputDecoration(
                  hintText: 'Opis',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(24, 74, 69, 1),
                      width: 2.5,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                maxLength: 200,
                maxLines: 6,
                onChanged: (inputText) {
                  setState(() {
                    sponsorDescription = inputText;
                    setDescription = inputText == "" ? true : false;
                  });
                },
              ),
              setDescription == true
                  ? Text(
                      'Morate uneti opis.',
                      style: TextStyle(color: Colors.red),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

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
          //////////////
          sponsorImagePath = name;
          //////////////
          data = base64.decode(stripped);
          error = null;
          setImage = name == "" ? true : false;
        });
      });
    });

    input.click();
  }
}
