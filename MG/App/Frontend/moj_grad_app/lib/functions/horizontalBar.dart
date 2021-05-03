// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:mojgradapp/services/APIServices.dart';
// import 'dart:convert';
// import 'package:mojgradapp/models/category.dart';
// import 'package:mojgradapp/services/token.dart';

// class HorizontalList extends StatefulWidget {
//   _HorizontalListState createState() => _HorizontalListState();
// }

// class _HorizontalListState extends State<HorizontalList> {
//   List<Category> categories;
//   int ind = 0;
//   getCategory() async {
//     await APIServices.fetchCategory(Token.jwt).then((response) {
//       Iterable list = json.decode(response.body);
//       List<Category> categoryList = List<Category>();
//       categoryList = list.map((model) => Category.fromObject(model)).toList();
//       ind = 1;
//       setState(() {
//         categories = categoryList;
//       });
//     });
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getCategory();
//   }

//   Widget build(BuildContext context) {
//     getCategory();
//     return Container(
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Container(
//           child: Row(
//             children: <Widget>[
//               /*for (Category pomCategory in categories)
//                 getButtonCategory(pomCategory)*/
//               if (ind == 1)
//                 getButtonCategory(categories[0]),
//               if (ind == 1) getButtonCategory(categories[1]),
//               if (ind == 1) getButtonCategory(categories[2]),
//               if (ind == 1) getButtonCategory(categories[3]),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class getButtonCategory extends StatelessWidget {
//   Category category;

//   getButtonCategory(Category pomCategory) {
//     category = pomCategory;
//   }

//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(2.0),
//       child: InkWell(
//         onTap: () {},
//         child: Container(
//           width: 180.0,
//           child: ListTile(
//             title: RaisedButton(
//               color:  Theme.of(context).primaryColor,
//               shape: RoundedRectangleBorder(
//                 borderRadius: new BorderRadius.circular(15.0),
//                 //side: BorderSide(color: Colors.red)
//               ),
//               onPressed: () {
//                 print("Kategorija redni broj: ${category.id}");
//               },
//               child: Text(category.name,
//                   style: TextStyle(
//                     color: Colors.white,
//                   )),
//             ),
//             //style: TextStyle(height: 100),
//             //),
//           ),
//         ),
//       ),
//     );
//   }
// }
