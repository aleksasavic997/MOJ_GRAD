import 'package:flutter/material.dart';
import 'package:myapp/Models/Korisnici.dart' as user;
import 'package:myapp/Models/Serije.dart';
import  'package:myapp/UI/Serije.dart';
import 'signup.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => new SignupPage(),
        '/prikaziSerije': (BuildContext context) => new Serijes()
      },
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String username;
  String password;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.transparent,
     body: SingleChildScrollView(
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[
           Container(
             child: Stack(
               children: <Widget>[
                 Container(
                   padding: EdgeInsets.fromLTRB(15.0, 65.0, 0.0, 0.0),
                   child: Text(
                     '2B or\nnot 2B',
                     style: TextStyle(
                       color: Colors.blue[300],
                       fontSize: 50.0, fontWeight: FontWeight.bold
                     ),
                   ),
                 ),
               ],
             ),
           ),
          Container(
            padding: EdgeInsets.fromLTRB(15.0, 50.0, 15.0, 0.0),
            child: Column(
              children: <Widget>[
                TextField(
                  
                  onChanged: (val) async {
                      setState(() => username = val);
                  },
                  style: new TextStyle ( color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'USERNAME',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[200]
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white
                    )
                  ),
                )
              ),
              //SizedBox(height: 10.0),
              TextField(
                  onChanged: (val) async {
                      setState(() => password = val);
                  },
                   style: new TextStyle ( color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'PASSWORD',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[200]
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white
                    )
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 40.0),
              Container(
                height: 40.0,
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  //shadowColor: Colors.blue[100],
                  color: Colors.blue[300],
                  elevation: 7.0,
                  child: GestureDetector(
                    onTap: () async 
                    {
                      print("Username:" + username + "; Password:" + password);
                      if (username.isEmpty || password.isEmpty) { print("Username or password are empty"); } 
                      else 
                      {
                        print("password: " + password);
                        var pom = await user.Korisnici.checkUser(username, password);

                        if (pom == "true") { Navigator.of(context).pushNamed('/prikaziSerije'); } 
                        else { print("Wrong username or password"); }
                      }
                    },
                    child: Center(
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        )
                      )
                    ),
                  )
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                height: 40.0,
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue[300],
                      style: BorderStyle.solid,
                      width: 2.0
                    ),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20.0)
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/signup');
                    },
                    child: Center(
                      child: Text(
                        'REGISTER',
                        style: TextStyle(
                          color: Colors.blue[300],
                          fontWeight: FontWeight.bold
                        )
                      )
                    ),
                  )
                ),
              )
              ],
            )
          ),
         ],
         ),
     )
    );
  }
}