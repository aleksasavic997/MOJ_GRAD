import 'package:flutter/material.dart';
import 'package:WEB_flutter/hover_extensions.dart';
import '../../services/token.dart';
import 'home.dart';

class NavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/webLogo.png',
            width: 200,
            height: 100,
          ),
          Text(
            'Moj Grad ',  //ostavi razmak posle d
            style: TextStyle(
              fontSize: 40.0,
              fontFamily: 'Pacifico'
            ),
          )
        ],
      ),
    );
  }
}

class SmallNavigationBar extends StatefulWidget {
  @override
  _SmallNavigationBarState createState() => _SmallNavigationBarState();
}

class _SmallNavigationBarState extends State<SmallNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/webLogo.png',
                width: 150,
                height: 80,
              ),
              Text(
                'Moj Grad ', //ostavi razmak posle d
                style: TextStyle(fontSize: 30.0, fontFamily: 'Pacifico'),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: FloatingActionButton(
                  tooltip: 'Korak nazad',
                  heroTag: 'backTag',
                  onPressed: (){
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
                padding: EdgeInsets.only(right: 20),
                child: FloatingActionButton(
                  heroTag: 'homeTag',
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage.fromBase64(Token.jwt)));
                  },
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.home,
                    size: 30,
                    color: Color.fromRGBO(24, 74, 69, 1),
                  ),
                ),
              ).showPointerOnHover,
            ],
          )
        ],
      ),
    );
  }
}
