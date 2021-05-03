import 'package:WEB_flutter/config/config.dart';
import 'package:WEB_flutter/models/modelsViews/userInfo.dart';
import 'package:WEB_flutter/screens/showUsers/showUsers.dart';
import 'package:WEB_flutter/screens/userProfile/userProfile.dart';
import 'package:WEB_flutter/services/APIUsers.dart';
import 'package:WEB_flutter/services/token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:WEB_flutter/hover_extensions.dart';

class ListShowUsers extends StatefulWidget {
  static int filterIndex;
  @override
  ListShowUsersState createState() => ListShowUsersState();
}

class ListShowUsersState extends State<ListShowUsers> {
  List<UserInfo> userList = new List<UserInfo>();
  List<UserInfo> filterUsers;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            padding: EdgeInsets.all(10.0),
            child: FutureBuilder(
              future: _makeFuture(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<UserInfo>> snapshot) {
                if (snapshot.data == null) {
                  return Center(
                      child: Container(
                          //child: Text('Nije dobro')),
                          child: SpinKitFadingCircle(
                    color: Colors.white,
                    size: 50.0,
                  )));
                } else {
                  userList = snapshot.data.toList();
                  return snapshot.data.length == 0
                      ? Center(
                          child: Container(
                              padding: EdgeInsets.only(top: 200),
                              height: 500,
                              child: Text(
                                "Nema korisnika ",
                                style: TextStyle(color: Colors.white),
                              )))
                      : ShowUsersState.firstSearch
                          ? _listViewBuilder(snapshot.data.toList(), 1)
                          : _search();
                }
              },
            )));
  }

  Widget _search() {
    print("blaaaaaaaaaaaaaaa");
    filterUsers = new List<UserInfo>();
    for (int i = 0; i < userList.length; i++) {
      UserInfo item = userList[i];
      if (item.username
              .toLowerCase()
              .contains(ShowUsersState.query.toLowerCase()) ||
          item.fullName
              .toLowerCase()
              .contains(ShowUsersState.query.toLowerCase()) ||
          item.fullLastName
              .toLowerCase()
              .contains(ShowUsersState.query.toLowerCase())) {
        filterUsers.add(item);
      }
    }
    return _listViewBuilder(filterUsers, 0);
  }

  Widget _listViewBuilder(List<UserInfo> users, int ind) {
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          return _contactList(users[index]);
        });
  }

  Widget _contactList(UserInfo user) {
    var nameInitial = user.username[0].toUpperCase();
    if (user.profilePhoto.length > 0) {
      //ako je prosledejena slika
      nameInitial = ""; //
    }

    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserProfile(user: user)));
              },
              child: MediaQuery.of(context).size.width > 700
                  ? _tabletDesktopView(user, nameInitial)
                  : _mobileView(user, nameInitial))
          .showPointerOnHover,
    );
  }

  Widget _mobileView(UserInfo user, var nameInitial) {
    return Container(
      //padding: EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          backgroundImage: user.profilePhoto.length > 0
              ? NetworkImage(wwwrootURL + user.profilePhoto)
              : null,
          radius: 25,
          child: Text(
            nameInitial,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.grey[200]),
          ),
        ),
        title: Container(
            child: Text(
          'Korisničko ime: ${user.username}',
          style: TextStyle(fontSize: 13),
        )),
        subtitle: Container(
          //padding: EdgeInsets.only(left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 2.5,
              ),
              Text(
                'Ime i prezime: ${user.name} ${user.lastname}',
                style: TextStyle(fontSize: 13),
              ),
              SizedBox(
                height: 2.5,
              ),
              Text(
                'E-mail: ${user.email}',
                style: TextStyle(fontSize: 13),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabletDesktopView(UserInfo user, var nameInitial) {
    return Container(
        padding: EdgeInsets.only(left: 5.0),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width < 900 ? 15 : 20,
              ), //20
              CircleAvatar(
                backgroundColor: Colors.blue,
                backgroundImage: user.profilePhoto.length > 0
                    ? NetworkImage(wwwrootURL + user.profilePhoto)
                    : null,
                radius: 20,
                child: Text(
                  nameInitial,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10.0,
                      color: Colors.grey[200]),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width < 900 ? 15 : 50,
              ), //50
              Expanded(
                child: Container(
                  child: Row(children: <Widget>[
                    Expanded(
                      child: Text(
                        user.username,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${user.name} ${user.lastname}',
                      ),
                    ),
                    Expanded(
                      child: Text(
                        user.email,
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ListShowUsers.filterIndex == 2
                              ? Text(user.reportCount.toString())
                              : Text(''),
                          ListShowUsers.filterIndex == 3
                              ? Text(user.points.toString())
                              : Text(''),
                        ],
                      ),
                    ),
                  ]),
                ),
              )
            ]));
  }

  Future<List<UserInfo>> _makeFuture() {
    switch (ListShowUsers.filterIndex) {
      case 1:
        return APIUsers.getAllUsers(Token.jwt);
        break;
      case 2:
        return APIUsers.getReportedUsers(Token.jwt);
        break;
      case 3:
        return APIUsers.getBestUsers(Token.jwt, 1, 30, 12);
        break;
    }
    return null;
  }
}
