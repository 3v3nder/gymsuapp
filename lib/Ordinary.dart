import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:gymsuapp/GymCapacity.dart';

class Ordinary extends StatefulWidget {
  String? username;
  Ordinary({this.username});
  @override
  _OrdinaryState createState() => _OrdinaryState();
}

class _OrdinaryState extends State<Ordinary> {
  String _scanBarcode = 'Unknown';
  String result = 'Check';
  

  @override
  void initState() {
    super.initState();
    
  }

  



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(title: const Text('GYMSU')),
            drawer: Drawer(
     child: ListView(
       children: <Widget>[
         InkWell(
           onTap: (){
             sendUserToOrdinary();
           },
           child: ListTile(
             title: Text('Entrance Code'),
             leading: Icon(Icons.scanner),
           ),
         ),
         InkWell(
           onTap: (){
             sendUserToGymAttendance();
             },
           child: ListTile(
             title: Text('Gym Attendance'),
             leading: Icon(Icons.settings),
           ),
         ),
          ],
     ),
   ),
            body: Builder(builder: (BuildContext context) {
              return Container(
                  alignment: Alignment.center,
                  child: enableImage(),
                      );
            })));
  }

enableImage(){
     return Container(
       width: MediaQuery.of(context).size.width,
       height: MediaQuery.of(context).size.width,
       decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(5.0),
         
       ),
       child: Image.network('https://kachez067.pythonanywhere.com/QRCODE${widget.username}.png'
       ),


     );
  }

  sendUserToGymAttendance(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => GymCapacity(username: widget.username,)));
  }
sendUserToOrdinary(){
  Navigator.push(context, MaterialPageRoute(builder: (context) => Ordinary(username: widget.username,)));
}

}
