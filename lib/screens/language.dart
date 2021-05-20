import 'dart:io';

import 'package:flutter/material.dart';
import 'package:phoneauth2/screens/home_screen.dart';
import 'package:phoneauth2/screens/login_screen.dart';
class LanguageScreen extends StatefulWidget {
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _chosenValue='English';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
          color: Colors.white,
        child: Center(
          child: new Column(


            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              Padding(
                padding: const EdgeInsets.only(top: 150),
                child: Center(
                child:Image(
                  image: AssetImage('images/image.jpg'),
                  height: 50,
                  width: 50,
                ),),
              ),
              SizedBox(height: 20),
              Center(child: Text('Please find new language',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),),
              SizedBox(height: 20),
              Center(child:Text(
                'You can change the language at any time.',
                style: TextStyle(color: Color.fromRGBO(106, 108, 123, 1),),textAlign: TextAlign.center,
                maxLines: 2,
              ),),
              SizedBox(height: 20),
             Padding(padding: new EdgeInsets.only(left:72.0,right:72.0),child: Center(

               child: Container(
                child: DropdownButton<String>(
                  isExpanded: true,
                  focusColor: Colors.white,
                  value: _chosenValue,

                  //elevation: 5,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  iconEnabledColor: Colors.black,
                  items: <String>[
                    'English',
                    'Others',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),

                  hint: Text(
                    "  ${_chosenValue}",

                    style: TextStyle(
                        color: Color.fromRGBO(47, 48, 55, 1),
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                  onChanged: (String value) {
                    setState(() {
                      _chosenValue = value;
                    });
                  },
                ),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 0.5,
                        style: BorderStyle.solid,
                        color: Colors.blueGrey),
                  ),
                ),
//
              ),),),
              SizedBox(height: 30,),
          Padding(padding: new EdgeInsets.only(left:72.0,right:72.0),child:
              FlatButton(
                onPressed: ()
                {
                Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginScreen()));

                },

                child: Text(
                  "NEXT",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17,fontFamily: 'Montserrat',fontWeight: FontWeight.w700),
                ),
                color: Color.fromRGBO(46, 59, 98, 1),
                padding: EdgeInsets.only(top: 15, bottom: 15),
                textColor: Colors.white,
              ),),
//              Color.fromRGBO(46, 59, 98, 1)
              Spacer(),
              new Image(
                image: AssetImage('images/greyvectorlang.jpg'),
                fit: BoxFit.fill,
              ),
          ],
          ),
        ),
      ),

    );
  }
}
