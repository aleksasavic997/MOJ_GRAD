import 'dart:convert';

import 'package:flutter/material.dart';
import 'Models/APIServices.dart';
import 'Models/Dogadjaj.dart';

class Home extends StatefulWidget {
  Home({Key key}): super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Dogadjaj> desavanja;

  dajDesavanja(){
    APIServices.uzmiBDogadjaj().then((value) {
      Iterable lista=jsonDecode(value.body);
      List<Dogadjaj> listaDogadjaja=List<Dogadjaj>();
      listaDogadjaja=lista.map((obj) => Dogadjaj.fromObject(obj)).toList();

      setState(){
        desavanja = listaDogadjaja;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    dajDesavanja();
    return Scaffold(
      backgroundColor: Colors.blueGrey[800],
      body: desavanja==null ? nemaDesavanja(): napraviListuDesavanja()
    );
  }

  Widget nemaDesavanja(){
    return Center(
        child: Text(
          'Nema desavanja!',
          style: TextStyle(
            color: Colors.white
          )
        ),
    );
  }

  Widget napraviListuDesavanja(){
    return SafeArea(
      child: ListView.builder(
        itemCount: desavanja.length,
        itemBuilder: (context, index){
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                title: Text(
                  desavanja[index].naslov,
                ),
              ),
            ),
          );
        },

      ),
        // child: Column(
        //   children: <Widget>[
        //     Padding(
        //       padding: EdgeInsets.all(20.0),
        //       child: Container(
        //         alignment: Alignment.topRight,
        //         child: InkWell(
        //           onTap: () {
        //             Navigator.pop(context, '/login');
        //           },
        //           child: Text(
        //             'Odjavi se',
        //             textAlign: TextAlign.right,
        //             style: TextStyle(
        //               color: Colors.amber[700],
        //               fontSize: 18.0,
        //               fontWeight: FontWeight.bold,
        //               decoration: TextDecoration.underline,
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
            
        //     SizedBox(height: 10.0,),
        //     Column(
        //       children: <Widget>[
        //         Padding(
        //           padding: EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
        //           child: Card(
        //             child: ListTile(
        //               title: Text('Izlozba'),
        //             ),
        //           ),
        //         ),
        //         Padding(
        //           padding: EdgeInsets.all(8.0),
        //           child: Card(
        //             color: Colors.deepPurple[200],
        //             child: Row(
        //               children: <Widget>[
        //                 Icon(Icons.music_note),
        //                 SizedBox(width: 10.0,),
        //                 Container(
        //                   child: ListTile(
        //                     title: Text(
        //                       'Muzika',
        //                       style: TextStyle(
        //                         color: Colors.deepPurple[900],
        //                         fontWeight: FontWeight.bold,
        //                         fontSize: 20.0
        //                       ),
        //                     ),
        //                   ),
        //                 )
        //                 // ListTile(

        //                 //   title: Text(
        //                 //     'Muzika',
        //                 //     style: TextStyle(
        //                 //       color: Colors.deepPurple[900],
        //                 //       fontWeight: FontWeight.bold,
        //                 //       fontSize: 20.0
        //                 //     ),
        //                 //   ),
        //                 // ),
        //               ],
        //             ),
        //           ),
        //         )
        //       ],
        //     )
        //   ],
        // ),
      );
  }
}