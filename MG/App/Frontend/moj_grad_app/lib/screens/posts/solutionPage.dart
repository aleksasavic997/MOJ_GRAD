import 'package:flutter/material.dart';
import 'package:mojgradapp/services/APIChallengeAndSolution.dart';
import '../../config/config.dart';
import '../../main.dart';
import '../../models/modelsViews/postInfo.dart';
import '../../services/token.dart';
import 'viewPostPage.dart';

class SolutionPage extends StatefulWidget {
  static PostInfo post;
  @override
  _SolutionPageState createState() => _SolutionPageState();
}

class _SolutionPageState extends State<SolutionPage> {
  int isApproved = 1;
  String name;
  bool isPressed1 = true;
  bool isPressed2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resenja'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            _buildButtonsForChoise(),
            SizedBox(
              height: 10.0,
            ),
            isPressed1 == true ? _buildListSolution(2) : _buildListSolution(1),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonsForChoise() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FlatButton(
          child: Text(
            "Rešenja",
            style: TextStyle(color: Colors.white),
          ),
          color: isPressed1 ? Colors.teal[800] : Colors.blueGrey[300],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          onPressed: () {
            setState(() {
              isPressed1 = true;
              isPressed2 = false;
              isApproved = 1;
              _buildListSolution(1);
            });
          },
        ),
        SizedBox(
          width: 20.0,
        ),
        FlatButton(
          child: Text(
            "Neprihvaćena rešenja",
            style: TextStyle(color: Colors.white),
          ),
          color: isPressed2 ? Colors.teal[800] : Colors.blueGrey[300],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          onPressed: () {
            setState(() {
              isPressed1 = false;
              isPressed2 = true;
              isApproved = 0;
              _buildListSolution(2);
            });
          },
        ),
      ],
    );
  }

  Widget _buildListSolution(int ind) {
    return FutureBuilder(
      future: APIChallengeOrSolution.getChallengeOrSolution(
          Token.jwt, SolutionPage.post.id, isApproved),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Container(
            child: Center(child: Text('Ucitavanje...')),
          );
        } else {
          return snapshot.data.length == 0
              ? Center(
                  child: Container(
                      padding: EdgeInsets.only(top: 200),
                      height: 500,
                      child: Text(ind == 1
                          ? "Nema neprihvaćenih rešenja"
                          : "Nema rešenja izazova ")))
              : Container(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Image.network(
                              wwwrootURL + snapshot.data[index].imagePath,
                              fit: BoxFit.fill),
                          title: Text(snapshot.data[index].title),
                          subtitle: Text(snapshot.data[index].description),
                          trailing: SolutionPage.post.userId == loginUserID &&
                                  isApproved == 1
                              ? _buildReject(snapshot.data[index].id)
                              : null, //buildRaisedButton(snapshot, index),
                          onTap: () async {
                            ViewPost.postId = snapshot.data[index].id;
                            ViewPost.ind = 3;
                            Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                    builder: (context) => ViewPost()));
                          },
                        );
                      }),
                );
        }
      },
    );
  }

  Widget _buildReject(int id) {
    return FloatingActionButton(
      heroTag: id,
      child: Icon(Icons.close),
      backgroundColor: Colors.grey[400],
      mini: true,
      onPressed: () {
        _showAlertDialog(id);
      },
    );
  }

  _showAlertDialog(int id) {
    Widget yes = FlatButton(
      child: Text("Da",style: TextStyle(color: Colors.black),),
      onPressed: () async {
        setState(() {
          APIChallengeOrSolution.solutionRejected(
              Token.jwt, SolutionPage.post.id, id);
          Navigator.of(context).pop();
        });
      },
    );

    Widget no = FlatButton(
      child: Text("Ne",style: TextStyle(color: Colors.black),),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      content: Text("Da li ste sigurni da zelite da uklonite resenje?"),
      actions: [
        yes,
        no,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
