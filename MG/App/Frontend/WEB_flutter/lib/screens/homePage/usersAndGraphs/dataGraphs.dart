/*
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Graf1 extends StatefulWidget {
  @override
  _Graf1State createState() => _Graf1State();
}

class _Graf1State extends State<Graf1> {

  List<charts.Series<Task, String>> _seriesPieData;
  
  _generateData(){
    var pieData = [
      new Task('Task 1', 35.8, Color(0xff3366cc)),
      new Task('Task 2', 8.3, Color(0xff990099)),
      new Task('Task 3', 10.8, Color(0xff109618)),
      new Task('Task 4', 15.6, Color(0xfffdbe19)),
      new Task('Task 5', 19.2, Color(0xffff9900)),
      new Task('Task 6', 10.3, Color(0xffdc3912)),
    ];

    _seriesPieData.add(
      charts.Series(
        data: pieData,
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskValue,
        colorFn: (Task task, _) => charts.ColorUtil.fromDartColor(task.colorValue),
        id: 'Graf Moj Grad',
        labelAccessorFn: (Task row, _) => '${row.taskValue}',   //ovde se podesava sta nam se prikazuje inside/ouside grafa
      ),
    );
  }

  @override
  void initState(){
    super.initState();
    _seriesPieData= List<charts.Series<Task, String>>();
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 1,
        child: TabBarView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text('Naslov grafa'),
                    SizedBox(height: 10,),
                    Expanded(
                      child: charts.PieChart(   //pita graf
                        _seriesPieData, //podaci
                        animate: true,  //graf ima animaciju
                        animationDuration: Duration(seconds: 2),  //animacija traje 4 sekundi
                        /*
                        behaviors: [  //tackice sa bojama i nazivima
                          charts.DatumLegend(
                            outsideJustification: charts.OutsideJustification.endDrawArea,
                            horizontalFirst: false,
                            desiredMaxRows: 2,
                            cellPadding: EdgeInsets.only(right: 4.0, bottom: 4.0),
                            entryTextStyle: charts.TextStyleSpec(
                              color: charts.MaterialPalette.purple.shadeDefault,
                              fontFamily: 'Georgia',
                              fontSize: 11
                            )
                          )
                        ],*/
                        defaultRenderer: charts.ArcRendererConfig(  
                          //arcWidth: 100,  //radius kruga
                          arcRendererDecorators: [
                            charts.ArcLabelDecorator(
                              //labelPosition: charts.ArcLabelPosition.inside //brojke iz podataka ce se prikazati u grafu
                              labelPosition: charts.ArcLabelPosition.outside,
                            )
                          ]
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Task{
  String task;
  double taskValue;
  Color colorValue;

  Task(this.task, this.taskValue, this.colorValue);
}

class Graf2 extends StatefulWidget {
  @override
  _Graf2State createState() => _Graf2State();
}

class _Graf2State extends State<Graf2> {

  List<charts.Series<Polution, String>> _seriesData;

  _generateData(){

    var data1 = [
      new Polution(1980, 'USA', 30),
      new Polution(1980, 'Asia', 40),
      new Polution(1980, 'Europe', 10)
    ];

    var data2 = [
      new Polution(1985, 'USA', 100),
      new Polution(1980, 'Asia', 150),
      new Polution(1985, 'Europe', 80)
    ];
     
    var data3 = [
      new Polution(1985, 'USA', 200),
      new Polution(1980, 'Asia', 300),
      new Polution(1985, 'Europe', 180)
    ];

    _seriesData.add(
      charts.Series(
        data: data1,
        domainFn: (Polution polution, _) => polution.place, //x-axis
        measureFn: (Polution polution, _) => polution.quantity, //y-axis
        id: '2017',
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Polution polution, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
      ),
    );

    _seriesData.add(
      charts.Series(
        data: data2,
        domainFn: (Polution polution, _) => polution.place, //x-axis
        measureFn: (Polution polution, _) => polution.quantity, //y-axis
        id: '2018',
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Polution polution, _) => charts.ColorUtil.fromDartColor(Color(0xff109618)),
      ),
    );

    _seriesData.add(
      charts.Series(
        data: data3,
        domainFn: (Polution polution, _) => polution.place, //x-axis
        measureFn: (Polution polution, _) => polution.quantity, //y-axis
        id: '2019',
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Polution polution, _) => charts.ColorUtil.fromDartColor(Color(0xffff9900)),
      ),
    );
  }

  @override
  void initState(){
    super.initState();
    _seriesData= List<charts.Series<Polution, String>>();
    _generateData();
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: TabBarView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text('Naslov grafa'),
                    Expanded(
                      child: charts.BarChart(
                        _seriesData,
                        animate: true,
                        animationDuration: Duration(seconds: 2),
                        barGroupingType: charts.BarGroupingType.grouped,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Polution{
  String place;
  int year;
  int quantity;

  Polution(this.year, this.place, this.quantity);
}

class Graf3 extends StatefulWidget {
  @override
  _Graf3State createState() => _Graf3State();
}

class _Graf3State extends State<Graf3> {

  List<charts.Series<Sales, int>> _seriesLineData;

  _generateData(){
    var lineSalesData1 = [
      new Sales(0,45),
      new Sales(1,56),
      new Sales(2,55),
      new Sales(3,60),
      new Sales(4,61),
      new Sales(5,70),
    ];

    var lineSalesData2 = [
      new Sales(0,35),
      new Sales(1,46),
      new Sales(2,45),
      new Sales(3,50),
      new Sales(4,51),
      new Sales(5,60),
    ];
     
    var lineSalesData3 = [
      new Sales(0,20),
      new Sales(1,24),
      new Sales(2,25),
      new Sales(3,40),
      new Sales(4,45),
      new Sales(5,60),
    ];

    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
        data: lineSalesData1,
        domainFn: (Sales sales, _) => sales.yearValue, //x-axis
        measureFn: (Sales sales, _) => sales.salesValue, //y-axis
        id: 'sales1',
      ),
    );

    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff109618)),
        data: lineSalesData2,
        domainFn: (Sales sales, _) => sales.yearValue, //x-axis
        measureFn: (Sales sales, _) => sales.salesValue, //y-axis
        id: 'sales2',
      ),
    );

    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xffff9900)),
        data: lineSalesData3,
        domainFn: (Sales sales, _) => sales.yearValue, //x-axis
        measureFn: (Sales sales, _) => sales.salesValue, //y-axis
        id: 'sales3',
      ),
    );
  }

  @override
  void initState(){
    super.initState();
    _seriesLineData= List<charts.Series<Sales, int>>();
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: TabBarView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text('Naslov grafa'),
                    Expanded(
                      child: charts.LineChart(
                        _seriesLineData,
                        animate: true,
                        animationDuration: Duration(seconds: 2),
                        defaultRenderer: charts.LineRendererConfig(
                          includeArea: true,
                          stacked: true,
                        ),
                        behaviors: [
                          charts.ChartTitle(
                            'Years',
                            behaviorPosition: charts.BehaviorPosition.bottom,
                            titleOutsideJustification: charts.OutsideJustification.middleDrawArea
                          ),
                          charts.ChartTitle(
                            'Sales',
                            behaviorPosition: charts.BehaviorPosition.start,
                            titleOutsideJustification: charts.OutsideJustification.middleDrawArea
                          ),
                          charts.ChartTitle(
                            'Department',
                            behaviorPosition: charts.BehaviorPosition.end,
                            titleOutsideJustification: charts.OutsideJustification.middleDrawArea
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Sales{
  int yearValue;
  int salesValue;

  Sales(this.yearValue, this.salesValue);
}*/
import 'dart:math';
import 'package:WEB_flutter/services/token.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:WEB_flutter/models/modelsViews/categoryStatistic.dart';
import 'package:WEB_flutter/models/modelsViews/userStatisticInfo.dart';
import 'package:WEB_flutter/services/APIServices.dart';

class Graf1 extends StatefulWidget {
  @override
  _Graf1State createState() => _Graf1State();
}

class _Graf1State extends State<Graf1> {

  List<charts.Series<ClassForGraph1, String>> _seriesPieData;
  
  _generateData(List<CategoryStatistic> data){
    List<ClassForGraph1> list = new List<ClassForGraph1>();
    int sum=0;
    List<Color> colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow
    ];

    for (var i = 0; i < data.length; i++) {
      sum+=data[i].postNumber;
    }

    for (var i = 0; i < data.length; i++) {
      ClassForGraph1 c = new ClassForGraph1(data[i].name, (((data[i].postNumber*100)/sum)*pow(10, 0)).round()/pow(10, 0) , colors[i]);
      list.add(c);
    }

    _seriesPieData.add(
      charts.Series(
        data: list,
        domainFn: (ClassForGraph1 item, _) => item.name,
        measureFn: (ClassForGraph1 item, _) => item.number,
        colorFn: (ClassForGraph1 item, _) => charts.ColorUtil.fromDartColor(item.color),
        id: 'Graf1',
        labelAccessorFn: (ClassForGraph1 item, _) => '${item.number}%',   //ovde se podesava sta nam se prikazuje inside/ouside grafa
      ),
    );

    // var pieData = [
    //   new Task('Task 1', 35.8, Color(0xff3366cc)),
    //   new Task('Task 2', 8.3, Color(0xff990099)),
    //   new Task('Task 3', 10.8, Color(0xff109618)),
    //   new Task('Task 4', 15.6, Color(0xfffdbe19)),
    //   new Task('Task 5', 19.2, Color(0xffff9900)),
    //   new Task('Task 6', 10.3, Color(0xffdc3912)),
    // ];

    // _seriesPieData.add(
    //   charts.Series(
    //     data: pieData,
    //     domainFn: (Task task, _) => task.task,
    //     measureFn: (Task task, _) => task.taskValue,
    //     colorFn: (Task task, _) => charts.ColorUtil.fromDartColor(task.colorValue),
    //     id: 'Graf Moj Grad',
    //     labelAccessorFn: (Task row, _) => '${row.taskValue}',   //ovde se podesava sta nam se prikazuje inside/ouside grafa
    //   ),
    // );
  }

  @override
  void initState(){
    super.initState();
    _seriesPieData= List<charts.Series<ClassForGraph1, String>>();
    //_generateData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 1,
        child: TabBarView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Center(child: Text('Procenat objava po kategorijama', style: TextStyle(fontSize: 20),)),
                    SizedBox(height: 30,),
                    FutureBuilder(
                      future: APIServices.getCategoryStatistic(Token.jwt),
                      builder: (BuildContext context, AsyncSnapshot<List<CategoryStatistic>> snapshot){
                        if(snapshot.hasData)
                        {
                          _generateData(snapshot.data);
                          return Expanded(
                            child: charts.PieChart(   //pita graf
                              _seriesPieData, //podaci
                              animate: true,  //graf ima animaciju
                              animationDuration: Duration(seconds: 2),  //animacija traje 4 sekundi
                              behaviors: [  //tackice sa bojama i nazivima
                                charts.DatumLegend(
                                  position: charts.BehaviorPosition.end,
                                  horizontalFirst: false,
                                  desiredMaxColumns: 1,
                                  //desiredMaxRows: 2,
                                  cellPadding: EdgeInsets.only(right: 4.0, bottom: 4.0),
                                  // entryTextStyle: charts.TextStyleSpec(
                                  //   color: charts.MaterialPalette.purple.shadeDefault,
                                  //   fontFamily: 'Georgia',
                                  //   fontSize: 11
                                  // )
                                )
                              ],
                              defaultRenderer: charts.ArcRendererConfig(  
                                //arcWidth: 100,  //radius kruga
                                arcRendererDecorators: [
                                  charts.ArcLabelDecorator(
                                    //labelPosition: charts.ArcLabelPosition.inside //brojke iz podataka ce se prikazati u grafu
                                    labelPosition: charts.ArcLabelPosition.inside,
                                  )
                                ]
                              ),
                            ),
                          );
                        }
                        else{
                          return Expanded(
                            child: Center(
                              child: SpinKitFadingCircle(
                                color: Color.fromRGBO(24, 74, 96, 1),
                                size: 50.0,
                              )
                            ),
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ClassForGraph1{
  String name;
  double number;
  Color color;

  ClassForGraph1(this.name, this.number, this.color);
}

class Graf2 extends StatefulWidget {
  @override
  _Graf2State createState() => _Graf2State();
}

class _Graf2State extends State<Graf2> {

  List<charts.Series<ClassForGraph2, String>> _seriesData;

  _generateData(List<CategoryStatistic> data){
    List<ClassForGraph2> list1 = new List<ClassForGraph2>();
    List<ClassForGraph2> list2 = new List<ClassForGraph2>();

    for(var i = 0; i<data.length; i++ ){
      ClassForGraph2 c1 = new ClassForGraph2(data[i].name, data[i].challengeNumber, Colors.red);
      list1.add(c1);

      ClassForGraph2 c2 = new ClassForGraph2(data[i].name, data[i].solutionNumber, Colors.green);
      list2.add(c2);
    } 

    _seriesData.add(
      charts.Series(
        data: list1,
        domainFn: (ClassForGraph2 item, _) => item.name.replaceFirst(' ', '\n'), //x-axis
        measureFn: (ClassForGraph2 item, _) => item.number, //y-axis
        id: 'Izazovi',
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        colorFn: (ClassForGraph2 item, _) => charts.ColorUtil.fromDartColor(item.color),
        fillColorFn: (ClassForGraph2 item, _) => charts.ColorUtil.fromDartColor(item.color),
      ),
    );

    // list = new List<ClassForGraph2>();
    // print(list.isEmpty);
    // for(var i = 0; i<data.length; i++ ){
    //   ClassForGraph2 c = new ClassForGraph2(data[i].name, data[i].solutionNumber);
    //   print(c.name);
    //   print(c.number);
    //   list.add(c);
    // } 

    _seriesData.add(
      charts.Series(
        data: list2,
        domainFn: (ClassForGraph2 item, _) => item.name.replaceFirst(' ', '\n'), //x-axis
        measureFn: (ClassForGraph2 item, _) => item.number, //y-axis
        id: 'Rešenja',
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        colorFn: (ClassForGraph2 item, _) => charts.ColorUtil.fromDartColor(item.color),
        fillColorFn: (ClassForGraph2 item, _) => charts.ColorUtil.fromDartColor(item.color),
      ),
    );


    // var data1 = [
    //   new Polution(1980, 'USA', 30),
    //   new Polution(1980, 'Asia', 40),
    //   new Polution(1980, 'Europe', 10)
    // ];

    // var data2 = [
    //   new Polution(1985, 'USA', 100),
    //   new Polution(1980, 'Asia', 150),
    //   new Polution(1985, 'Europe', 80)
    // ];
     
    // var data3 = [
    //   new Polution(1985, 'USA', 200),
    //   new Polution(1980, 'Asia', 300),
    //   new Polution(1985, 'Europe', 180)
    // ];

    // _seriesData.add(
    //   charts.Series(
    //     data: data1,
    //     domainFn: (Polution polution, _) => polution.place, //x-axis
    //     measureFn: (Polution polution, _) => polution.quantity, //y-axis
    //     id: '2017',
    //     fillPatternFn: (_, __) => charts.FillPatternType.solid,
    //     fillColorFn: (Polution polution, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
    //   ),
    // );

    // _seriesData.add(
    //   charts.Series(
    //     data: data2,
    //     domainFn: (Polution polution, _) => polution.place, //x-axis
    //     measureFn: (Polution polution, _) => polution.quantity, //y-axis
    //     id: '2018',
    //     fillPatternFn: (_, __) => charts.FillPatternType.solid,
    //     fillColorFn: (Polution polution, _) => charts.ColorUtil.fromDartColor(Color(0xff109618)),
    //   ),
    // );

    // _seriesData.add(
    //   charts.Series(
    //     data: data3,
    //     domainFn: (Polution polution, _) => polution.place, //x-axis
    //     measureFn: (Polution polution, _) => polution.quantity, //y-axis
    //     id: '2019',
    //     fillPatternFn: (_, __) => charts.FillPatternType.solid,
    //     fillColorFn: (Polution polution, _) => charts.ColorUtil.fromDartColor(Color(0xffff9900)),
    //   ),
    // );
  }

  @override
  void initState(){
    super.initState();
    _seriesData= List<charts.Series<ClassForGraph2, String>>();
    //_generateData();
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: TabBarView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text('Odnos broja izazova i rešenja po kategorijama', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, )),
                    SizedBox(height: 30,),
                    FutureBuilder(
                      future: APIServices.getCategoryStatistic(Token.jwt),
                      builder: (BuildContext context, AsyncSnapshot<List<CategoryStatistic>> snapshot){
                        if(!snapshot.hasData){
                          return Expanded(
                            child: Center(
                              child: SpinKitFadingCircle(
                                color: Color.fromRGBO(24, 74, 96, 1),
                                size: 50.0,
                              )
                            ),
                          );
                        }
                        else{
                          print('podaci su ${snapshot.data[1].postNumber}');
                          _generateData(snapshot.data);
                          return Expanded(
                            child: charts.BarChart(
                              _seriesData,
                              animate: true,
                              animationDuration: Duration(seconds: 2),
                              barGroupingType: charts.BarGroupingType.grouped,
                              behaviors: [
                                new charts.SeriesLegend(
                                  position: charts.BehaviorPosition.end,
                                  horizontalFirst: false,
                                  desiredMaxColumns: 1,
                                  cellPadding: EdgeInsets.only(right: 4.0, bottom: 4.0),
                                  // entryTextStyle: charts.TextStyleSpec(                                    
                                  //   fontSize: 15
                                  // )
                                )
                              ],
                            ),
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ClassForGraph2{
  String name;
  int number;
  Color color;

  ClassForGraph2(this.name, this.number, this.color);
}

class Graf3 extends StatefulWidget {
  @override
  _Graf3State createState() => _Graf3State();
}

class _Graf3State extends State<Graf3> {

  List<charts.Series<UserStatisticInfo, DateTime>> _seriesLineData;

  /*
  _generateData(){
    var lineSalesData1 = [
      new Sales(0,45),
      new Sales(1,56),
      new Sales(2,55),
      new Sales(3,60),
      new Sales(4,61),
      new Sales(5,70),
    ];

    var lineSalesData2 = [
      new Sales(0,35),
      new Sales(1,46),
      new Sales(2,45),
      new Sales(3,50),
      new Sales(4,51),
      new Sales(5,60),
    ];
     
    var lineSalesData3 = [
      new Sales(0,20),
      new Sales(1,24),
      new Sales(2,25),
      new Sales(3,40),
      new Sales(4,45),
      new Sales(5,60),
    ];

    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
        data: lineSalesData1,
        domainFn: (Sales sales, _) => sales.yearValue, //x-axis
        measureFn: (Sales sales, _) => sales.salesValue, //y-axis
        id: 'sales1',
      ),
    );

    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff109618)),
        data: lineSalesData2,
        domainFn: (Sales sales, _) => sales.yearValue, //x-axis
        measureFn: (Sales sales, _) => sales.salesValue, //y-axis
        id: 'sales2',
      ),
    );

    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xffff9900)),
        data: lineSalesData3,
        domainFn: (Sales sales, _) => sales.yearValue, //x-axis
        measureFn: (Sales sales, _) => sales.salesValue, //y-axis
        id: 'sales3',
      ),
    );
  }
  */

  DateTime currentDate = DateTime.now();

  int daysInMonth(DateTime date){
    var firstDayThisMonth = new DateTime(date.year, date.month, date.day);
    var firstDayNextMonth = new DateTime(firstDayThisMonth.year, firstDayThisMonth.month + 1, firstDayThisMonth.day);
    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }

  UserStatisticInfo userStatisticInfo;

  setUserStatisticInfo(UserStatisticInfo usi){
    userStatisticInfo=usi;
  }

  List<UserStatisticInfo> listOfStatisticData;

  _generateData(List<UserStatisticInfo> list){
    int daysInCurrentMonth = daysInMonth(currentDate);
    int dayNow = daysInCurrentMonth - currentDate.day;
    List<UserStatisticInfo> listOfStatisticData = new List<UserStatisticInfo>();

    for(int i = 1; i <= daysInCurrentMonth-dayNow; i++)
    {
      for(int j = 0; j < list.length; j++)
      {
        if(list[j].day == i){
          userStatisticInfo = list[j];
        }
      }
      DateTime date = DateTime(currentDate.year, currentDate.month, i);
      UserStatisticInfo t = UserStatisticInfo(userStatisticInfo.numberOfCitizens, 
                                              userStatisticInfo.numberOfInstitutions, 
                                              userStatisticInfo.cityID, 
                                              userStatisticInfo.cityName, 
                                              //userStatisticInfo.time, 
                                              date,
                                              i,
                                              userStatisticInfo.month, 
                                              userStatisticInfo.year, 
                                              userStatisticInfo.totalNumber);

      listOfStatisticData.add(t);
    }

    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xffff9900)),
        data: listOfStatisticData,
        domainFn: (UserStatisticInfo item, _) => item.time, //x-axis
        measureFn: (UserStatisticInfo item, _) => item.totalNumber, //y-axis
        id: 'totalNumberLine',
      ),
    );
  }

  @override
  void initState(){
    super.initState();
    _seriesLineData= List<charts.Series<UserStatisticInfo, DateTime>>();
    //_generateData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: TabBarView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text('Ukupan broj korisnika u tekućem mesecu', textAlign: TextAlign.center, style: TextStyle(fontSize: 20,)),
                    FutureBuilder(
                      future: APIServices.getUserStatistic(0, 1, currentDate.month-1, 0,Token.jwt),
                      builder: (BuildContext context, AsyncSnapshot<List<UserStatisticInfo>> snapshot1){
                        if(!snapshot1.hasData){
                          return Expanded(
                            child: Center(
                              child: SpinKitFadingCircle(
                                color: Color.fromRGBO(24, 74, 96, 1),
                                size: 50.0,
                              )
                            ),
                          );
                        }
                        else{
                          setUserStatisticInfo(snapshot1.data[snapshot1.data.length-1]);
                          return FutureBuilder(
                            future: APIServices.getUserStatistic(0, 1, currentDate.month, 0,Token.jwt),
                            builder: (BuildContext context, AsyncSnapshot<List<UserStatisticInfo>> snapshot2){
                              if(snapshot2.hasData){
                                _generateData(snapshot2.data);
                                return Expanded(
                                  child: charts.TimeSeriesChart(
                                    _seriesLineData,
                                    animate: true,
                                    animationDuration: Duration(seconds: 2),
                                    defaultRenderer: charts.LineRendererConfig(
                                      includeArea: true,
                                      stacked: true,
                                    ),
                                    behaviors: [
                                      charts.ChartTitle(
                                        'Dani u mesecu',
                                        behaviorPosition: charts.BehaviorPosition.bottom,
                                        titleOutsideJustification: charts.OutsideJustification.middleDrawArea
                                      ),
                                      charts.ChartTitle(
                                        'Broj korisnika',
                                        behaviorPosition: charts.BehaviorPosition.start,
                                        titleOutsideJustification: charts.OutsideJustification.middleDrawArea
                                      ),
                                    ],
                                  ),
                                );
                              }
                              else{
                                return Text('');
                              }
                            },
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Sales{
  int yearValue;
  int salesValue;

  Sales(this.yearValue, this.salesValue);
}