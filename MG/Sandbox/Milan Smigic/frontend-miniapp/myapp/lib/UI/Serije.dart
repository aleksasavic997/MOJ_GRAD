import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myapp/Models/APIServices.dart';
import 'package:myapp/Models/Serije.dart';


class Serijes extends StatefulWidget {
  Serijes({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _SerijeState();
}

class _SerijeState extends State<Serijes> 
{
  List<Serije> serije;

  getSerije() {
    APIServices.fetchSerije().then((response) {
      Iterable list = json.decode(response.body);
      List<Serije> ser = List<Serije>();
      ser = list.map((model) => Serije.fromObject(model)).toList();

      setState(() {
        serije = ser;
      });
    }
    );
  }

  Widget _buildSeriesList() {
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(30.0, 65.0, 30.0, 0.0), 
      itemCount: serije.length,
      itemBuilder: (context, index) {
        return Card(
            color: Colors.blue[300],      
            child: ListTile(
              title: ListTile(
                title: Text(
                  serije[index].naziv,
                  style: TextStyle(
                    fontWeight: FontWeight.bold, 
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        );
      },
    );
  } 

  Widget _builAppBar() {
    return AppBar(
      title: Text("TV shows"), 
      backgroundColor: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    getSerije();
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: _builAppBar(),
      body: serije == null ? Center(child: Text('There is no series to show!'),) : _buildSeriesList(),
    );
  } 
}

