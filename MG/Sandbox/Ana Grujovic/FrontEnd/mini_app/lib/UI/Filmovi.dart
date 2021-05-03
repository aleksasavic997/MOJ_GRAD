import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:miniapp/Models/APIServices.dart';
import 'package:miniapp/Models/Film.dart';


class Filmovi extends StatefulWidget {
  Filmovi({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _FilmoviState();
}

class _FilmoviState extends State<Filmovi> {
  List<Film> filmovi;

  getFilmovi() {
    APIServices.fetchFilmovi().then((response) {
      Iterable list = json.decode(response.body);
      List<Film> filmList = List<Film>();
      filmList = list.map((model) => Film.fromObject(model)).toList();

      setState(() {
        filmovi = filmList;
      });
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    getFilmovi();
    return Scaffold(
      appBar: _builAppBar(),
      body: filmovi == null ? Center(child: Text('Nema filmova za pregled'),) : _buildFilmList(),  
    );
  }

  Widget _buildFilmList() {
    return ListView.builder(
      itemCount: filmovi.length,
      itemBuilder: (context, index) {
        return Card(
            color: Color(0XFF00796B),
            elevation: 2.0,
            child: ListTile(
              title: ListTile(
                title: Text(filmovi[index].naziv,style: TextStyle(fontWeight: FontWeight.bold ),),
                subtitle: Text('Godina: ' + filmovi[index].godina.toString(), style: TextStyle(color: Colors.white),),
              ),
            ),
        );
      },
    );
  }

  Widget _builAppBar() {
    return AppBar(title: Text("Moji filmovi"),
    actions: <Widget>[
      Padding(
        padding: EdgeInsets.all(10.0),
        child: RaisedButton(
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pushNamed('/loginScreen');
          },
          child: Text(
            "Odjava",
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ],
    );
  }

  
}

