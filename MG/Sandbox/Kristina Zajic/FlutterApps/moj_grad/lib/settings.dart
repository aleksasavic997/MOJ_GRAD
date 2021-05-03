import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mojgrad/Models/APIServices.dart';
import 'package:mojgrad/Models/Automobil.dart';
import 'package:mojgrad/login_page.dart';
class ShowCars extends StatefulWidget
{
  ShowCars({Key key}) : super(key : key);
  @override
  _ShowCarsState createState() => _ShowCarsState();
}

class _ShowCarsState extends State<ShowCars>
{
  List<Automobil> cars;

  getCars()
  {
    APIServices.fetchCars().then((response)
    {
      Iterable list = json.decode(response.body);
      List<Automobil> carList = List<Automobil>();
      carList = list.map((x) => Automobil.fromObject(x)).toList();
      setState(() {
        cars = carList;
        //print(cars[1]);
      });
    });
  }

  @override
  Widget build(BuildContext context)
  {
    getCars();
    return MaterialApp(
      title: 'Rent a car',
      //debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cars'),
          actions: <Widget>[
            IconButton(icon: new Icon(Icons.home), onPressed: () async{
              Navigator.of(context).pushNamed('/homeScreen');
            }),
           // IconButton(icon: new Icon(Icons.exit_to_app),onPressed: () async{
             // Navigator.of(context).pushNamed('/loginpage');
            //}),
          ],
        ),
        body: cars == null? Center(child: Text("There's no available cars!")) : _buildCarsList(),
      ),
        routes: <String, WidgetBuilder>{
          //'/signup' : (BuildContext context) => new SignUpPage(),
          '/homeScreen': (BuildContext context) => new ShowCars(),
          '/loginpage': (BuildContext context) => new LoginPage(),
        },
    theme: ThemeData.dark(),
    );
  }

  Widget _buildCarsList()
  {
    return ListView.builder(
      itemCount: cars.length,
      itemBuilder: (context,index){
        return Card(
          color: Colors.grey,
          elevation: 2.0,
          child: ListTile(
            title: ListTile(
              title: Text(cars[index].naziv),
              onTap: (){print('Kolaaa'+ cars[index].naziv);},
            ),
          ),
        );
      },
    );
  }
}