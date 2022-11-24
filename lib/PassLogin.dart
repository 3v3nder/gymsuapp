import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'dart:convert' as convert;
import 'package:gymsuapp/Admin.dart';
import 'package:gymsuapp/Ordinary.dart';

class PassLogin extends StatefulWidget {
  

  @override
  _PassLoginState createState() => new _PassLoginState();
}

class _PassLoginState extends State<PassLogin> {


String ? _email,_password,_emailpassword;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  FocusNode? focusNode;

void initState(){
    super.initState();
 focusNode = FocusNode();
  }

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
void _submit(){
    final form = formKey.currentState!;

    if(form.validate()){
      form.save();
      print("Email: $_email Password: $_password");
      signIn(_email, _password);
    }
}
  Future<void> signIn(String? username, String? password) async {
    String res ;

    var url = 'https://kachez067.pythonanywhere.com/logincheck/${username}/${password}';
    var response = await http.get(Uri.parse(url));
    print(response.body);
    if (response.statusCode == 200) {

        var role = response.body;
        if (role == 'admin'){
            sendUserToAdmin();
        }
        else if(role == 'ordinary'){
          sendUserToOrdinary();
        }

        
      
    }
    else{
      res= 'error in internet connection';
      print(res);

    }

    
    

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    
    home: new Scaffold(
      body:ListView(
        children: <Widget>[

         Center(
           child: Text(
             'GYMSU',
             style: TextStyle(color: Colors.black,
               fontSize: 18,
               fontWeight: FontWeight.w800,),
           ),
         ),

          Padding(
            padding: EdgeInsets.all(16.0),

            child: Column(children: <Widget>[
              Form(
                key: formKey,
                child: Column(children: <Widget>[
                  createEmailTextFormField(),
                  createPasswordTextFormField(),
                ],),
              ),


              SizedBox(height: 15.0),
              /*
              Container(
                child: GestureDetector(
                  onTap:(){},
                  child: Center(
                    child: Text(
                      'DONT HAVE AN ACCOUNT, NEED NEW ACCOUNT:?  SLIDE RIGHT',
                      style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),

                    ),
                  ),
                ),
              ),

               */
              SizedBox(height: 25.0),

            InkWell(
              onTap: _submit,
              child: Container(
                  height: 30.0,
                  width: 95.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.blueAccent,
                    color: Colors.blueAccent,
                    elevation: 7.0,
                    child: GestureDetector(
                      onTap:_submit,
                      child: Center(
                        child: Text(
                          'LOGIN',
                          style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                  )),
            ),


              Padding(padding: EdgeInsets.only(top: 20.0)),

             

            ],),
          ),




        ],

      ),
    ),
  
    );
  }
  Column createEmailTextFormField(){          
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 13.0),

        ),
        TextFormField(
          keyboardType: TextInputType.text,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: "Username",
            hintStyle: TextStyle(color: Colors.grey),
              prefixIcon: InkWell(
                child: Text('NEXT'),
                onTap: (){

                },
              )
          ),
           validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  },
          onSaved: (String? val)=> _email=val,
          onFieldSubmitted: (val)=> FocusScope.of(context).requestFocus(focusNode),
        )
      ],
    );

  }
  Column createPasswordTextFormField(){
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 13.0),

        ),
        TextFormField(
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: "Password",
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.lightBlueAccent),

            ),
            hintStyle: TextStyle(color: Colors.grey),

          ),
          obscureText: true,
          validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  },
          onSaved: (val)=> _password=val,
          focusNode: focusNode,
        )

      ],
    );

  }

sendUserToAdmin(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => Admin()));
  }
sendUserToOrdinary(){
  Navigator.push(context, MaterialPageRoute(builder: ((context) => Ordinary(username: _email,))));
}
}

