import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bantay_sarai/services/auth_service.dart';
import 'package:bantay_sarai/Animation/FadeAnimation.dart';

class FarmerLoginScreen extends StatefulWidget {
  @override
  _FarmerLoginScreenState createState() => _FarmerLoginScreenState();
}

class _FarmerLoginScreenState extends State<FarmerLoginScreen> {
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
          color: Colors.white
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
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
                  Center(
                    child: Container(
                        height: 150, child: Image(image: AssetImage('assets/images/farmer.png'))),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child:FadeAnimation(1.3, Text("FARMER LOG IN", style: TextStyle(color: Colors.lightGreen[700], fontSize: 30, fontWeight: FontWeight.bold),)),
                  )

                ],
              ),
            ),
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
