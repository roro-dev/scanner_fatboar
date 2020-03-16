import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scan FatBoar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyScanner(),
    );
  }
}

class MyScanner extends StatefulWidget
{
  MyScanner({Key key}) : super(key: key);

  @override
  _MyScannerState createState() =>  _MyScannerState();
}
  
class _MyScannerState extends State<MyScanner>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffE4993D),
        title: Text('Scanner Ticket'),
      ),
    );
  }
}