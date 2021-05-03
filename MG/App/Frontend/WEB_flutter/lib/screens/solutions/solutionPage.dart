import 'package:WEB_flutter/config/config.dart';
import 'package:WEB_flutter/main.dart';
import 'package:WEB_flutter/models/modelsViews/postInfo.dart';
import 'package:WEB_flutter/screens/homePage/centeredView.dart';
import 'package:WEB_flutter/screens/homePage/home.dart';
import 'package:WEB_flutter/screens/institutions/homePageInstitutions.dart';
import 'package:WEB_flutter/screens/institutions/profilePage/instProfile.dart';
import 'package:WEB_flutter/screens/showPost/showPost.dart';
import 'package:WEB_flutter/services/APIChallengdeAndSolution.dart';
import 'package:WEB_flutter/services/token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:WEB_flutter/hover_extensions.dart';

class SolutionPage extends StatefulWidget {
  static PostInfo post;
  @override
  _SolutionPageState createState() => _SolutionPageState();
}

class _SolutionPageState extends State<SolutionPage> {
  final ScrollController controller = ScrollController();
  int crossAxisCount = 4;
  int idInst = 10;
  int isApproved = 1;
  bool isPressed = true;
  bool isPressed1 = false;
  int ind = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: CenteredView(
          child: Column(
            children: <Widget>[_navBar(), _buildBody()],
          ),
        ),
      ),
    );
  }

  Widget _navBar() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            children: [
              Image.asset(
                'assets/webLogo.png',
                width: MediaQuery.of(context).size.width > 600 ? 150 : 100,
                height: 80,
              ),
              Text(
                'Moj Grad ', //ostavi razmak posle d
                style: TextStyle(fontSize: 30.0, fontFamily: 'Pacifico'),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: FloatingActionButton(
                  tooltip: 'Korak nazad',
                  heroTag: 'backTag1',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Color.fromRGBO(24, 74, 69, 1),
                  ),
                ),
              ).showPointerOnHover,
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: FloatingActionButton(
                  onPressed: () {
                    InstitutionProfile.showNotifications = false;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => loginAdmin.isEmpty == true
                              ? HomePageInstitutions()
                              : HomePage.fromBase64(Token.jwt),
                        ));
                  },
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.home,
                    size: 30,
                    //size: MediaQuery.of(context).size.width > 600 ? 30 : 20,
                    color: Color.fromRGBO(24, 74, 69, 1),
                  ),
                  //mini: MediaQuery.of(context).size.width > 600 ? false : true,
                ),
              ).showPointerOnHover,
            ],
          )
        ]);
  }

  Widget _buildBody() {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(24, 74, 69, 1),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 15),
            child: loginAdmin.isEmpty == true
                ? //ako je prijavljena institucija, ona vidi samo resenja
                Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: Text("Resenja",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  )
                : //admin, on vidi i resenja i neprihvacena resenja
                Row(
                    children: <Widget>[
                      FlatButton(
                        color:
                            isPressed ? Colors.grey[200] : Colors.blueGrey[300],
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        onPressed: () {
                          setState(() {
                            isPressed = true;
                            isPressed1 = false;
                            isApproved = 1;
                            ind = 2;
                            _showPosts(2);
                          });
                        },
                        child: Text(
                          'Resenja',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: isPressed1
                                  ? Colors.black
                                  : Colors.blueGrey[800]),
                        ),
                      ).showPointerOnHover,
                      SizedBox(
                        width: 20,
                      ),
                      FlatButton(
                        color: isPressed1
                            ? Colors.grey[200]
                            : Colors.blueGrey[300],
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        onPressed: () {
                          setState(() {
                            isPressed = false;
                            isPressed1 = true;
                            isApproved = 0;
                            ind = 1;
                            _showPosts(1);
                          });
                        },
                        child: Text(
                          'Neprihvaćena rešenja',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: isPressed1
                                  ? Colors.black
                                  : Colors.blueGrey[800]),
                        ),
                      ).showPointerOnHover,
                    ],
                  ),
          ),
          _showPosts(ind)
        ],
      ),
    );
  }

  Widget _showPosts(int ind) {
    return FutureBuilder(
      future: APIChallengeAndSolution.getChallengeOrSolution(
          Token.jwt, SolutionPage.post.id, isApproved),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Center(
            child: Container(
              child: SpinKitFadingCircle(
                color: Colors.white,
                size: 50,
              ),
            ),
          );
        } else {
          return snapshot.data.length == 0
              ? Center(
                  child: Container(
                      padding: EdgeInsets.only(top: 200),
                      height: 500,
                      child: Text(
                        ind == 1
                            ? "Nema neprihvaćenih rešenja"
                            : "Nema rešenja izazova ",
                        style: TextStyle(color: Colors.white),
                      )))
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: MediaQuery.of(context).size.height,
                  child: LayoutBuilder(builder: (context, constraints) {
                    return StaggeredGridView.count(
                      crossAxisCount: constraints.maxWidth < 900
                          ? (constraints.maxWidth < 700
                              ? (constraints.maxWidth < 400 ? 1 : 2)
                              : 3)
                          : 4,
                      children:
                          List.generate(snapshot.data.length, (int index) {
                        return _Tile(
                          post: snapshot.data[index],
                        );
                      }),
                      staggeredTiles:
                          List.generate(snapshot.data.length, (int index) {
                        return StaggeredTile.fit(1);
                      }),
                    );
                  }),
                );
        }
      },
    );
  }
}

class _Tile extends StatelessWidget {
  final PostInfo post;

  const _Tile({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: RaisedButton(
        onPressed: () {
          ShowPost.post = post;
          Navigator.push(context,
              MaterialPageRoute<void>(builder: (context) => ShowPost()));
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Container(
                      height: 300,
                      padding: EdgeInsets.only(top: 15),
                      child: ClipRect(
                        child: Image.network(
                          wwwrootURL + post.imagePath,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(post.title),
                    subtitle: Text(post.description.length > 30
                        ? post.description.substring(0, 30) + '...'
                        : post.description),
                  )
                ],
              ),
            ),
          ],
        ),
      ).showPointerOnHover,
    );
  }
}
