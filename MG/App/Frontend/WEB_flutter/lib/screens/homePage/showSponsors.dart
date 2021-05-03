import 'package:WEB_flutter/config/config.dart';
import 'package:WEB_flutter/models/sponsor.dart';
import 'package:WEB_flutter/screens/homePage/sponsorsDialog.dart';
import 'package:WEB_flutter/services/APIServices.dart';
import 'package:WEB_flutter/services/token.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:html' as html;
import 'package:WEB_flutter/hover_extensions.dart';
import '../../models/sponsor.dart';
import '../../services/APIServices.dart';
import 'navigatinBar.dart';

class ShowSponsors extends StatefulWidget {
  @override
  _ShowSponsorsState createState() => _ShowSponsorsState();
}

class _ShowSponsorsState extends State<ShowSponsors> {
  @override
  void initState() {
    //getSponsors();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        //controller: controller,
        child: LayoutBuilder(builder: (context, constraints) {
          return Padding(
            padding: constraints.maxWidth > 1400
                ? EdgeInsets.symmetric(horizontal: 70, vertical: 40)
                : EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: <Widget>[
                SmallNavigationBar(),
                SizedBox(
                  height: 20,
                ),
                buildPageBody()
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget buildPageBody() {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(24, 74, 69, 1),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                //naslov
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: Text(
                  'Sponzori',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[200]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FloatingActionButton(
                  heroTag: 'ds',
                  tooltip: 'Dodaj sponzora',
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          SponsorsDialogState.dialogContext = context;
                          return SponsorsDialog();
                        });
                  },
                  child: Icon(
                    Icons.add,
                    size: 30,
                    color: Color.fromRGBO(24, 74, 69, 1),
                  ),
                  backgroundColor: Colors.grey[200],
                ).showPointerOnHover,
              )
            ],
          ),
          Row(
            //linija ispod naslova Sponzori
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.black26))),
                ),
              ),
            ],
          ),
          sponsors()
        ],
      ),
    );
  }

  Widget sponsors() {
    return FutureBuilder(
      future: APIServices.getAllSponsors(Token.jwt),
      initialData: [],
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return CircularProgressIndicator();
        else if (snapshot.data.length == 0)
          return Center(
            child: Text('Trenutno nema sponzora za prikaz'),
          );
        else
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: LayoutBuilder(builder: (context, constraints) {
                if (constraints.maxWidth > 550) {
                  return GridView.count(
                    crossAxisCount: constraints.maxWidth > 1100
                        ? 4
                        : constraints.maxWidth > 850 ? 3 : 2,
                    childAspectRatio: constraints.maxWidth > 1100
                        ? (MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height * 3))
                        : constraints.maxWidth > 850
                            ? (MediaQuery.of(context).size.width /
                                (MediaQuery.of(context).size.height * 2))
                            : (MediaQuery.of(context).size.width /
                                (MediaQuery.of(context).size.height * 1.5)),
                    children: <Widget>[
                      for (var i = 0; i < snapshot.data.length; i++)
                        oneSponsor(
                          snapshot.data[i],
                        )
                    ],
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return oneSponsor(
                        snapshot.data[index],
                      );
                    },
                  );
                }
              }),
            ),
          );
      },
    );
  }

  createAlertDialog(BuildContext context, int id) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Da li želite trajno da izbrišete ovog sponzora?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  setState(() {
                    APIServices.deleteSponsor(Token.jwt, id);
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShowSponsors()));
                  });
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

  Widget oneSponsor(Sponsor sponsor) {
    return Container(
      height: MediaQuery.of(context).size.height - 300,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[200],
      ),
      child: Column(
        children: <Widget>[
          Expanded(
              flex: 4,
              child: Stack(
                alignment: Alignment.topRight,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20)),
                        image: DecorationImage(
                            image: NetworkImage(wwwrootURL + sponsor.imagePath),
                            fit: BoxFit.fill)),
                    //child: Text(''),
                  ),
                  Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20)),
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Colors.transparent,
                                Colors.white,
                              ])),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20)),
                        ),
                        onPressed: () {
                          createAlertDialog(context, sponsor.id);
                        },
                        child: Icon(Icons.delete),
                      ))
                ],
              )),
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        sponsor.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        sponsor.description,
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      if (sponsor.websiteLink != null)
                        GestureDetector(
                                onTap: () {
                                  html.window.open(sponsor.websiteLink,
                                      sponsor.name + 'website');
                                },
                                child: Icon(Icons.web))
                            .showPointerOnHover,
                      if (sponsor.facebookLink != null)
                        GestureDetector(
                            onTap: () {
                              html.window.open(sponsor.facebookLink,
                                  sponsor.name + 'facebook');
                            },
                            child: FaIcon(
                              FontAwesomeIcons
                                  .facebook, /* color: Colors.blue[900],*/
                            )).showPointerOnHover,
                      if (sponsor.instagramLink !=
                          null) //pitam da li postoji url, za slucaj da sponzor nema nalog na nekoj drustvnoj mrezi
                        GestureDetector(
                            onTap: () {
                              html.window.open(sponsor.instagramLink,
                                  sponsor.name + 'instagram');
                            },
                            child: FaIcon(
                              FontAwesomeIcons
                                  .instagram, /* color: Colors.pink[800],*/
                            )).showPointerOnHover,
                      if (sponsor.youTubeLink != null)
                        GestureDetector(
                            onTap: () {
                              html.window.open(sponsor.youTubeLink,
                                  sponsor.name + 'youtube');
                            },
                            child: FaIcon(
                              FontAwesomeIcons
                                  .youtube, /*color: Colors.red[700],*/
                            )).showPointerOnHover,
                      if (sponsor.twitterLink != null)
                        GestureDetector(
                            onTap: () {
                              html.window.open(sponsor.twitterLink,
                                  sponsor.name + 'twitter');
                            },
                            child: FaIcon(
                              FontAwesomeIcons
                                  .twitter, /*color: Colors.blue[400],*/
                            )).showPointerOnHover,
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
