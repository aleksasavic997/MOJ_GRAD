import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:mojgradapp/config/config.dart';
import 'package:mojgradapp/models/sponsor.dart';
import 'package:mojgradapp/services/APIServices.dart';
import 'package:mojgradapp/services/token.dart';

class AllSponsorsPage extends StatefulWidget {
  _SponsorPageState createState() => _SponsorPageState();
}

class _SponsorPageState extends State<AllSponsorsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.red,
        appBar: AppBar(
          title: Text("Sponzori"),
          centerTitle: true,
        ),
        body: Container(
          child: allSponsors(context),
        ) //Sponsors(),
        );
  }

  allSponsors(BuildContext context) {
    return FutureBuilder(
      future: APIServices.getAllSponsors(Token.jwt),
      builder: (BuildContext context, AsyncSnapshot<List<Sponsor>> snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        } else if (snapshot.data.length == 0)
          return Center(
            child: Text('Trenutno nema sponzora za prikaz'),
          );
        else {
          return Container(
            color: Theme.of(context).backgroundColor,
            // backgroundColor: Theme.of(context).backgroundColor,
            child: GridView.builder(
              itemCount: snapshot.data.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                // if (index < snapshot.data.length) {
                return Sponsor2(
                  sponsor: snapshot.data[index],
                );
                //} else
                //return null;
              },
            ),
          );
        }
      },
    );
  }
}

class Sponsor2 extends StatelessWidget {
  final sponsor;

  Sponsor2({this.sponsor});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
          color: Colors.white,
          //color: Theme.of(context).primaryColor,
          margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Column(
              children: <Widget>[
                new Text(
                  sponsor.name,
                  style: TextStyle(
                      fontSize: 20.0, color: Theme.of(context).primaryColor),
                ),
                new Padding(padding: new EdgeInsets.all(2.0)),
                Expanded(
                  child: Hero(
                      tag: sponsor.id,
                      child: new Material(
                        child: InkWell(
                          onTap: () {},
                          child: GridTile(
                            child: Image.network(
                              wwwrootURL + sponsor.imagePath,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      )),
                ),
                new Padding(
                  padding: EdgeInsets.only(top: 2.0, left: 10.0),
                  child: Text(sponsor.description,
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Theme.of(context).primaryColor)),
                ),
              ],
            ),
          )),

      //  )
    );
  }
}
