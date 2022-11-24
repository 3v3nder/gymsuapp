import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:gymsuapp/Ordinary.dart';
import 'dart:convert' as convert;

class GymCapacity extends StatefulWidget {
  String? username;
  GymCapacity({this.username});
  @override
  _GymCapacityState createState() => _GymCapacityState();
}

class _GymCapacityState extends State<GymCapacity> {
  int totalusers = 0;
  int occupancyLeft = 50;
  
  

  @override
  void initState() {
    super.initState();

  }

  Future<void> fetchresponces() async {
    String url = 'https://kachez067.pythonanywhere.com/activeuserrequest';
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      setState(() {
      totalusers = jsonResponse['activeCount'];
      occupancyLeft = jsonResponse['freeallocations'];
    });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    
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
                  child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        Text('Active Users : $totalusers\n',
                            style: const TextStyle(fontSize: 20)),
                            Text('Available Spaces : $occupancyLeft\n',
                            style: const TextStyle(fontSize: 20))
                      ]
                      )
                      );
            })));
  }


  sendUserToGymAttendance(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => GymCapacity(username: widget.username,)));
  }
sendUserToOrdinary(){
  Navigator.push(context, MaterialPageRoute(builder: (context) => Ordinary(username: widget.username,)));
}

}
