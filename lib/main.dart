// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'dart:isolate';

import 'package:isolate/image_rotate.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Isolate Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const IsolateDemo(),
    );
  }
}

class IsolateDemo extends StatelessWidget{
  const IsolateDemo({Key? key}) : super(key: key);

    @override 
  Widget build(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const ImageRotate(),
        Center(
          child: Container(
            margin: const EdgeInsets.only(top:20),
            child: ElevatedButton(
              onPressed: (){
                sum().then((result)=>{
                  print(result)
                });
              },
              child: const Text('Click In Here 1'),
            ),
          ),
        ),
        Center(
          child: Container(
            margin: const EdgeInsets.only(top:20),
            child: ElevatedButton(
              onPressed: (){
                createNewIsolate();
              },
              child: const Text('Click In Here 2'),
            ),
          ),
        ),
      ],
    );
  }

  Future<int> sum() async{
    var total = 0;
    for(var i = 0 ; i < 1000000000;i++){
      total += i;
    }
    return total;
  }

  void createNewIsolate() async{
    // Main Isolate
    var receivePort = ReceivePort();
    const total = 1000000000;
    var newIsolate = await Isolate.spawn(taskRunner,[receivePort.sendPort,total]);
    receivePort.listen((message) {
      print(message);
    });
  }
  void taskRunner(List<dynamic> param){
    SendPort sendPort = param[0];
    var total = 0;
    for(var i = 0; i < param[1] ; i++){
      total+=i;
    }
    sendPort.send(total);
  }
}


