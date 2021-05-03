import 'package:flutter/material.dart';
import 'package:mojgradapp/config/config.dart';
import 'package:mojgradapp/functions/allActiveChallengeMap.dart';
import 'package:mojgradapp/models/modelsViews/postInfo.dart';
import 'package:mojgradapp/screens/posts/viewPostPage.dart';

class PostReview extends StatefulWidget {
  @override
  _PostReviewState createState() => _PostReviewState();
  final PostInfo post;
  PostReview({this.post});
}

class _PostReviewState extends State<PostReview> {
  @override
  Widget build(BuildContext context) {
    MapPageAll.conn = context;
    return SimpleDialog(
      children: <Widget>[_buildChild(context)],
      //key: _scaffoldstate,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
    //child: _buildChild(context));
  }

  _buildChild(BuildContext context) {
    return SingleChildScrollView(
      child: GestureDetector(
        child: Container(
          padding: EdgeInsets.all(20.0),
          //height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white70.withOpacity(0.95),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _buildTitle(),
              _buildSizedBox(),
              _buildLocation(),
              _buildSizedBox(),
              _buildPhoto(),
              _buildSizedBox(),
              _buildCaption(),
            ],
          ),
        ),
        onTap: () {
          ViewPost.postId = widget.post.id;
          Navigator.of(MapPageAll.conn).pushNamed('/viewPost');
        },
      ),
    );
  }

  Widget _buildTitle() {
    return _buildTextFiled(widget.post.title);
  }

  Widget _buildLocation() {
    return _buildTextFiled(widget.post.location, loc: 1);
  }

  Widget _buildSizedBox() {
    return SizedBox(
      height: 10,
    );
  }

  Widget _buildPhoto() {
    return Container(child: Image.network(wwwrootURL + widget.post.imagePath));
  }

  Widget _buildCaption() {
    return _buildTextFiled(widget.post.description);
  }

  Widget _buildTextFiled(String data, {int loc = 0}) {
    var color;
    if (loc == 1)
      color = Colors.blue;
    else
      color = Colors.black;
    return Text(
      data,
      style: TextStyle(color: color),
    );
  }
}
