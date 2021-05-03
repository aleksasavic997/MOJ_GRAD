import 'package:WEB_flutter/hover_extensions.dart';
import 'package:WEB_flutter/models/category.dart';
import 'package:WEB_flutter/screens/institutions/signupPage.dart';
import 'package:WEB_flutter/services/APIServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ShowCategoryDialog extends StatefulWidget {
  @override
  _ShowCategoryDialogState createState() => _ShowCategoryDialogState();
}

class MyCheckbox {
  // String title = "";
  Category category;
  bool value;

  MyCheckbox(Category category, bool value) {
    //this.title = title;
    this.value = value;
    this.category = category;
  }
}

class _ShowCategoryDialogState extends State<ShowCategoryDialog> {
  List<MyCheckbox> _categoryList = SignUpPage.categoryList == null
      ? new List<MyCheckbox>()
      : List.from(SignUpPage.categoryList);

  Widget checkbox(int index) {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Checkbox(
          value: _categoryList[index].value,
          onChanged: (bool value) {
            setState(() {
              _categoryList[index].value = value;
            });
          },
          activeColor: Colors.teal[900],
        ).showPointerOnHover,
        Text(_categoryList[index].category.name),
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
        width:  MediaQuery.of(context).size.width > 940 
            ? MediaQuery.of(context).size.width/3 //desktop
            : (MediaQuery.of(context).size.width > 590
                ? MediaQuery.of(context).size.width/2 //tablet
                : MediaQuery.of(context).size.width/1.5), //mob
        height: MediaQuery.of(context).size.height/2.5,
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
                if (_categoryList.length == 0) {
                  for (int i = 0; i < snapshot.data.length; i++) {
                    _categoryList.add(MyCheckbox(snapshot.data[i], false));
                  }
                }
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
                SignUpPage.categoryList = _categoryList.map((e) => e).toList();
              });
              print(SignUpPage.categoryList);
              print(_categoryList.length);
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