import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Colors.transparent,
      children: <Widget>[
        Center(
          child: Container(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey[500],
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.teal[900]),
            ),
          ),
        )
      ],
    );
  }
}
