import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:phoneauth2/screens/home_screen.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  String verificationId;

  bool showLoading = false;
  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if (authCredential?.user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });

      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  getMobileFormWidget(context) {
    return Container(

color: Colors.white,
      child: Center(
        child: Column(
//          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Spacer(),
            Center(
              child: Text('Please enter your mobile number',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 10),
            Center(
              child: new Text(
                'You’ll receive a 4 digit code to verify next.',
                style: TextStyle(color: Color.fromRGBO(106, 108, 123, 1)),
                maxLines: 2,
              ),
            ),
            SizedBox(height: 20),


            Container(
              margin: EdgeInsets.all(8),
              child: TextField(
                controller: phoneController,
                keyboardType: TextInputType.number,
                autofocus: true,
                style: TextStyle(
                  fontSize: 18,
//                    fontFamily: 'Montserrat'
                ),
                decoration: InputDecoration(
                  hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,fontFamily: 'Montserrat'),
                  hintText: 'Mobile Number',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
//
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,

                      width: 1,
                    ),
                  ),
                  prefixIcon:
                  Container(

                    padding: EdgeInsets.all(8.0),
                    child: Wrap(

crossAxisAlignment: WrapCrossAlignment.center,
                      children:[

                        new Image.asset(
                          "images/india 2.jpg",
                          height: 25,
                          width: 25,
                        ),
                        SizedBox(width: 16),
                        Text('+91',style: TextStyle(fontFamily: 'Montserrat',fontSize: 15),),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('-'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              padding: EdgeInsets.only(left:8.0,right:8.0),
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      setState(() {
                        showLoading = true;
                      });

                      await _auth.verifyPhoneNumber(
                        phoneNumber: "+91" + phoneController.text,
                        verificationCompleted: (phoneAuthCredential) async {
                          setState(() {
                            showLoading = false;
                          });
                          //signInWithPhoneAuthCredential(phoneAuthCredential);
                        },
                        verificationFailed: (verificationFailed) async {
                          setState(() {
                            showLoading = false;
                          });
                          _scaffoldKey.currentState.showSnackBar(
                              SnackBar(content: Text(verificationFailed.message)));
                        },
                        codeSent: (verificationId, resendingToken) async {
                          setState(() {
                            showLoading = false;
                            currentState =
                                MobileVerificationState.SHOW_OTP_FORM_STATE;
                            this.verificationId = verificationId;
                          });
                        },
                        codeAutoRetrievalTimeout: (verificationId) async {},
                      );
                    },
                    child: Text(
                      "CONTINUE",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17,fontFamily: 'Montserrat',fontWeight: FontWeight.w700),
                    ),
                    color: Color.fromRGBO(46, 59, 98, 1),
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new Image(
                  image: AssetImage('images/Group 3onlanguagepage.jpg'),
                  fit: BoxFit.fill,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  getOtpFormWidget(context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(

      children: [
        SizedBox(height: 20),

        SizedBox(height: 80),

        Center(
          child: Text('Verify Phone',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        ),
        SizedBox(height: 15),
        Center(child: Text('Code is sent to ${phoneController.text}'),),
        SizedBox(height: 50),
//        TextField(
//          controller: otpController,
//          decoration: InputDecoration(
//            hintText: "Enter OTP",
//          ),
//        ),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: screenWidth > 600 ? screenWidth * 0.2 : 16),
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              color: Colors.white,
              // ignore: prefer_const_literals_to_create_immutables
              boxShadow: [
                const BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
              borderRadius: BorderRadius.circular(16.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: screenWidth * 0.025),
                child: PinEntryTextField(
                  fields: 6,
                  onSubmit: (text) {
                    otpController.text = text as String;
                  },
                ),
              ),
              SizedBox(
                height: screenHeight * 0.04,
              ),
              GestureDetector(
                onTap: () async {
                  PhoneAuthCredential phoneAuthCredential =
                  PhoneAuthProvider.credential(
                      verificationId: verificationId,
                      smsCode: otpController.text);

                  signInWithPhoneAuthCredential(phoneAuthCredential);
                },
                child: Container(
                  margin: const EdgeInsets.all(8),
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(46, 59, 98, 1),

                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 20, bottom: 20),

                  child: const Text(
                    'Verify And Continue',

                    style: TextStyle(color: Colors.white, fontSize: 16.0,fontFamily: 'Montserrat',fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 16,
        ),
      Container(
 padding: EdgeInsets.only(left:30),       child:
      Center(
        
        child:      Row(
//        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('Didnt receive the code?'),
          SizedBox(width: 10,),
          FlatButton(
            onPressed: () async {
              setState(() {
                showLoading = true;
              });

              await _auth.verifyPhoneNumber(
                phoneNumber: "+91" + phoneController.text,
                verificationCompleted: (phoneAuthCredential) async {
                  setState(() {
                    showLoading = false;
                  });
                  //signInWithPhoneAuthCredential(phoneAuthCredential);
                },
                verificationFailed: (verificationFailed) async {
                  setState(() {
                    showLoading = false;
                  });
                  _scaffoldKey.currentState.showSnackBar(
                      SnackBar(content: Text(verificationFailed.message)));
                },
                codeSent: (verificationId, resendingToken) async {
                  setState(() {
                    showLoading = false;
                    currentState =
                        MobileVerificationState.SHOW_OTP_FORM_STATE;
                    this.verificationId = verificationId;
                  });
                },
                codeAutoRetrievalTimeout: (verificationId) async {},
              );
          },
            child: new Text('Resend Code', style: TextStyle(fontWeight: FontWeight.bold),), textColor: Color.fromRGBO(46, 59, 98, 1),
          ),

        ],
      ),),),
//        FlatButton(
//          onPressed: () async {
//            PhoneAuthCredential phoneAuthCredential =
//                PhoneAuthProvider.credential(
//                    verificationId: verificationId,
//                    smsCode: otpController.text);
//
//            signInWithPhoneAuthCredential(phoneAuthCredential);
//          },
//          child: Text("VERIFY"),
//          color: Colors.blue,
//          textColor: Colors.white,
//        ),
        Spacer(),
      ],
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
        key: _scaffoldKey,
        body: Container(
          child: showLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                  ? getMobileFormWidget(context)
                  : getOtpFormWidget(context),
          padding: const EdgeInsets.all(16),
        ));
  }
}
