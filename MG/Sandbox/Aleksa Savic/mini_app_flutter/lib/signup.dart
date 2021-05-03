import 'package:flutter/material.dart';
import 'package:mini_app_flutter/Models/Posetioc.dart';
import 'package:mini_app_flutter/Models/Posetioc.dart' as posetioc;
import 'package:mini_app_flutter/UI/Festivali.dart';
void main()=> runApp(new MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      home:new SignupPage(),
      routes: <String, WidgetBuilder>{
        '/homeScreen':(BuildContext context) =>new Festivali(),
      },
      theme: new ThemeData(
        primarySwatch:Colors.blue
      )
    );
  }
}

class SignupPage extends StatefulWidget{
  @override
  State createState()=>new SignupState();
}

class SignupState extends State<SignupPage>{
  
  String ime;
  String prezime;
  String username;
  String password1;
  String password2;

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: new Text(
                
                
                'Fest World',
              
                style:TextStyle(
                  fontSize: 60.0,
                  color:Colors.red[900],
                  fontWeight: FontWeight.w900,
                  
                ),
              ),
      ),
        
        
    
      backgroundColor:Colors.black,
      body:new Stack(
        fit:StackFit.expand,
        children: <Widget>[
          new Image(
            image: new AssetImage('Assets/festival.jpg'),
            fit:BoxFit.cover,
            
          ),
          new Column(
            children: <Widget>[   
              new Form(
                child: new Theme(
                    data:new ThemeData(
                      brightness: Brightness.dark,
                      inputDecorationTheme: new InputDecorationTheme(
                        labelStyle: new TextStyle(
                          color: Colors.red[900],
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        
                          )
                      )
                    
                    ),
                    child:new Container(
                      padding: const EdgeInsets.only(top:30,left:30.0,right: 30.0),
                    child: new Column(
                                  
                    mainAxisAlignment: MainAxisAlignment.center,
                    
                    children: <Widget>[
                      
                      new TextFormField(
                        cursorColor: Colors.red,
                      decoration: new InputDecoration(
                        
                        labelText:"First Name",
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color:Colors.red)
                        )                     
                      ),
                      keyboardType: TextInputType.text,
                      onChanged:(text)
                      {
                        ime=text;
                      }
                      
                    ),
                    new TextFormField(
                      cursorColor: Colors.red,
                      decoration: new InputDecoration(
                        labelText:"Last Name", 
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color:Colors.red)
                        )                    
                      ),
                      keyboardType: TextInputType.text,
                      onChanged:(text)
                      {
                        prezime=text;
                      }
                      
                    ),
                    new TextFormField(
                      cursorColor: Colors.red,
                      decoration: new InputDecoration(
                        labelText:"Username",
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color:Colors.red)
                        )                     
                      ),
                      keyboardType: TextInputType.text,
                      onChanged:(text)
                      {
                        username=text;
                      }
                      
                    ),
                    new TextFormField(
                      cursorColor: Colors.red,
                      
                      decoration: new InputDecoration(
                        labelText:"Password",
                        
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color:Colors.red)
                        )
                      ),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      onChanged:(text)
                      {
                        password1=text;
                      }
                    ),
                    new TextFormField(
                      cursorColor: Colors.red,
                      decoration: new InputDecoration(
                        labelText:"Password again",
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color:Colors.red)
                        )
                      ),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      onChanged:(text)
                      {
                        password2=text;
                      }
                    ),
                    new Padding(padding: const EdgeInsets.only(top:100.0)),
                    new MaterialButton(
                      minWidth: 200.0,
                      height: 50.0,
                      color: Colors.red[900], 
                      textColor: Colors.white,
                      child:new Text(
                        "Register"

                      ),
                      onPressed: () async{
                        if(password1!=password2 || ime.isEmpty || prezime.isEmpty || password1.isEmpty || password2.isEmpty)
                          print('greska');
                        else
                        {
                          Posetioc p = new Posetioc(ime, prezime, username, password1);
                          var rez=await posetioc.Posetioc.registrujPosetioca(p);
                          if(rez.toString()=="true")
                            Navigator.of(context).pushNamed('/homeScreen');
                            else{
                              print("Posetilac mozda ne postoji");
                            }
                        }
                      },
                      ),
                     
                      
                    ],
                  ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}