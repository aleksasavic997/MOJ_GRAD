import 'package:WEB_flutter/screens/showComments/listShowComments.dart';
import 'package:flutter/material.dart';
import 'package:WEB_flutter/hover_extensions.dart';

class ShowCommentsPage extends StatefulWidget {
  @override
  ShowCommentsPageState createState() => ShowCommentsPageState();
}

class ShowCommentsPageState extends State<ShowCommentsPage> {
  //Widget typePosts = ListShowComments();
  // @override
  // void initState() {
  //   super.initState();
  //   ListShowComments.filterIndex = 1;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:
            Stack(alignment: AlignmentDirectional.topStart, children: <Widget>[
          Center(
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                width: 800,
                height: 800,
                child: Column(
                  children: [
                    SizedBox(
                      width: 10.0,
                    ),
                    _buildComments(),
                  ],
                )),
          ),
        ]),
      ),
    );
  }

  Widget _buildComments() {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(24, 74, 69, 1),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: FloatingActionButton(
                  heroTag: 'backTag',
                  tooltip: 'Korak nazad',
                  backgroundColor: Colors.grey[200],
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Color.fromRGBO(24, 74, 69, 1)
                  ),
                ),
              ),
              Expanded(child: _buildCommentBar()),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black38, width: 0.5),
              ),
            ),
          ),
          ListShowComments(),
        ],
      ),
    );
  }

  static bool isPressed1 = true;
  static bool isPressed2 = false;
  //bool isPressed3 = false;

  Widget _buildCommentBar() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 450) {
          return Container(
            padding: EdgeInsets.all(10),
            child: Row(
              //crossAxisAlignment: CrossAxisAlignment.start,
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
                        ListShowComments.filterIndex = 1;
                        ListShowComments();
                      });
                    },
                    child: Text(
                      'Prijavljeni komentari',
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
                      ListShowComments.filterIndex = 2;
                      ListShowComments();
                    });
                  },
                  child: Text(
                    'Odobreni komentari',
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
                      'Prijavljeni \nkomentari',
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
                    'Odobreni \nkomentari',
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
