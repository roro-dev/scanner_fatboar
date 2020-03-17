import 'dart:async';

import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

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
        centerTitle: true,
        title: Text('Scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget> [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                splashColor: Colors.blueGrey,
                onPressed: scan,
                child: const Text('SCAN QR CODE')
              ),
            ),
          ]
        )
      ),
    );
  }
}

Future scan() async {
  try {
    String barcode = await BarcodeScanner.scan();
    print(barcode);
  } on PlatformException catch (e) {
    if (e.code == BarcodeScanner.CameraAccessDenied) {
      print('The user did not grant the camera permission!');
    } else {
      print('Unknown error: $e');
    }
  } on FormatException{
    print('null (User returned using the "back"-button before scanning anything. Result)');
  } catch (e) {
    print('Unknown error: $e');
  }
}
