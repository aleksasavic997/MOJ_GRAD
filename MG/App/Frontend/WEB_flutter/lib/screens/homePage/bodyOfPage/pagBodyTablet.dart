import 'package:WEB_flutter/functions/search.dart';
import 'package:WEB_flutter/main.dart';
import 'package:WEB_flutter/models/institution.dart';
import 'package:WEB_flutter/screens/adminChangeData/adminChangeData.dart';
import 'package:WEB_flutter/screens/homePage/showInstitutions.dart';
import 'package:WEB_flutter/screens/homePage/showSponsors.dart';
import 'package:WEB_flutter/screens/institutions/profilePage/instProfile.dart';
import 'package:WEB_flutter/screens/newAdmin/newAdminDataPage.dart';
import 'package:WEB_flutter/services/APIInstitutions.dart';
import 'package:WEB_flutter/services/APIUsers.dart';
import 'package:WEB_flutter/services/token.dart';
import 'package:flutter/material.dart';
import 'package:WEB_flutter/screens/homePage/postsAndComments/postsAndComments.dart';
import 'package:WEB_flutter/screens/homePage/usersAndGraphs/usersAndGraphs.dart';
import 'package:WEB_flutter/hover_extensions.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../login/loginPage.dart';
import '../home.dart';

class PageBodyTablet extends StatefulWidget {
  @override
  PageBodyTabletState createState() => PageBodyTabletState();
}

class PageBodyTabletState extends State<PageBodyTablet> {
  
  int notificationCount = 0;

  Future<List<Institution>> _fun;


  @override
  void initState() {
    this._fun = APIInstitutions.getNotVerifiedInstitutions(Token.jwt);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            buildTopBar(context),
            Stack(
              alignment: AlignmentDirectional.topStart,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 1700, //zahteva neku visinu!!!!!!!!!!
                      child: Column(
                        children: <Widget>[
                          UsersAndGraphs(),
                          SizedBox(
                            height: 20,
                          ),
                          PostsAndComments()
                        ],
                      ),
                    ),
                  ],
                ),
                HomePage.notificationShow == true? showNotifications() : Text(''),
                HomePage.menuShow == true ? showMenu() : Text(''),
              ],
            )
          ],
        ));
  }

  Widget buildTopBar(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton(
              heroTag: 'fab1', // NE BRISATIIIIII
              backgroundColor: Color.fromRGBO(24, 74, 69, 1),
              child: Icon(
                Icons.menu,
                color: Colors.grey[200],
              ),
              onPressed: () {
                setState(() {
                  HomePage.notificationShow = false;
                  HomePage.menuShow = !HomePage.menuShow;
                });
              }).showPointerOnHover,
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: _buildSearchBar(),
          ),
          SizedBox(
            width: 10.0,
          ),
          FloatingActionButton(
            heroTag: 'fab2', // NE BRISATIIIIII
            backgroundColor: Color.fromRGBO(24, 74, 69, 1),
            onPressed: () {
              setState(() {
                HomePage.menuShow = false;
                HomePage.notificationShow = !HomePage.notificationShow;
              });
            },
            child: FutureBuilder(
              future: _fun,
              builder: (BuildContext context, AsyncSnapshot<List<Institution>> snapshot){
                if(!snapshot.hasData){
                  return Icon(
                    Icons.notifications,
                    color: Colors.grey[200],
                  );
                }
                else{
                  return Stack(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          Icons.notifications,
                          color: Colors.grey[200],
                        ),
                      ),
                      snapshot.data.length !=0
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
            )
          ).showPointerOnHover
        ],
      ),
    );
  }

  static TextEditingController controller=new TextEditingController();

  Widget _buildSearchBar() {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
      child: TextField(
        controller: controller,
        onChanged: (val) async{
          SearchData.listaKorisnika = await APIUsers.getAllUsers(Token.jwt);
          SearchData.skoro = SearchData.listaKorisnika;
          showSearch(context: context, delegate: SearchData(),query: val);
        },
        decoration: InputDecoration(
            counterStyle: TextStyle(fontSize: 22.0),
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            hintText: 'Pretraga',
            suffixIcon: Icon(Icons.search,color: Colors.teal[900]),
            border: InputBorder.none),
        onTap: () async {
          SearchData.listaKorisnika = await APIUsers.getAllUsers(Token.jwt);
          SearchData.skoro = SearchData.listaKorisnika;
          showSearch(context: context, delegate: SearchData(),query: controller.text);
        },
      ).showPointerOnHover,
    );
  }

  Widget menuItem(
      {String menuTitle, IconData menuIcon, Function functionOnPressed}) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white),
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: SizedBox.expand(
        child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          onPressed: functionOnPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    menuTitle,
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 30,
                  ),
                  Icon(
                    menuIcon,
                    color: Color.fromRGBO(24, 74, 69, 1),
                  )
                ],
              ),
            ],
          ),
        ).showPointerOnHover,
      ),
    );
  }

  Widget showMenu() {
    return Container(
      width: 400,
      margin: EdgeInsets.all(5),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.grey[900],
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Center(
                          child: Text(
                            'Meni',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontFamily: 'Pacifico'),
                          ),
                        ),
                      ),
                      menuItem(
                          menuIcon: Icons.edit,
                          menuTitle: 'Izmenite informacije',
                          functionOnPressed: () {
                            setState(() {
                              HomePage.menuShow = false;
                              HomePage.notificationShow = false;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdminChangeData()));
                          }),
                      menuItem(
                          menuIcon: Icons.account_balance,
                          menuTitle: 'Institucije',
                          functionOnPressed: () {
                            setState(() {
                              HomePage.menuShow = false;
                              HomePage.notificationShow = false;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ShowInstitutions()));
                          }),
                      menuItem(
                          menuIcon: Icons.monetization_on,
                          menuTitle: 'Sponzori',
                          functionOnPressed: () {
                            setState(() {
                              HomePage.menuShow = false;
                              HomePage.notificationShow = false;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ShowSponsors()));
                          }),
                      menuItem(
                          menuIcon: Icons.group_add,
                          menuTitle: 'Dodaj administratora',
                          functionOnPressed: () {
                            setState(() {
                              HomePage.menuShow = false;
                              HomePage.notificationShow = false;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewAdminData()));
                          }),
                      menuItem(
                          menuIcon: Icons.exit_to_app,
                          menuTitle: 'Odjava',
                          functionOnPressed: () {
                            loginAdmin = "";
                            setState(() {
                              HomePage.menuShow = false;
                              HomePage.notificationShow = false;
                            });
                            //Navigator.pushNamedAndRemoveUntil(context, "/login", (r) => false);
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          }),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  
  Widget showNotifications() {
    return Positioned(
      top: 0,
      right: 0,
      child: Container(
        width: 400,
        margin: EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.grey[900],
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 60,
                          child: Center(
                            child: Text(
                              'Obaveštenja',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontFamily: 'Pacifico'
                              ),
                            ),
                          ),
                        ),
                        Container(
                          //height: 320,
                          decoration: BoxDecoration(
                            //color: Colors.grey[400],
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
                          ),
                          child: Container(
                            height: 260,
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: FutureBuilder(
                              future: _fun,
                              builder: (BuildContext context, AsyncSnapshot<List<Institution>> snapshot){
                                if(!snapshot.hasData){
                                  return Center(
                                    child: Container(
                                      child: SpinKitFadingCircle(
                                        color: Colors.white,
                                        size: 50.0,
                                      )
                                    )
                                  );
                                }
                                else if(snapshot.data.length == 0){
                                  return Center(
                                    child: Text(
                                      'Nemate novih obaveštenja.',
                                      style: TextStyle(
                                        color: Colors.grey[200]
                                      ),
                                    )
                                  );
                                }
                                else{
                                  return ListView.builder(
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (BuildContext context, int index)
                                    {
                                      return oneNotification(snapshot.data[index]);
                                    }
                                  );
                                }
                              },
                            ),
                          ),
                        )
                      ]
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Widget listOfNotifications()
  // {
  //   return Column(
  //     children: <Widget>[
  //       Container(
  //         height: 260,
  //         padding: EdgeInsets.symmetric(vertical: 5),
  //         child: FutureBuilder(
  //           future: _fun,
  //           builder: (BuildContext context, AsyncSnapshot<List<Institution>> snapshot){
  //             if(!snapshot.hasData){
  //               return Center(
  //                 child: Container(
  //                   child: SpinKitFadingCircle(
  //                     color: Colors.white,
  //                     size: 50.0,
  //                   )
  //                 )
  //               );
  //             }
  //             else if(snapshot.data.length < 0){
  //               return Center(
  //                 child: Text(
  //                   'Nemate novih obaveštenja',
  //                   style: TextStyle(
  //                     color: Colors.grey[200]
  //                   ),
  //                 )
  //               );
  //             }
  //             else{
  //               notificationCount = snapshot.data.length;
  //               return ListView.builder(
  //                 itemCount: snapshot.data.length,
  //                 itemBuilder: (BuildContext context, int index)
  //                 {
  //                   return oneNotification(snapshot.data[index]);
  //                 }
  //               );
  //             }
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }
  

  Widget oneNotification(Institution institution){
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10)
      ),
      child: FlatButton(
        onPressed: (){
          setState(() {
            HomePage.notificationShow = false;
            HomePage.menuShow = false;
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InstitutionProfile(institution: institution,)));
        },
        child: Row(
          children: <Widget>[
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Institucija ',
                    ),
                    TextSpan(
                      text: institution.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )
                    ),
                    TextSpan(
                      text: ' traži odobrenje.'
                    )
                  ]
                )
              )
            ),
          ],
        ),
      ).showPointerOnHover,
    );
  }

}
