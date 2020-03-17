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

  String barcode;
  String errorMsg;

  @override
  void initState()
  {
    super.initState();
    this.barcode = null;
    this.errorMsg = null;
  }

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
                onPressed: () 
                {
                  scan();
                  if(this.barcode != null && this.errorMsg == null)
                  {
                    print('good');
                  } else {
                    print('bad');
                  }
                },
                child: const Text('SCAN QR CODE')
              ),
            ),
          ]
        )
      ),
    );
  }

  Future scan() async {
    String message = "Une erreur est survenue";
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() {
        this.barcode = barcode;
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        message = "Vous n'avez pas donner l'autorisation de caméra !";
      } else if(e.code == BarcodeScanner.UserCanceled) {
        message = "UserCanceled";
      } else {
        message += " $e";
      }
      setState(() {
        this.errorMsg = message;
      });
    } on FormatException{
      print('User returned using the "back"-button before scanning anything');
    } catch (e) {
      setState(() {
        this.errorMsg = message + " $e";
      });
    }
  }
}


