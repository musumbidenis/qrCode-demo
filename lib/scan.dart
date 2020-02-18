import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';


class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {

  String barcode = "";

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Code Scanner'),
        centerTitle: true,
      ),
      body: Center(
        child: FloatingActionButton.extended(
          icon: Icon(Icons.camera_alt), 
          label: Text('Scan'),
          onPressed: scan,
        ),
      )
    );
  }

  Future scan() async{
    try{
      String barcode = await BarcodeScanner.scan();
      setState(() {
        this.barcode = barcode;
      });
    } on PlatformException catch(e){
      if(e.code == BarcodeScanner.CameraAccessDenied){
      setState(() {
        this.barcode = 'Camera permission not granted';
      });
    } else {
      setState(() {
        this.barcode = 'Unknown erro: e';
      });
     }    
    }on FormatException{
      setState(() {
        this.barcode = 'null (user returned using the "back"-button before scanning anything, Result)';
      print(barcode);
      });
    }catch (e){
      setState(() {
        this.barcode = 'Unknown error: e';
      });
    }
  }
}