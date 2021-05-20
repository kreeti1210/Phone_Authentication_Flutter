import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:phoneauth2/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _radioValue = 0;
  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          break;
        case 1:
          break;

      }
    });
  }
  String shipperProfile = 'Shipper';
  String transporterProfile = 'Transporter';
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 150),
            child: Center(
              child: Text(
                'Please select your profile',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            padding: EdgeInsets.only(right: 20,left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(

                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),

                  ),
                  child: Row(

                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Radio(
                          value: 0,
                        groupValue: _radioValue,
                        onChanged: _handleRadioValueChange
                          ,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: new Image(
                          image: AssetImage('images/shipper_home.jpg'),
                          height: 30,
                          width: 30,
                        ),
                      ),
                      Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top:10,left: 12,bottom:5 ),
                              child: Flexible(
                                child: Text(
                                  'Shipper',
                                  style: TextStyle(
                                       fontSize: 17),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10,left: 12),
                              child: Flexible(
                                child: Text(
                                  'Lorem ipsum dolo dhfdsgfdshfdshfhdskhf', style: TextStyle(fontSize: 11,color: Color.fromRGBO(106,108,123,1)),
                                  overflow: TextOverflow.visible,
                                  
                                  maxLines: 2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                Container(


                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),

                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  mainAxisSize: MainAxisSize.max,

//                    crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new Radio(
                              value: 1,
                                groupValue: _radioValue,
                                onChanged: _handleRadioValueChange
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right:10),
                            child: new Image(
                              image: AssetImage('images/transporter_home.jpg'),
                              height: 30,
                              width: 30,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top:10,left: 12,bottom:5 ),
                                  child: Flexible(
                                    child: Text(
                                      'Transporter',
                                      style: TextStyle(

                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10,left: 12),
                                  child: Flexible(
                                    child: Text(
                                      'Lorembgchfgnghvmjmgsbdhdjkdk'
                                          'djkdncjdncdch',style: TextStyle(fontSize: 11,color: Color.fromRGBO(106,108,123,1)),
                                      overflow: TextOverflow.visible,

                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ), SizedBox(height: 30),
                FlatButton(
                  onPressed: ()
                  {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => HomeScreen()));

                  },

                  child: Text(
                    "CONTINUE",

                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18,fontFamily: 'Montserrat',fontWeight: FontWeight.w700),
                  ),
                  color: Color.fromRGBO(46, 59, 98, 1),
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _auth.signOut();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        },
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}
