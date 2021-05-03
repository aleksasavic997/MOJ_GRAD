import 'package:flutter/material.dart';

class Rating extends StatefulWidget {
  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  var _myColorOne = Colors.grey;
  var _myColorTwo = Colors.grey;
  var _myColorThree = Colors.grey;
  var _myColorFour = Colors.grey;
  var _myColorFive = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new IconButton(
            icon: new Icon(Icons.star),
            onPressed: () => setState(() {
              _myColorOne = Colors.orange;
              _myColorTwo = Colors.grey;
              _myColorThree = Colors.grey;
              _myColorFour = Colors.grey;
              _myColorFive = Colors.grey;
            }),
            color: _myColorOne,
          ),
          new IconButton(
            icon: new Icon(Icons.star),
            onPressed: () => setState(() {
              _myColorOne = Colors.orange;
              _myColorTwo = Colors.orange;
              _myColorThree = Colors.grey;
              _myColorFour = Colors.grey;
              _myColorFive = Colors.grey;
            }),
            color: _myColorTwo,
          ),
          new IconButton(
            icon: new Icon(Icons.star),
            onPressed: () => setState(() {
              _myColorOne = Colors.orange;
              _myColorTwo = Colors.orange;
              _myColorThree = Colors.orange;
              _myColorFour = Colors.grey;
              _myColorFive = Colors.grey;
            }),
            color: _myColorThree,
          ),
          new IconButton(
            icon: new Icon(Icons.star),
            onPressed: () => setState(() {
              _myColorOne = Colors.orange;
              _myColorTwo = Colors.orange;
              _myColorThree = Colors.orange;
              _myColorFour = Colors.orange;
              _myColorFive = Colors.grey;
            }),
            color: _myColorFour,
          ),
          new IconButton(
            icon: new Icon(Icons.star),
            onPressed: () => setState(() {
              _myColorOne = Colors.orange;
              _myColorTwo = Colors.orange;
              _myColorThree = Colors.orange;
              _myColorFour = Colors.orange;
              _myColorFive = Colors.orange;
            }),
            color: _myColorFive,
          ),
        ],
      ),
    );
  }
}
