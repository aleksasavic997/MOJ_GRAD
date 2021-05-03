import 'package:flutter/material.dart';
import 'package:mojgradapp/functions/localNotification.dart';
import 'package:mojgradapp/screens/buildBodyRead.dart';
import 'package:mojgradapp/screens/buildBodyUnread.dart';
import 'package:mojgradapp/functions/bottomNavigationBar.dart';


class NotificationPage extends StatefulWidget
{
  NotificationPage({Key key}) : super(key: key);
  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<NotificationPage>
{
  @override
  Widget build(BuildContext context)
  {
    // return Container(
    //    child: LocalNotification(),
    // );
    return DefaultTabController
    (
      length: 2,
      child: Scaffold
      (
        backgroundColor:Theme.of(context).backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Obaveštenja',style:Theme.of(context).textTheme.title,),
          bottom: TabBar
          (unselectedLabelColor: Colors.blueGrey[200],
          labelColor: Colors.white,
          indicatorColor: Colors.white,
            tabs: <Widget>
            [
              Tab(text: 'NOVO',),
              Tab(text: 'PROČITANO')
            ],
          ),
          centerTitle: true,
        ),
        body: TabBarView
        (
          children: <Widget>
          [
            Container
            (
              child: SingleChildScrollView
              (
                child: BuildBodyUnread(),
                scrollDirection: Axis.vertical,
              ),
            ),
            Container
            (
              child: SingleChildScrollView
              (
                child: BuildBodyRead(),
                scrollDirection: Axis.vertical,
              ),
            ),
          ],
        ),
        bottomNavigationBar: MyBottomNavigationBar(value: 3,),
      ),
    );
  }

}
