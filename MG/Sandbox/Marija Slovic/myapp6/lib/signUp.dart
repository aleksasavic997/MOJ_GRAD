import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[700],
      ),
      backgroundColor: Colors.blueGrey[800],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(35.0, 45.0, 0.0, 0.0),
                    child: Text(
                      'Signup',
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 60.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 35.0, 20.0, 0.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    style: TextStyle(
                      color: Colors.grey[300],
                    ),
                    decoration: InputDecoration(
                      labelText: 'EMAIL',
                      fillColor: Colors.white,
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber[700])
                      )
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  TextField(
                    style: TextStyle(
                      color: Colors.grey[300],
                    ),
                    decoration: InputDecoration(
                      labelText: 'PASSWORD',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber[700])
                      )
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 20.0,),
                  TextField(
                    style: TextStyle(
                      color: Colors.grey[300],
                    ),
                    decoration: InputDecoration(
                      labelText: 'USERNAME',
                      fillColor: Colors.white,
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber[700])
                      )
                    ),
                  ),
                  SizedBox(height: 50.0,),
                  Container(
                    height: 40.0,
                    width: 200.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.amber[600],
                      color: Colors.amber[700],
                      //elevation: 2.0,
                      child: GestureDetector(
                        onTap: (){},
                        child: Center(
                          child: Text(
                            'SIGNUP',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ),
                  ),

                  // SizedBox(height: 15.0,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     Text(
                  //       'New to AppName?',
                  //       style: TextStyle(
                  //         color: Colors.grey[300],
                  //       ),
                  //     ),
                  //     SizedBox(width: 5.0,),
                  //     InkWell(
                  //       onTap: () {},
                  //       child: Text(
                  //         'Register',
                  //         style: TextStyle(
                  //           color: Colors.amber[700],
                  //           fontWeight: FontWeight.bold,
                  //           decoration: TextDecoration.underline,
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
