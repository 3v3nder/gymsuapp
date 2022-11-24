import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  String _scanBarcode = 'Unknown';
  String result = 'Check';

  @override
  void initState() {
    super.initState();
  }

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      fetchresponce(barcodeScanRes);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
//barcode scanner flutter ant 
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  Future<void> fetchresponce(String url) async {

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      //var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      //var result = jsonResponse['result'];

      
      print(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    setState(() {
      result = response.body;
    });
  }
  
//barcode scanner flutter ant  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(title: const Text('GYMSU')),
            body: Builder(builder: (BuildContext context) {
              return Container(
                  alignment: Alignment.center,
                  child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                            onPressed: () => scanQR(),
                            child: const Text('QR scan')),

                        Text('Scan result : $_scanBarcode\n',
                            style: const TextStyle(fontSize: 20)),
                            Text('Check : $result\n',
                            style: const TextStyle(fontSize: 20))
                      ]
                      )
                      );
            })));
  }
}

//barcode scanner flutter ant 