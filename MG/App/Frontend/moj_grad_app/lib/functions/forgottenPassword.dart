import 'package:flutter/material.dart';
import 'package:mojgradapp/functions/loading.dart';
import 'package:mojgradapp/services/APIUsers.dart';

class ForgottenPassword extends StatefulWidget {
  @override
  _ForgottenPasswordState createState() => _ForgottenPasswordState();
  static bool success;
}

class _ForgottenPasswordState extends State<ForgottenPassword> {
  TextEditingController username = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: <Widget>[_buildChild(context)],
      //key: _scaffoldstate,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }

  _buildChild(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white70.withOpacity(0.95),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Promena lozinke: ',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Unesite Vaše korisničko ime: ',
            style: TextStyle(fontSize: 15.0),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: username,
            decoration: InputDecoration(
              hintText: 'Korisničko ime',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              icon: Icon(Icons.send),
              onPressed: () async {
                 showDialog(
                    context: context,
                    builder: (context) => Loading());
                if ((await APIUsers.forgottenPassword(username.text)) == true) {
                  setState(() {
                    ForgottenPassword.success = true;
                  });
                   Navigator.pop(context);
                } else {
                  setState(() {
                    ForgottenPassword.success = false;
                  });
                   Navigator.pop(context);
                }
                Navigator.pop(context);
               
              },
            ),
          )
        ],
      ),
    );
  }
}
