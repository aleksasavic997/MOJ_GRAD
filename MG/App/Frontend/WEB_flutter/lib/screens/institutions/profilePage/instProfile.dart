import 'package:WEB_flutter/config/config.dart';
import 'package:WEB_flutter/main.dart';
import 'package:WEB_flutter/models/institution.dart';
import 'package:WEB_flutter/models/modelsViews/institutionInfo.dart';
import 'package:WEB_flutter/models/modelsViews/notificationInfo.dart';
import 'package:WEB_flutter/models/modelsViews/postInfo.dart';
import 'package:WEB_flutter/screens/homePage/home.dart';
import 'package:WEB_flutter/screens/homePage/showInstitutions.dart';
import 'package:WEB_flutter/screens/institutions/changeData.dart';
import 'package:WEB_flutter/screens/institutions/homePageInstitutions.dart';
import 'package:WEB_flutter/screens/login/loginPage.dart';
import 'package:WEB_flutter/screens/showPost/showPost.dart';
import 'package:WEB_flutter/services/APIInstitutions.dart';
import 'package:WEB_flutter/services/APINotification.dart';
import 'package:WEB_flutter/services/APIPosts.dart';
import 'package:WEB_flutter/services/APIUsers.dart';
import 'package:WEB_flutter/services/token.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:WEB_flutter/hover_extensions.dart';

import '../../../main.dart';

class InstitutionProfile extends StatefulWidget {
  //static int ind; //ako je jedan desktop, dva tablet

  static bool showNotifications = false;
  final Institution institution;
  const InstitutionProfile({this.institution});
  @override
  _InstitutionProfileState createState() =>
      _InstitutionProfileState(institution);
}

class _InstitutionProfileState extends State<InstitutionProfile>
    with TickerProviderStateMixin {
  Institution institution;
  _InstitutionProfileState(Institution institution) {
    this.institution = institution;
  }

  final ScrollController controller = ScrollController();

  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  bool isPressed1 = true;
  bool isPressed2 = false;

  final GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();

  void _showSnakBarMsg(String msg) {
    _scaffoldstate.currentState
        .showSnackBar(new SnackBar(content: new Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldstate,
      body: GestureDetector(
        onTap: () {
          setState(() {
            InstitutionProfile.showNotifications = false;
          });
        },
        child: SingleChildScrollView(
          controller: controller,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Column(
              children: <Widget>[
                _navBar(),
                //buildBody()
                Stack(
                  children: <Widget>[
                    buildBody(),
                    InstitutionProfile.showNotifications && loginAdmin.isEmpty
                        ? showNotifications()
                        : Text('')
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navBar() {
    return Container(
        child: loginAdmin.isEmpty
            ? LayoutBuilder(builder: (context, constraints) {
                if (constraints.maxWidth > 580) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: [
                          Image.asset(
                            'assets/webLogo.png',
                            width: MediaQuery.of(context).size.width > 600
                                ? 150
                                : 100,
                            height: 80,
                          ),
                          Text(
                            'Moj Grad ', //ostavi razmak posle d
                            style: TextStyle(
                                fontSize: 30.0, fontFamily: 'Pacifico'),
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
                              onPressed: (){
                                setState(() {
                                  InstitutionProfile.showNotifications = false;
                                });
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
                                      builder: (context) =>
                                          loginAdmin.isEmpty == true
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
                          loginAdmin.isEmpty == true
                              ? notificationButton()
                              : Container(),
                          loginAdmin.isEmpty == true
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  //child: _profileMenu(),
                                ).showPointerOnHover
                              : Container()
                        ],
                      )
                    ],
                  );
                } else {
                  return Column(
                    children: <Widget>[
                      Row(
                        children: [
                          Image.asset(
                            'assets/webLogo.png',
                            width:
                                150, //MediaQuery.of(context).size.width > 600 ? 150 : 100,
                            height: 80,
                          ),
                          Text(
                            'Moj Grad ', //ostavi razmak posle d
                            style: TextStyle(
                                fontSize: 30.0, fontFamily: 'Pacifico'),
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
                              onPressed: (){
                                setState(() {
                                  InstitutionProfile.showNotifications = false;
                                });
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
                                      builder: (context) =>
                                          loginAdmin.isEmpty == true
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
                          loginAdmin.isEmpty == true
                              ? notificationButton()
                              : Container(),
                          loginAdmin.isEmpty == true
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  //child: _profileMenu(),
                                ).showPointerOnHover
                              : Container()
                        ],
                      )
                    ],
                  );
                }
              })
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: [
                      Image.asset(
                        'assets/webLogo.png',
                        width:
                            MediaQuery.of(context).size.width > 600 ? 150 : 100,
                        height: 80,
                      ),
                      Text(
                        'Moj Grad ', //ostavi razmak posle d
                        style:
                            TextStyle(fontSize: 30.0, fontFamily: 'Pacifico'),
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
                          onPressed: (){
                            setState(() {
                              InstitutionProfile.showNotifications = false;
                            });
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
                                  builder: (context) =>
                                      loginAdmin.isEmpty == true
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
                      loginAdmin.isEmpty == true
                          ? notificationButton()
                          : Container(),
                      loginAdmin.isEmpty == true
                          ? Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              //child: _profileMenu(),
                            ).showPointerOnHover
                          : Container()
                    ],
                  )
                ],
              ));
  }

  Widget notificationButton() {
    return FloatingActionButton(
        heroTag: 'in', // institution notifications
        backgroundColor: Colors.white,
        onPressed: () {
          setState(() {
            InstitutionProfile.showNotifications =
                !InstitutionProfile.showNotifications;
          });
        },
        child: FutureBuilder(
          future: APINotification.getAllNotReadNotifications(Token.jwt),
          builder: (BuildContext context,
              AsyncSnapshot<List<NotificationInfo>> snapshot) {
            if (!snapshot.hasData) {
              return Icon(
                Icons.notifications,
                color: Color.fromRGBO(24, 74, 69, 1),
              );
            } else {
              return Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Icon(
                      Icons.notifications,
                      color: Color.fromRGBO(24, 74, 69, 1),
                    ),
                  ),
                  snapshot.data.length != 0
                      ? Positioned(
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 14,
                              minHeight: 14,
                            ),
                            child: Text(
                              snapshot.data.length.toString(),
                              style: new TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : Text('')
                ],
              );
            }
          },
        )).showPointerOnHover;
  }

  Widget showNotifications() {
    return Positioned(
      right: 90,
      child: Container(
        width: 400,
        margin: EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Color.fromRGBO(24, 74, 69, 1)),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(children: <Widget>[
                      Container(
                        height: 60,
                        child: Center(
                          child: Text(
                            'Obaveštenja',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontFamily: 'Pacifico'),
                          ),
                        ),
                      ),
                      TabBar(
                          controller: _tabController,
                          labelColor: Colors.black,
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              color: Colors.grey[400]),
                          unselectedLabelColor: Colors.grey[200],
                          tabs: <Widget>[
                            Tab(
                              text: 'Novo',
                            ),
                            Tab(
                              text: 'Pročitano',
                            )
                          ]),
                      Container(
                        height: 300,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        child: TabBarView(
                          controller: _tabController,
                          children: <Widget>[
                            newNotifications(),
                            readNotifications(),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget newNotifications() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                height: 30,
                alignment: Alignment.centerRight,
                child: IconButton(
                    padding: EdgeInsets.zero,
                    tooltip: 'Prebaci sve u pročitano',
                    onPressed: () {
                      setState(() {
                        APINotification.readAllNotifications(Token.jwt)
                            .then((value) {
                          print('Klik na prebaci u procitano');
                        });
                      });
                    },
                    icon: Icon(
                      Icons.drafts,
                      color: Color.fromRGBO(24, 74, 69, 1),
                    )),
              ),
            ),
          ],
        ),
        Container(
          height: 260,
          child: FutureBuilder(
            future: APINotification.getAllNotReadNotifications(Token.jwt),
            builder: (BuildContext context,
                AsyncSnapshot<List<NotificationInfo>> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Container(
                      child: SpinKitFadingCircle(
                    color: Colors.white,
                    size: 50.0,
                  )),
                );
              } else if (snapshot.data.length == 0) {
                return Center(
                  child: Text('Nemate novih obaveštenja.'),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return oneNotification(snapshot.data[index], false);
                    });
              }
            },
          ),
        ),
      ],
    );
  }

  Widget readNotifications() {
    return FutureBuilder(
      future: APINotification.getAllReadNotifications(Token.jwt),
      builder: (BuildContext context,
          AsyncSnapshot<List<NotificationInfo>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Container(
                child: SpinKitFadingCircle(
              color: Colors.white,
              size: 50.0,
            )),
          );
        } else if (snapshot.data.length == 0) {
          return Center(
            child: Text('Nemate obaveštenja.'),
          );
        } else {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return oneNotification(snapshot.data[index], true);
              });
        }
      },
    );
  }

  Widget oneNotification(NotificationInfo notification, bool isRead) {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
          color: isRead ? Colors.grey[200] : Colors.white,
          borderRadius: BorderRadius.circular(10)),
      child: FlatButton(
        onPressed: () {
          if (!isRead) {
            setState(() {
              APINotification.changeNotificationToRead(Token.jwt, notification);
            });
          }

          if (notification.type != 7 && notification.type != 8) {
            PostInfo post;
            APIPosts.getPostByID(notification.postId, Token.jwt)
                .then((value) => post);
            print(' username ${post.username}');
            ShowPost.post = post;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShowPost(),
              ),
            );
          }
        },
        child: Row(
          children: <Widget>[
            Expanded(
                child: Text(
              notification.content,
              style: TextStyle(
                  fontWeight: isRead ? FontWeight.normal : FontWeight.bold),
            )),
          ],
        ),
      ).showPointerOnHover,
    );
  }

  // Widget _profileMenu() {
  //   return Container(
  //       width: 90, //MediaQuery.of(context).size.width > 600 ? 90.0 : 55.0,
  //       height: 100.0,
  //       //color: Color.fromRGBO(24, 74, 69, 1),
  //       child: PopupMenuButton(
  //           tooltip: "Opcije",
  //           icon: Stack(
  //             children: <Widget>[
  //               Align(
  //                 alignment: Alignment.center,
  //                 child: CircleAvatar(
  //                   backgroundImage: NetworkImage(
  //                       wwwrootURL + loginInstitution.profilePhoto),
  //                   radius:
  //                       27, //MediaQuery.of(context).size.width > 600 ? 27 : 20,
  //                 ),
  //               ),
  //               //SizedBox(width: 10,),
  //               // Align(
  //               //     alignment: Alignment.centerRight,
  //               //     child: Icon(Icons.arrow_drop_down))
  //             ],
  //           ),
  //           //icon: Icon(Icons.arrow_drop_down),
  //           itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
  //                 loginInstitutionID == institution.id
  //                     ? PopupMenuItem<String>(
  //                         value: 'val_one',
  //                         child: Text('Izmenite svoje informacije')
  //                             .showPointerOnHover,
  //                       )
  //                     : null,
  //                 PopupMenuItem<String>(
  //                   value: 'val_two',
  //                   child: Text('Odjava').showPointerOnHover,
  //                 ),
  //               ],
  //           onSelected: (value) async {
  //             setState(() {
  //               InstitutionProfile.showNotifications = false;
  //             });
  //             //print(value);
  //             switch (value) {
  //               case 'val_one':
  //                 //ChangeData.institution = institution;
  //                 InstitutionInfo pomInst =
  //                     await APIInstitutions.getInstitutionInfoByID(
  //                         loginInstitutionID, Token.jwt);
  //                 showDialog(
  //                     context: context,
  //                     builder: (context) => ChangeData(
  //                           institution: pomInst,
  //                         ));
  //                 break;
  //               case 'val_two':
  //                 loginInstitution = null;
  //                 loginInstitutionID = null;
  //                 //Navigator.pushNamedAndRemoveUntil(context, "/login", (r) => false);
  //                 Navigator.push(
  //                     context,
  //                     MaterialPageRoute<void>(
  //                         builder: (context) => LoginPage()));
  //                 break;
  //             }
  //           }));
  // }

  Widget buildBody() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.black12,
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _institutionSection(),
            loginAdmin.isNotEmpty && MediaQuery.of(context).size.width < 750
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      institution.isVerified == false
                          ? _buildVerifyButton('tag12').showPointerOnHover
                          : Container(),
                      SizedBox(
                        width: 10,
                      ),
                      _buildDeleteButton('tag11').showPointerOnHover,
                    ],
                  )
                : Text(''),
            MediaQuery.of(context).size.width > 800
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(flex: 1, child: _informationSection()),
                      //VerticalDivider(width: 5.0,color: Colors.black,),
                      //SizedBox(height: MediaQuery.of(context).size.height,width: 2.0,),
                      Container(
                          height: MediaQuery.of(context).size.height,
                          width: 2.0,
                          color: Colors.grey[400]),
                      Expanded(
                          flex:
                              MediaQuery.of(context).size.width < 1000 ? 3 : 4,
                          child: _postsSection()),
                    ],
                  )
                : Column(children: <Widget>[
                    _informationSection(),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 2.0,
                        color: Colors.grey[400]),
                    _postsSection(),
                  ])
          ],
        ),
      ),
    );
  }

  Widget _informationSection() {
    return Container(
      margin: EdgeInsets.all(9.0),
      padding: EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[200]),
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      'INFORMACIJE',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width < 1090
                              ? 12
                              : 15,
                          color: Colors.white),
                    ),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(24, 74, 69, 1),
                        borderRadius: BorderRadius.circular(30.0)),
                    padding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  _infoField(Icon(Icons.email), institution.email),
                  _infoField(Icon(Icons.phone), institution.phone),
                  _infoField(Icon(Icons.location_city), institution.address)
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            // Container(
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(20),
            //       color: Colors.grey[200]),
            //   padding: EdgeInsets.all(15.0),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: <Widget>[
            //       Container(
            //         child: Text(
            //           "ZAŠTO MI?",
            //           style: TextStyle(
            //               fontSize: MediaQuery.of(context).size.width < 1000
            //                   ? 15
            //                   : 20.0,
            //               color: Colors.white),
            //         ),
            //         decoration: BoxDecoration(
            //             color: Color.fromRGBO(24, 74, 69, 1),
            //             borderRadius: BorderRadius.circular(30.0)),
            //         padding:
            //             EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
            //       ),
            //       SizedBox(
            //         height: 10.0,
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  _makeVarification() async {
    bool verification = institution.isVerified;
    if (verification == false) {
      var v =
          await APIInstitutions.verifyInstitution(Token.jwt, institution.id);
      setState(() {
        verification = v;
        institution.isVerified = true;
      });
      if (v == true)
        _showSnakBarMsg('Uspesno ste verifikovali instituciju.');
      else
        _showSnakBarMsg('Doslo je do greske.');
    }
  }

  Widget _buildVerifyButton(String tag) {
    return FloatingActionButton.extended(
      heroTag: tag,
      onPressed: () {
        _makeVarification();
      },
      label: Text('Verifikuj'),
      icon: Icon(Icons.check),
      backgroundColor: Colors.teal[900],
    );
  }

  Widget _buildDeleteButton(String tag) {
    //if (loginAdmin.isNotEmpty)
    return FloatingActionButton.extended(
      heroTag: tag,
      onPressed: () {
        createAlertDialog(context);
      },
      label: Text('Obriši'),
      icon: Icon(Icons.delete),
      backgroundColor: Colors.teal[900],
    );
    // else
    //   return Text('');
  }

  createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Da li želite trajno da izbrišete ovu instituciju?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  setState(() {
                    APIUsers.deleteUserOrInstitution(Token.jwt, institution.id);
                    Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                            builder: (context) =>
                                HomePage.fromBase64(Token.jwt)));
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

  Widget _infoField(Icon icon, String text) {
    return Row(
      children: <Widget>[
        icon,
        SizedBox(
          width: 5,
        ),
        Flexible(child: Text(text))
      ],
    );
  }

  Widget _postsSection() {
    return Container(
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.grey[200]),
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(15.0),
      //color: Colors.orange,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Container(
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          isPressed1 = true;
                          isPressed2 = false;
                        });
                      },
                      child: Text(
                        'Rešenja izazova',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width < 1000
                                ? 15
                                : 20.0,
                            color: Colors.white),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: isPressed1 == true
                            ? Colors.teal[600]
                            : Color.fromRGBO(24, 74, 69, 1),
                        borderRadius: BorderRadius.circular(30.0)),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  loginInstitutionID == institution.id
                      ? Container(
                          child: FlatButton(
                            onPressed: () {
                              setState(() {
                                isPressed1 = false;
                                isPressed2 = true;
                              });
                            },
                            child: Text(
                              'Sačuvane objave',
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width < 1000
                                          ? 15
                                          : 20.0,
                                  color: Colors.white),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: isPressed2 == true
                                  ? Colors.teal[600]
                                  : Color.fromRGBO(24, 74, 69, 1),
                              borderRadius: BorderRadius.circular(30.0)),
                        )
                      : Container(),
                ],
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            _postGrid()
          ],
        ),
      ),
    );
  }

  Widget _postGrid() {
    return Container(
        child: FutureBuilder(
            future:
                _makeFuture(), //APIPosts.getInstitutionPosts(institution.id, Token.jwt),
            builder:
                (BuildContext context, AsyncSnapshot<List<PostInfo>> snapshot) {
              if (snapshot.data == null) {
                return Center(
                    child: Container(
                        child: SpinKitFadingCircle(
                  color: Colors.white,
                  size: 50.0,
                )));
              } else {
                return GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: MediaQuery.of(context).size.width > 1000
                        ? 4
                        : (MediaQuery.of(context).size.width < 700 ? 2 : 3),
                    scrollDirection: Axis.vertical,
                    children: List.generate(snapshot.data.length, (int index) {
                      return Container(
                        child: Card(
                          //child: Text(snapshot.data[index].imagePath),
                          color: Color.fromRGBO(24, 74, 69, 1),
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: InkWell(
                              onTap: () {
                                ShowPost.post = snapshot.data[index];
                                Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                        builder: (context) => ShowPost()));
                              },
                              child: Wrap(
                                children: <Widget>[
                                  Image.network(
                                    wwwrootURL + snapshot.data[index].imagePath,
                                    // height: 0.0,
                                    // width: 150.0,
                                    fit: BoxFit.cover,
                                  ),
                                  ListTile(
                                      title: Text(
                                        snapshot.data[index].title,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      subtitle: Text(
                                        snapshot.data[index].description
                                                    .length >
                                                30
                                            ? snapshot.data[index].description
                                                    .substring(0, 30) +
                                                '...'
                                            : snapshot.data[index].description,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ))
                                ],
                              ),
                            ).showPointerOnHover,
                          ),
                        ),
                      );
                    }));
              }
            }));
  }

  Widget _institutionSection() {
    print(MediaQuery.of(context).size.width);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.black,
                backgroundImage: NetworkImage(
                  wwwrootURL + institution.profilePhoto,
                ),
                radius: 50,
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 3.7,
                    child: Text(institution.name,
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width > 500
                                ? 30
                                : 25)
                        //MediaQuery.of(context).size.width > 500 ? 30 : 25),
                        ),
                  ),
                  // Row(
                  //   children: <Widget>[
                  //     Text(
                  //       'Rang',
                  //       style: TextStyle(
                  //           fontSize: MediaQuery.of(context).size.width > 500
                  //               ? 20
                  //               : 18),
                  //     ),
                  //     SizedBox(
                  //       width: 10,
                  //     ),
                  //     // Icon(
                  //     //   Icons.star,
                  //     // ),
                  //     // Icon(Icons.star),
                  //     // Icon(Icons.star),
                  //     // Icon(Icons.star),
                  //     // Icon(Icons.star),
                  //   ],
                  // )
                ],
              ),
            ],
          ),
          loginAdmin.isNotEmpty && MediaQuery.of(context).size.width > 750
              ? Padding(
                  padding: const EdgeInsets.only(top: 22.0),
                  child: Column(
                    children: [
                      institution.isVerified == false
                          ? _buildVerifyButton('tag12').showPointerOnHover
                          : Container(),
                      SizedBox(
                        height: 10,
                      ),
                      _buildDeleteButton('tag11').showPointerOnHover,
                    ],
                  ),
                )
              : Text(''),
        ],
      ),
    );
  }

  Future<List<PostInfo>> _makeFuture() {
    switch (isPressed1) {
      case true:
        return APIPosts.getInstitutionPosts(institution.id, Token.jwt);
        break;
      case false:
        return APIPosts.fetchSavedPosts(institution.id, Token.jwt);
        break;
    }
    return null;
  }
}
