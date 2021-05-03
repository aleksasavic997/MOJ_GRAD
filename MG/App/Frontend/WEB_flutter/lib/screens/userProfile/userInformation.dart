import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserInformation extends StatefulWidget {

  final String username;
  final String email;
  final int points;
  final String rankName;

  const UserInformation({this.username, this.email, this.points, this.rankName});

  @override
  _UserInformationState createState() => _UserInformationState(username, email, points,rankName);
}

class _UserInformationState extends State<UserInformation> {

  String username;
  String email;
  int points;
  String rankName;
  _UserInformationState(String username, String email, int points, String rankName){
    this.username=username;
    this.email=email;
    this.points=points;
    this.rankName = rankName;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight:  Radius.circular(10.0)),
                    color: Color.fromRGBO(24, 74, 69, 1),
                  ),
                  child: Center(
                    child: Text(
                      'Informacije',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 230,
            padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10.0)),
              color: Colors.grey[200],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Korisničko ime',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black54
                          ),
                        ),
                        Text(
                          username,
                          style: TextStyle(
                            fontSize: 20
                          ),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.black26)
                    )
                  ),
                ),
                SizedBox(height: 15,),
                LayoutBuilder(
                  builder: (context, constraints){
                    if(constraints.maxWidth>400){
                      return Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'E-mail',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black54
                                ),
                              ),
                              Text(
                                email,
                                style: TextStyle(
                                  fontSize: 20
                                ),
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.black26)
                          )
                        ),
                      );
                    }
                    else{
                      return Container(
                        width: 400,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'E-mail',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black54
                                ),
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: <Widget>[
                                  SizedBox(width: 10,),
                                  Text(
                                    email,
                                    style: TextStyle(
                                      fontSize: 20
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.black26)
                          )
                        ),
                      );
                    }
                  },
                ),
                SizedBox(height: 15,),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Poeni',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black54
                          ),
                        ),
                        SizedBox(width: 15,),
                        Text(
                          points.toString(),
                          style: TextStyle(
                            fontSize: 20
                          ),
                        ),
                        SizedBox(width: 15,),
                        Text(
                          'Rang',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black54
                          ),
                        ),
                        SizedBox(width: 15,),
                       _setRank(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

    Widget _setRank() {
    Color color;
    switch (rankName) {
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
    return FaIcon(FontAwesomeIcons.solidGem,
    color: color,
    size: 25.0,);
  }
}