import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: timerApp(title: 'Timer'),
    );
  }
}

class timerApp extends StatefulWidget{

  final String title;
  timerApp({this.title});


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return timerAppState();
  }

}

class timerAppState extends State<timerApp>{

  bool isActive = false ;
  bool isReset = false;
  int secondPassed = 0;
  Timer timer;


  var second = 0;
  var min = 0;
  var hour = 0;

  var duration = new Duration(seconds: 1);
  @override
  Widget build(BuildContext context) {



    if(timer == null || isReset) {
      timer = Timer.periodic(duration, (Timer t) {
        if (isActive) {
          setState(() {
            secondPassed = secondPassed + 1;
            second = secondPassed % 60;
            min = (secondPassed / 60).floor();
            hour = (secondPassed / (60 * 60)).floor();
          });
        }
      });
    }


    // TODO: implement build
    return new Scaffold(

      appBar: _appBar(),
      body: _body(),
    );
  }

  Widget _appBar() {
    return new AppBar(
      title: new Text(widget.title),
    );
  }

  Widget _body() {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              customTextContainer(label : 'HRS' , value:hour.toString().padLeft(2,'0')),
              customTextContainer(label : 'MIN' , value:min.toString().padLeft(2,'0')),
              customTextContainer(label : 'SEC' , value:second.toString().padLeft(2,'0')),

            ],
          ),
          new Container(
            margin: EdgeInsets.only(top: 20),
            child: new Column(
              children: <Widget>[
                new RaisedButton(onPressed: (){
                  print(isActive);
                  setState(() {
                    isActive =! isActive;
                  });
                },
                    child: new Text(isActive ? 'STOP' :'START')
                ),
                new RaisedButton(onPressed: (){
                  print('reset pressed');

                  setState(() {
                    if(isActive){
                    isActive =! isActive;
                    }
                    secondPassed = 0;
                    second = 0;
                    min = 0;
                    hour = 0;

                  });
                },
                    child: new Text('RESET') ,
                ),

              ],
            )
          )
        ],
      ) ,
    );
  }

}

class customTextContainer extends StatelessWidget{

  final String label;
  final String value;
  customTextContainer({this.label,this.value});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: new BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10)
      ),
      child: new Column(
        children: <Widget>[
          new Text(value,style: new TextStyle(fontSize: 30,fontWeight:FontWeight.bold,color: Colors.white),),
          new Text(label,style: new TextStyle(fontWeight:FontWeight.bold,color: Colors.white),)
        ],
      ),
    );
  }

}