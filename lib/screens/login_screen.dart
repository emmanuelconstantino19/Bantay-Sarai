import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bantay_sarai/services/auth_service.dart';
import 'package:bantay_sarai/Animation/FadeAnimation.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  final TextEditingController codeControl = new TextEditingController();
  final TextEditingController contactnumberControl = new TextEditingController();

  String phoneNo, verificationId, smsCode;

  bool codeSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration:
        BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/rice_banner.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 30,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
//                  InkWell(
//                    child: Icon(
//                      Icons.arrow_back,
//                      color: Colors.white,
//                    ),
//                    onTap: () {Navigator.pop(context);},
//                  ),
                  SizedBox(height: 20,),
                  FadeAnimation(1, Text("Bantay Sarai", style: TextStyle(color: Colors.white, fontSize: 40),)),
                  SizedBox(height: 10,),
                  FadeAnimation(1.3, Text("Phone Login", style: TextStyle(color: Colors.white, fontSize: 18),)),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 60,),
                        FadeAnimation(1.4, Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [BoxShadow(
                                  color: Color.fromRGBO(0,128,0, .3),
                                  blurRadius: 20,
                                  offset: Offset(0, 10)
                              )]
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.local_phone,
                                        color: Colors.grey,
                                      ),
                                      hintText: "Contact Number",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none
                                  ),
                                  controller: contactnumberControl,
                                ),
                              ),
                              codeSent ? Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Colors.grey,
                                      ),
                                      hintText: "OTP Code",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none
                                  ),
                                  controller: codeControl,
                                ),
                              ) : Container(),
                            ],
                          ),
                        )),
                        SizedBox(height: 40,),
//                        FadeAnimation(1.5, Text("Don't have an account? Register", style: TextStyle(color: Colors.grey),)),
//                        SizedBox(height: 40,),
                        FadeAnimation(1.6, InkWell(
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.lightGreen[700]
                            ),
                            child: Center(
                              child: Text(codeSent ? "Login" : "Verify", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            ),
                          ),
                          onTap: () {
                            codeSent ? AuthService().signInWithOTP(codeControl.text, verificationId):verifyPhone(contactnumberControl.text);
                          },
                        )
                        ),

                        SizedBox(height: 40,),
                        FadeAnimation(1.5, Text("© 2017-2021 - Project SARAI", style: TextStyle(color: Colors.grey),)),

                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}


//class LoginPage extends StatefulWidget {
//  @override
//  _LoginPageState createState() => _LoginPageState();
//}
//
//class _LoginPageState extends State<LoginPage> {
//  final formKey = new GlobalKey<FormState>();
//
//  final TextEditingController codeControl = new TextEditingController();
//  final TextEditingController contactnumberControl = new TextEditingController();
//
//  String phoneNo, verificationId, smsCode;
//
//  bool codeSent = false;
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Form(
//          key: formKey,
//          child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Padding(
//                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
//                  child: TextFormField(
//                    keyboardType: TextInputType.phone,
//                    decoration: InputDecoration(hintText: 'Enter phone number'),
//                    controller: contactnumberControl,
//                  )),
//              codeSent ? Padding(
//                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
//                  child: TextFormField(
//                    keyboardType: TextInputType.phone,
//                    decoration: InputDecoration(hintText: 'Enter OTP'),
//                    controller: codeControl,
//                  )) : Container(),
//              Padding(
//                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
//                  child: RaisedButton(
//                      child: Center(child: codeSent ? Text('Login'):Text('Verify')),
//                      onPressed: () {
//                        codeSent ? AuthService().signInWithOTP(codeControl.text, verificationId):verifyPhone(contactnumberControl.text);
//                      }))
//            ],
//          )),
//    );
//  }
//
//  Future<void> verifyPhone(phoneNo) async {
//    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
//      AuthService().signIn(authResult);
//    };
//
//    final PhoneVerificationFailed verificationfailed =
//        (AuthException authException) {
//      print('${authException.message}');
//    };
//
//    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
//      this.verificationId = verId;
//      setState(() {
//        this.codeSent = true;
//      });
//    };
//
//    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
//      this.verificationId = verId;
//    };
//
//    await FirebaseAuth.instance.verifyPhoneNumber(
//        phoneNumber: phoneNo,
//        timeout: const Duration(seconds: 5),
//        verificationCompleted: verified,
//        verificationFailed: verificationfailed,
//        codeSent: smsSent,
//        codeAutoRetrievalTimeout: autoTimeout);
//  }
//}