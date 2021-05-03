import 'package:WEB_flutter/config/config.dart';
import 'package:WEB_flutter/main.dart';
import 'package:WEB_flutter/models/modelsViews/userInfo.dart';
import 'package:WEB_flutter/screens/homePage/bodyOfPage/pagBodyTablet.dart';
import 'package:WEB_flutter/screens/homePage/bodyOfPage/pageBodyDesktop.dart';
import 'package:WEB_flutter/screens/homePage/home.dart';
import 'package:WEB_flutter/services/token.dart';
import 'package:flutter/material.dart';

class SearchData extends SearchDelegate<String> {
  static List<UserInfo> listaKorisnika;

  //final korisnici = ['bbb', 'aaaa', 'cccc', 'dddd'];
  static List<UserInfo> skoro;

  @override
  String get searchFieldLabel => "Pretraži";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          PageBodyDesktopState.controller.text = "";
          PageBodyTabletState.controller.text = "";
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          setState(() {
            PageBodyDesktopState.controller.text = query;
            PageBodyTabletState.controller.text = query;
          });
          //close(context, null);
         Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage.fromBase64(Token.jwt))
         );
        },
      );
    });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
    // GestureDetector(onTap: () {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => HomePage.fromBase64(Token.jwt),
    //     ),
    //   );
    // });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //for (int i = 0; i < 4; i++) skoro.add(SearchData.listaKorisnika[i]);
    final List<UserInfo> suggestionList = query.isEmpty
        ? skoro.toList()
        : SearchData.listaKorisnika
            .where((x) =>
                x.username.toLowerCase().contains(query.toLowerCase()) ||
                x.fullName.toLowerCase().contains(query.toLowerCase()) ||
                x.fullLastName.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          idUserFilter = suggestionList[index].id;
          //print("\nseeeeeeeeeeeeeee ${suggestionList[index].fullName}");
          //showResults(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage.fromBase64(Token.jwt),
            ),
          );
        },
        leading: CircleAvatar(
          backgroundColor: Colors.black,
          backgroundImage:
              NetworkImage(wwwrootURL + suggestionList[index].profilePhoto),
        ),
        title: RichText(
          text: TextSpan(
            text: suggestionList[index].name +
                " " +
                suggestionList[index].lastname,
            //suggestionList[index].username.substring(0, query.length),
            // ///// za pretragu po imenu i prezimenu
            //  suggestionList[index].name.substring(
            //         0,
            //         suggestionList[index].name.length < query.length
            //             ? suggestionList[index].name.length
            //             : query.length) +
            //     //" " +
            //     (suggestionList[index].name.length > query.length
            //         ? suggestionList[index].lastname.substring(0,0)
            //         : suggestionList[index]
            //             .lastname
            //             .substring(0, query.length-suggestionList[index].name.length)),
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
            // children: [
            //   TextSpan(
            //       text:
            //           suggestionList[index].username.substring(query.length),
            //       // suggestionList[index].name.substring(query.length) +
            //       //     //" " +
            //       //     suggestionList[index].lastname.substring(0),
            //       style: TextStyle(color: Colors.grey))
            // ]
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Row(
            //   children: [
            //     Text(
            //       suggestionList[index].name,
            //       style: TextStyle(fontSize: 12),
            //     ),
            //     Text(
            //       " " + suggestionList[index].lastname,
            //       style: TextStyle(fontSize: 12),
            //     )
            //   ],
            // ),
            Text(
              suggestionList[index].username,
              style: TextStyle(fontSize: 12),
            ),
            Text(
              suggestionList[index].cityName,
              style: TextStyle(fontSize: 12),
            )
          ],
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
