
import 'package:WEB_flutter/screens/showUsers/listShowUsers.dart';
import 'package:flutter/material.dart';
import 'package:WEB_flutter/hover_extensions.dart';

class ShowUsers extends StatefulWidget {
  @override
  ShowUsersState createState() => ShowUsersState();
}

class ShowUsersState extends State<ShowUsers> {
  TextEditingController _searchView = new TextEditingController();
  static bool firstSearch = true;
  static String query = "";

  ShowUsersState() {
    _searchView.addListener(() {
      if (_searchView.text.isEmpty) {
        setState(() {
          firstSearch = true;
          query = "";
        });
      } else {
        setState(() {
          firstSearch = false;
          query = _searchView.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: AlignmentDirectional.topStart, children: <Widget>[
        Container(
            decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            height: 800,
            child: Column(
              children: [
                SizedBox(
                  width: 10.0,
                ),
                //_buildSearchBar(),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: <Widget>[
                      FloatingActionButton(
                        heroTag: 'backTag',
                        tooltip: 'Korak nazad',
                        backgroundColor: Color.fromRGBO(24, 74, 69, 1),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 10,),
                      _buildSearchBar(),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10.0,
                  height: 10,
                ),
                Expanded(
                  child: _buildUsers(),
                ),
              ],
            )),
      ]),
    );
  }

  Widget _buildSearchBar() {
    return Expanded(
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        child: TextField(
          controller: _searchView,
          decoration: InputDecoration(
              counterStyle: TextStyle(fontSize: 22.0),
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              hintText: 'Pretraga',
              suffixIcon: Icon(Icons.search),
              border: InputBorder.none),
          onTap: () async {},
        ).showPointerOnHover,
      ),
    );
  }

  Widget _buildUsers() {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(24, 74, 69, 1),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: <Widget>[
          _buildUsersBar(),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black38, width: 0.5),
              ),
            ),
          ),
          MediaQuery.of(context).size.width > 700
              ? _buildHeader()
              : Container(),
          ListShowUsers(),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  String text;
  Widget _buildHeader() {
    text = ListShowUsers.filterIndex == 1
        ? ''
        : ListShowUsers.filterIndex == 2 ? 'Broj prijava' : 'Broj poena';
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 140,
          ),
          Expanded(
            child: Container(
              child: Text(
                'Korisničko ime',
                style: TextStyle(
                    color: Colors.grey[200],
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Text(
                'Ime i prezime',
                style: TextStyle(
                    color: Colors.grey[200],
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Text(
                'E-mail',
                style: TextStyle(
                    color: Colors.grey[200],
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
          Expanded(
            child: Container(
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: TextStyle(
                      color: Colors.grey[200],
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )),
          ),
          SizedBox(
            width: 25,
          )
        ],
      ),
    );
  }

  static bool isPressed1 = true;
  static bool isPressed2 = false;
  static bool isPressed3 = false;

  Widget _allUsersButton(BoxConstraints constraints) {
    return FlatButton(
        color: isPressed1 ? Colors.grey[200] : Colors.blueGrey[300],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        onPressed: () {
          setState(() {
            isPressed1 = true;
            isPressed2 = false;
            isPressed3 = false;

            ListShowUsers.filterIndex = 1;
            ListShowUsers();
          });
        },
        child: Text(
          constraints.maxWidth > 900 ? 'Svi korisnici' : 'Svi \nkorisnici',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isPressed1 ? Colors.black : Colors.blueGrey[800]),
        )).showPointerOnHover;
  }

  Widget _reportedUsersButton(BoxConstraints constraints) {
    return FlatButton(
      color: isPressed2 ? Colors.grey[200] : Colors.blueGrey[300],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      onPressed: () {
        setState(() {
          isPressed1 = false;
          isPressed2 = true;
          isPressed3 = false;
          ListShowUsers.filterIndex = 2;
          ListShowUsers();
        });
      },
      child: Text(
        constraints.maxWidth > 900
            ? 'Prijavljeni korisnici'
            : 'Prijavljeni \nkorisnici',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: isPressed2 ? Colors.black : Colors.blueGrey[800],
        ),
      ),
    ).showPointerOnHover;
  }

  Widget _bestUsersButton(BoxConstraints constraints) {
    return FlatButton(
      color: isPressed3 ? Colors.grey[200] : Colors.blueGrey[300],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      onPressed: () {
        setState(() {
          isPressed1 = false;
          isPressed2 = false;
          isPressed3 = true;
          ListShowUsers.filterIndex = 3;
          ListShowUsers();
        });
      },
      child: Text(
        constraints.maxWidth > 900
            ? 'Najbolji korisnici'
            : 'Najbolji \nkorisnici',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isPressed3 ? Colors.black : Colors.blueGrey[800]),
      ),
    ).showPointerOnHover;
  }

  Widget _buildUsersBar() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _allUsersButton(constraints),
              _reportedUsersButton(constraints),
              _bestUsersButton(constraints),
            ],
          ),
        );
      },
    );
  }
}
