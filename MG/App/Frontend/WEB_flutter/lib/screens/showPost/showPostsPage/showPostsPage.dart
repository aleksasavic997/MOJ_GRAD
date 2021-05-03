import 'package:WEB_flutter/screens/showPost/showPostsPage/listShowPosts.dart';
import 'package:flutter/material.dart';
import 'package:WEB_flutter/hover_extensions.dart';

class ShowPostPage extends StatefulWidget {
  @override
  ShowPostPageState createState() => ShowPostPageState();
}

class ShowPostPageState extends State<ShowPostPage> {
 
  TextEditingController _searchView = new TextEditingController();
  static bool firstSearch = true;
  static String query = "";

  ShowPostPageState() {
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
    return SingleChildScrollView(
      child: Stack(alignment: AlignmentDirectional.topStart, children: <Widget>[
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
                Row(
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
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width-110,
                      child: _buildSearchBar() //Expanded(child:_buildSearchBar()),
                    ),
                  ],
                ),
                 SizedBox(
                  height: 10.0,
                ),
                _buildPosts(),
              ],
            )),
      ]),
    );
  }

 Widget _buildSearchBar() {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
      child: Container(
        height: 50,
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

  Widget _buildPosts() {
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
          ListShowPosts()
        ],
      ),
    );
  }

  static bool isPressed1 = true;
  static bool isPressed2 = false;
  //bool isPressed3 = false;

  Widget _buildUsersBar() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 450) {
          return Container(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                    color: isPressed1 ? Colors.grey[200] : Colors.blueGrey[300],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    onPressed: () {
                      setState(() {
                        isPressed1 = true;
                        isPressed2 = false;
                        ListShowPosts.filterIndex = 1;
                        ListShowPosts();
                      });
                    },
                    child: Text(
                      'Prijavljene objave',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color:
                              isPressed1 ? Colors.black : Colors.blueGrey[800]),
                    )).showPointerOnHover,
                FlatButton(
                  color: isPressed2 ? Colors.grey[200] : Colors.blueGrey[300],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  onPressed: () {
                    setState(() {
                      isPressed1 = false;
                      isPressed2 = true;
                      ListShowPosts.filterIndex = 2;
                      ListShowPosts();
                    });
                  },
                  child: Text(
                    'Najvažnije objave',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color:
                            isPressed2 ? Colors.black : Colors.blueGrey[800]),
                  ),
                ).showPointerOnHover,
              ],
            ),
          );
        } else {
          return Container(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                    color: isPressed1 ? Colors.grey[200] : Colors.blueGrey[300],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    onPressed: () {
                      setState(() {
                        isPressed1 = true;
                        isPressed2 = false;
                      });
                    },
                    child: Text(
                      'Svi \nkorisnici',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color:
                              isPressed1 ? Colors.black : Colors.blueGrey[800]),
                    )).showPointerOnHover,
                FlatButton(
                  color: isPressed2 ? Colors.grey[200] : Colors.blueGrey[300],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  onPressed: () {
                    setState(() {
                      isPressed1 = false;
                      isPressed2 = true;
                    });
                  },
                  child: Text(
                    'Prijavljeni \nkorisnici',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isPressed2 ? Colors.black : Colors.blueGrey[800],
                    ),
                  ),
                ).showPointerOnHover,
              ],
            ),
          );
        }
      },
    );
  }
}
