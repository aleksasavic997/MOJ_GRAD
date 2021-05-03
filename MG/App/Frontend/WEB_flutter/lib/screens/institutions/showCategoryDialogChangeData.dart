import 'package:WEB_flutter/hover_extensions.dart';
import 'package:WEB_flutter/models/category.dart';
import 'package:WEB_flutter/screens/institutions/changeData.dart';
import 'package:WEB_flutter/services/APIServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ShowCategoryDialogChangeData extends StatefulWidget {
  @override
  ShowCategoryDialogChangeDataState createState() =>
      ShowCategoryDialogChangeDataState();
}


class ShowCategoryDialogChangeDataState
    extends State<ShowCategoryDialogChangeData> {
  static List<Category> pomListOfCategories;

  Widget checkbox(int index) {
    return Row(
      children: <Widget>[
        Checkbox(
          value: ChangeDataState.categoryListCB[index].value,
          onChanged: (bool value) {
            print("CB $index = $value");
            setState(() {
              ChangeDataState.categoryListCB[index].value = value;
            });
          },
          activeColor: Colors.teal[900],
        ).showPointerOnHover,
        Text(ChangeDataState.categoryListCB[index].category.name),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  int i;
                  for (var pom in ChangeDataState.categoryListCB) {
                    for (i = 0; i < pomListOfCategories.length; i++) {
                      if (pomListOfCategories[i].id == pom.category.id) {
                        pom.value = true;
                        break;
                      }
                    }
                    if (i == pomListOfCategories.length) pom.value = false;
                  }

                  setState(() {
                    ChangeDataState.listOfCategories = pomListOfCategories;
                  });

                  Navigator.pop(context);
                },
                child: Icon(Icons.close),
              ),
            ],
          ),
          Center(
            child: Text(
              'Kategorije',
              style: TextStyle(
                  color: Color.fromRGBO(24, 74, 69, 1),
                  fontSize: 30,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      content: Container(
        width: MediaQuery.of(context).size.width > 940
            ? MediaQuery.of(context).size.width / 3 //desktop
            : (MediaQuery.of(context).size.width > 590
                ? MediaQuery.of(context).size.width / 2 //tablet
                : MediaQuery.of(context).size.width / 1.5), //mob
        height: MediaQuery.of(context).size.height / 2.5,
        child: SingleChildScrollView(
          child: FutureBuilder<List<Category>>(
            future: APIServices.getCategory(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Container(
                    child: SpinKitFadingCircle(
                      color: Color.fromRGBO(24, 74, 69, 1),
                      size: 30,
                    ),
                  ),
                );
              } else {
                return Column(
                    children: List.generate(
                        snapshot.data.length, (index) => checkbox(index)));
              }
            },
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, bottom: 15.0),
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                for (var cat in ChangeDataState.categoryListCB) {
                  if (cat.value == true) {
                    pomListOfCategories.add(cat.category);
                    print("id=${cat.category.id}");
                  }
                }
                ChangeDataState.listOfCategories = pomListOfCategories;
              });
              Navigator.pop(context);
            },
            child: Icon(
              Icons.check,
              color: Colors.white,
            ),
            backgroundColor: Colors.teal[900],
          ).showPointerOnHover,
        ),
      ],
    );
  }
}
