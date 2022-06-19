import 'package:flutter/foundation.dart';
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
                  // ignore: avoid_print
                  print('Defaut: $result')
                });
              },
              child: const Text('Default'),
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
              child: const Text('Isolate Spawn'),
            ),
          ),
        ),
        Center(
          child: Container(
            margin: const EdgeInsets.only(top:20),
            child: ElevatedButton(
              onPressed: (){
                demoCompute();
              },
              child: const Text('Compute'),
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
    Isolate.spawn(taskRunner,[receivePort.sendPort,total]);
    receivePort.listen((message) {
      // ignore: avoid_print
      print('Issolate Spawn: $message');
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

  void demoCompute() async{
    var result = await compute(calculate,1000000000);
    // ignore: avoid_print
    print('Compute: $result');
  }
  int calculate(int number){
     var total = 0;
    for(var i = 0; i < number ; i++){
      total+=i;
    }
    return total;
  }
}


