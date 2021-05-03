import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mojgradapp/config/config.dart';
import 'package:mojgradapp/functions/bottomNavigationBar.dart';
import 'package:mojgradapp/functions/drawer.dart';
import 'package:mojgradapp/functions/loading.dart';
import 'package:mojgradapp/models/modelsViews/postInfo.dart';
import 'package:mojgradapp/models/modelsViews/userInfo.dart';
import 'package:mojgradapp/models/userReport.dart';
import 'package:mojgradapp/screens/posts/viewPostPage.dart';
import 'package:mojgradapp/services/APIFollow.dart';
import 'package:mojgradapp/services/APIPosts.dart';
import 'package:mojgradapp/services/APIUsers.dart';
import 'package:mojgradapp/services/token.dart';
import '../main.dart';
import '../services/token.dart';
import 'loginPage.dart';

int index = 1;

class ProfilePage extends StatefulWidget {
  static UserInfo user;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isPressed1 = true;
  bool isPressed2 = false;
  bool isPressed3 = false;
  int index = 1;

  Container myArticles(
      String imageVal, String heading, String subHeading, int index) {
    return Container(
      color: Theme.of(context).backgroundColor,
      width: 200.0,
      child: InkWell(
        onTap: () {
          ViewPost.ind = 2;
          ViewPost.postId = index;
          Navigator.push(context,
              MaterialPageRoute<void>(builder: (context) => ViewPost()));
        },
        child: Card(
          child: Wrap(
            children: <Widget>[
              Image.network(
                imageVal,
                height: 200.0,
                width: 195.0,
                fit: BoxFit.cover,
              ),
              ListTile(
                title: Text(heading),
                subtitle: Text(subHeading),
              )
            ],
          ),
        ),
      ),
    );
  }

  final List<String> lista = ['1', '2', '3', '4'];
  //glavna fja
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
          //title
          automaticallyImplyLeading:
              ProfilePage.user.id == loginUserID ? false : true,
          title: Text(
            'Profilna strana',
            style: Theme.of(context).textTheme.title,
          ),
          centerTitle: true,
          actions: ProfilePage.user.id != loginUserID
              ? <Widget>[
                  _reportPopUp(),
                ]
              : null),
      endDrawer: ProfilePage.user.id == loginUserID ? DrawerProfile() : null,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
                child: Column(
              children: <Widget>[
                Container(
                  child: ClipPath(
                    clipper: GetClipper(),
                    child: Container(
                      height: 220,
                      decoration: BoxDecoration(
                        color: Theme.of(context).unselectedWidgetColor,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(left: 15),
                              height: 120,
                              width: 120,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  wwwrootURL + ProfilePage.user.profilePhoto,
                                ),
                                radius: 60,
                              )),
                          SizedBox(
                            width: 30,
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 40.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 195,
                                  //color: Colors.white,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Flexible(
                                        //flex: 3,
                                        child: Container(
                                          child: Text(
                                            ProfilePage.user.username,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25.0,
                                            ),
                                            softWrap: true,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      _setRank(),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  //flex: 1,
                                  child: Container(
                                    width: 195,
                                    child: Text(
                                      //loginUser.name != null ? loginUser.name : "",
                                      ProfilePage.user.name +
                                          " " +
                                          ProfilePage.user.lastname,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Flexible(
                                  //flex: 1,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            ProfilePage.user.postCount
                                                .toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 3.0,
                                          ),
                                          Text(
                                            'Broj objava',
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            ProfilePage.user.points.toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 3.0,
                                          ),
                                          Text(
                                            'Broj poena',
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                      // SizedBox(
                                      //   width: 20,
                                      // ),
                                      // Column(
                                      //   children: <Widget>[
                                      //     SizedBox(
                                      //       height: 1.9,
                                      //     ),
                                      //     _setRank(),
                                      //     SizedBox(
                                      //       height: 3.0,
                                      //     ),
                                      //     Text('Rang'),
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                LoginPage().getUsername() != ProfilePage.user.username
                    ? Container(
                        width: 160,
                        margin: EdgeInsets.only(top: 10, left: 230),
                        child: _buildFollow(),
                      )
                    : SizedBox(),
                Container(
                  margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //SizedBox(height: 10.0),
                      Row(
                        children: <Widget>[
                          Icon(Icons.location_city),
                          SizedBox(width: 10.0),
                          Text(
                            ProfilePage.user.cityName,
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 17.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        children: <Widget>[
                          Icon(Icons.email),
                          SizedBox(width: 10.0),
                          Text(
                            ProfilePage.user.email,
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 17.0,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 5.0),
                      ProfilePage.user.phone != ""
                          ? Row(
                              children: <Widget>[
                                Icon(Icons.phone),
                                SizedBox(width: 10.0),
                                Text(
                                  ProfilePage.user.phone,
                                  style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 17.0,
                                  ),
                                )
                              ],
                            )
                          : SizedBox(height: 10.0),
                    ],
                  ),
                ),
                SizedBox(height: 15.0),
                Container(),
                SizedBox(height: 15.0),
                Text(
                  'Izazovi',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                _buildPosts(1),
                SizedBox(
                  height: 10,
                ),
                loginUserID == ProfilePage.user.id
                    ? Text(
                        "Sačuvane objave",
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Container(),
                loginUserID == ProfilePage.user.id
                    ? _buildPosts(2)
                    : Container(),
              ],
            )),
          )
        ],
      ),
      bottomNavigationBar: ProfilePage.user.id == loginUserID
          ? MyBottomNavigationBar(
              value: 4,
            )
          : null,
    );
  }

  Widget _setRank() {
    Color color;
    switch (ProfilePage.user.rankName) {
      case 'Zlato':
        color = Colors.yellowAccent[700];
        break;
      case 'Srebro':
        color = Colors.blueGrey[200];
        break;
      case 'Bronza':
        color = Colors.brown[600];
        break;
      case 'Nema ranga':
        color = Colors.black;
        break;
      default:
    }
    return FaIcon(
      FontAwesomeIcons.solidGem,
      color: color,
      size: 25.0,
    );
  }

  showAlertDialogNeca(BuildContext context, int id) {
    // set up the button
    Widget yesButton = FlatButton(
      child: Text(
        "DA",
        style: TextStyle(
          color: Colors.teal[800],
          fontSize: 20.0,
          //fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        Loading();
        setState(() {
          APIFollow.addFollow(Token.jwt, id)
              .then((value) => sendNotification(id));
        });
        Navigator.of(context).pop();
      },
    );
    Widget noButton = FlatButton(
      child: Text(
        "NE",
        style: TextStyle(
          color: Colors.teal[800],
          fontSize: 20.0,
          //fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      //title: Text("My title"),
      content: Text(
        "Da li želiš da prekineš praćenje?",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          //fontWeight: FontWeight.bold,
          //fontStyle: FontStyle.italic,
        ),
      ),
      backgroundColor: Colors.white, //Theme.of(context).primaryColor,
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25)),
      actions: [
        yesButton,
        noButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget _buildFollow() {
    if (loginUserID != ProfilePage.user.id)
      return FutureBuilder(
        future: APIFollow.checkIfFollow(Token.jwt, ProfilePage.user.id),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData)
            return CircularProgressIndicator();
          else {
            String text;
            Icon icon;
            if (snapshot.data == true) {
              //showAlertDialog(context);
              text = 'Praćenje';
              icon = Icon(
                Icons.group,
                color: Colors.white,
              );
            } else {
              text = 'Zaprati';
              icon = Icon(
                Icons.person_add,
                color: Colors.white,
              );
            }
            return FloatingActionButton.extended(
                icon: icon,
                label: Text(
                  text,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                onPressed: () {
                  if (text == 'Praćenje') {
                    showAlertDialogNeca(context, ProfilePage.user.id);
                  } else {
                    Loading();
                    setState(() {
                      APIFollow.addFollow(Token.jwt, ProfilePage.user.id).then(
                          (value) => sendNotification(ProfilePage.user.id));
                    });
                  }
                });
          }
        },
      );
    else
      return Container();
  }

  Widget _buildPosts(int ind) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          //color: Color.fromRGBO(24, 74, 69, 1),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: <Widget>[
          ind == 1 ? _buildPostsBar() : Container(),
          Container(
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.symmetric(vertical: 10.0),
            //height: 300,
            child: FutureBuilder(
                future: ind == 1
                    ? APIPosts.getPostsFilteredByType(
                        ProfilePage.user.id, index, Token.jwt)
                    : APIPosts.fetchSavedPosts(ProfilePage.user.id, Token.jwt),
                builder: (BuildContext context,
                    AsyncSnapshot<List<PostInfo>> snapshot) {
                  if (!snapshot.hasData)
                    return CircularProgressIndicator();
                  else {
                    return snapshot.data.length == 0
                        ? Center(
                            child: Container(
                                padding: EdgeInsets.only(top: 20),
                                height: 50,
                                child: Text(ind == 1
                                    ? "Nema izazova za prikaz"
                                    : "Nemate sačuvanih objava")))
                        : Container(
                            height: 300,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return myArticles(
                                      wwwrootURL +
                                          snapshot.data[index].imagePath,
                                      snapshot.data[index].title,
                                      snapshot.data[index].description,
                                      snapshot.data[index].id);
                                }),
                          );
                  }
                }),
          ),
        ],
      ),
    );
  }

  Widget _buildPostsBar() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FlatButton(
            color: isPressed1 ? Colors.teal[800] : Colors.blueGrey[300],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            onPressed: () {
              setState(() {
                isPressed1 = true;
                isPressed2 = false;
                isPressed3 = false;
                index = 1;
              });
            },
            child: Text(
              'Aktivni',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isPressed1 ? Colors.white : Colors.blueGrey[800]),
            ),
          ),
          FlatButton(
            color: isPressed2 ? Colors.teal[800] : Colors.blueGrey[300],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            onPressed: () {
              setState(() {
                isPressed1 = false;
                isPressed2 = true;
                isPressed3 = false;
                index = 2;
              });
            },
            child: Text(
              'Rešeni',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isPressed2 ? Colors.white : Colors.blueGrey[800]),
            ),
          ),
          FlatButton(
            color: isPressed3 ? Colors.teal[800] : Colors.blueGrey[300],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            onPressed: () {
              setState(() {
                isPressed1 = false;
                isPressed2 = false;
                isPressed3 = true;
                index = 3;
              });
            },
            child: Text(
              'Završeni',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isPressed3 ? Colors.white : Colors.blueGrey[800]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _reportPopUp() {
    bool report = ProfilePage.user.getIsReported;
    return PopupMenuButton<String>(
      icon: Icon(Icons.report),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'val_one',
          child: report == true ? Text('Povucite prijavu') : Text('Prijavi'),
        ),
      ],
      onSelected: (value) async {
        if (value == "val_one") {
          UserReport userReport =
              new UserReport(ProfilePage.user.id, loginUserID);
          report = await APIUsers.addUserReport(Token.jwt, userReport);
        }
      },
    );
  }
}

//klasa za zakrivljenje container-a na profilnoj strani
class GetClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, size.height - 50);
    var controllPoint = Offset(50, size.height);
    var endPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(
        controllPoint.dx, controllPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

//klasa za elemente sideBar-a
class CustomizeListTile extends StatelessWidget {
  IconData icon;
  String text;
  Function onTap;

  CustomizeListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(color: Colors.grey.shade400),
        )),
        child: InkWell(
          onTap: onTap,
          splashColor: Colors.green[800],
          child: Container(
            height: 50.0,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(icon),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          text,
                          style: TextStyle(fontSize: 17.0),
                        ),
                      ),
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
