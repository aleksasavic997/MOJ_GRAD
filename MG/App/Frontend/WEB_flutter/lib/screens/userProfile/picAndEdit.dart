import 'package:WEB_flutter/config/config.dart';
import 'package:WEB_flutter/main.dart';
import 'package:WEB_flutter/screens/homePage/home.dart';
import 'package:WEB_flutter/services/APIUsers.dart';
import 'package:WEB_flutter/services/token.dart';
import 'package:flutter/material.dart';
import 'package:WEB_flutter/hover_extensions.dart';

import '../../main.dart';

class PicAndEdit extends StatefulWidget {
  final String name;
  final String lastname;
  final String city;
  final String profilePhoto;
  final int id;

  const PicAndEdit(
      {this.name, this.lastname, this.city, this.profilePhoto, this.id});

  @override
  _PicAndEditState createState() =>
      _PicAndEditState(name, lastname, city, profilePhoto, id);
}

class _PicAndEditState extends State<PicAndEdit> {
  String name;
  String lastname;
  String city;
  String profilePhoto;
  int id;
  _PicAndEditState(
      String name, String lastname, String city, String profilePhoto, int id) {
    this.name = name;
    this.lastname = lastname;
    this.city = city;
    this.profilePhoto = profilePhoto;
    this.id = id;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Colors.grey[200]),
      height: 620,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Center(
                child: CircleAvatar(
                  backgroundColor: Color.fromRGBO(24, 74, 69, 1),
                  backgroundImage: NetworkImage(wwwrootURL + profilePhoto),
                  radius: 120,
                  child: Container(
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 330) {
                    return Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Ime i prezime',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.black54),
                            ),
                            Text(
                              name + ' ' + lastname,
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.black26))),
                    );
                  } else {
                    return Container(
                      width: 400,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Ime i prezime',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.black54),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  name + ' ' + lastname,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.black26))),
                    );
                  }
                },
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Grad',
                        style: TextStyle(fontSize: 20, color: Colors.black54),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        city,
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black26))),
              ),
              SizedBox(
                height: 50,
              ),
              loginAdmin.isNotEmpty ? Container(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Color.fromRGBO(24, 74, 69, 1),
                      ),
                      child: _buildDeleteUser().showPointerOnHover,
                    )),
              ) : Text(''),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildDeleteUser() {
    if (loginAdmin.isNotEmpty)
      return FloatingActionButton.extended(
        heroTag: id,
        label: Text('Obriši'),
        icon: Icon(Icons.delete),
        backgroundColor: Colors.teal[900],
        onPressed: () {
          createAlertDialog(context, id);
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
      );
    else
      return null;
  }

  createAlertDialog(BuildContext context, int id) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Da li želite trajno da izbrišete ovog korisnika?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  //setState(() {
                    APIUsers.deleteUserOrInstitution(Token.jwt, id).then((value) =>  Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                            builder: (context) =>
                                HomePage.fromBase64(Token.jwt))));
                   
                 // });
                },
                child: Text(
                  'Da',
                  style: TextStyle(color: Colors.black),
                ),
                color: Colors.grey[300],
              ).showPointerOnHover,
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Ne',
                  style: TextStyle(color: Colors.black),
                ),
                color: Colors.grey[300],
              ).showPointerOnHover
            ],
          );
        });
  }
}
