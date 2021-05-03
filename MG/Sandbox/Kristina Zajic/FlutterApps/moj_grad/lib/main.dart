import 'package:flutter/material.dart';
import 'package:mojgrad/settings.dart';
import 'package:mojgrad/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rent a car',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Please Login'),
          actions: <Widget>[
            IconButton(icon: new Icon(Icons.home), onPressed: () async{
              Navigator.of(context).pushNamed('/homeScreen');
            }),
            IconButton(icon: new Icon(Icons.exit_to_app),onPressed: () async{
              Navigator.of(context).pushNamed('/loginpage');
            }),
          ],
        ),
        body: LoginPage(),
      ),
      routes: <String, WidgetBuilder>{
        //'/signup' : (BuildContext context) => new SignUpPage(),
        '/homeScreen' : (BuildContext context) => new ShowCars(),
        '/loginpage' : (BuildContext context) => new LoginPage(),


      },
      theme: ThemeData.dark(),
    );
  }
}
/*
class MyApp extends StatefulWidget{
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String _title="Please Login";
  Widget _screen;
  LoginPage _login;
  settings _settings;
  bool _auth;

  _MyAppState(){
    _login = new LoginPage(onSubmit: (){onSubmit();});
    _settings = new settings();
    _screen = _login;
    _auth=false;
  }

  void onSubmit(){
    print('Login with: ' + _login.email + ' ' + _login.password);
  }

  void _goHome(){
    print('GoHome');
    if(_auth==true){
      _screen = _settings;
    }
    else{
      _screen = _login;
    }
  }
  void _logout() {
    print("LogOut");
    _setAuth(false);

  }

  void _setAuth(bool auth) {
    setState(() {
      if(auth==true){
          _screen = _settings;
          _title = 'Welcome';
      }
      else{
        _screen = _login;
        _title = 'Please Login';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rent a car',
      //debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(_title),
          actions: <Widget>[
            IconButton(icon: new Icon(Icons.home), onPressed: (){_goHome();},),
            IconButton(icon: new Icon(Icons.exit_to_app),onPressed: (){_logout();}),
          ],
        ),
        body: _screen,
      ),
      theme: ThemeData.dark(),

    );
  }
}*/
