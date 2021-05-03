import 'package:flutter/material.dart';
import 'package:WEB_flutter/hover_extensions.dart';
class ExpandedText extends StatefulWidget {
  final String text;

  ExpandedText({@required this.text});

  @override
  _ExpandedTextState createState() => new _ExpandedTextState();
}

class _ExpandedTextState extends State<ExpandedText> {
  String firstHalf;
  String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 65) {
      firstHalf = widget.text.substring(0, 65);
      secondHalf = widget.text.substring(65, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: secondHalf.isEmpty
          ? new Text(firstHalf)
          : InkWell(
            child: RichText(
              text: TextSpan(
                text: flag ? firstHalf : (firstHalf + secondHalf),
                style: TextStyle(color: Colors.grey[600]),
                children: <TextSpan>[
                  TextSpan(
                    text: flag ? ' ...' : '', 
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20
                    )
                  )
                ]
              ),
            ),
            // child: Container(
            //   child: Text(
            //     flag ? firstHalf+ " . . ." : firstHalf+secondHalf,
            //     // style: new TextStyle(
            //     //   color: Colors.blue, 
            //     //   fontWeight: FontWeight.bold, 
            //     //   fontSize: 20,
            //     //   letterSpacing: 3
            //     // ),
            //   ),
            // ),
            // onTap: () {
            //   setState(() {
            //     flag = !flag;
            //   });
            // },
            onTap: () {
                setState(() {
                  flag = !flag;
                });
              },
          ).showPointerOnHover
          // : new Row(
          //     children: <Widget>[
          //       Expanded(child: new Text(flag ? firstHalf : (firstHalf + secondHalf))),
          //       new InkWell(
          //         child: Container(
          //           child: Text(
          //             flag ? " ..." : "",
          //             style: new TextStyle(
          //               color: Colors.blue, 
          //               fontWeight: FontWeight.bold, 
          //               fontSize: 20,
          //               letterSpacing: 3
          //             ),
          //           ),
          //         ),
          //         onTap: () {
          //           setState(() {
          //             flag = !flag;
          //           });
          //         },
          //       ),
          //     ],
          //   ),
    );
  }
}