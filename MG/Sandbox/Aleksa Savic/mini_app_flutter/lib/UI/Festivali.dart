import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mini_app_flutter/Models/Festival.dart';
import 'package:mini_app_flutter/Models/APIServices.dart';

class Festivali extends StatefulWidget{
  Festivali({Key key}):super(key: key);

  @override
  State<StatefulWidget> createState()=>_FestivaliState();
}

class _FestivaliState extends State<Festivali> {
  List<Festival> festivali;

  getFestivali() {
    APIServices.fetchFestivali().then((response) {
      Iterable list = json.decode(response.body);
      List<Festival> festivalList = List<Festival>();
      festivalList = list.map((model) => Festival.fromObject(model)).toList();

      setState(() {
        festivali = festivalList;
      });
    }
    );
  }


  @override
  Widget build(BuildContext context) {
    getFestivali();
    return Scaffold(
      backgroundColor: Colors.black,
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
      body: festivali == null ? Center(child: Text('Ne postoje festivali za pregled'),) : _buildFestivalList(),
    );
  }

  Widget _buildFestivalList() {
    return ListView.builder(
      itemCount: festivali.length,
      itemBuilder: (context, index) {
        return Card(
            color: Colors.red[900],
            child: ListTile(
              title: ListTile(
                title: Text(
                  festivali[index].nazivFestivala,
                  style: TextStyle(
                    fontWeight: FontWeight.bold 
                    ),
                  ),
              ),
            ),
        );
      },
    );
  }



}