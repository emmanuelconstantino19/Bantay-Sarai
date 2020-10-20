import 'package:flutter/material.dart';
import 'package:bantay_sarai/Animation/FadeAnimation.dart';
import 'package:bantay_sarai/screens/farmer_login_screen.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
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
            Container(
              height: MediaQuery.of(context).size.height/2.5,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20,),
                    Center(
                      child: FadeAnimation(1, Text("BANTAY SARAI", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),)),
                    ),

                    SizedBox(height: 10,),
                    Center(
                      child: FadeAnimation(1.3, Text("A Project SARAI App", style: TextStyle(color: Colors.white, fontSize: 18, fontStyle: FontStyle.italic),)),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FadeAnimation(1.6, Container(
                      height: 60,
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      child: SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(color: Colors.lightGreen[700])
                          ),
                          color: Colors.lightGreen[700],
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed('/farmerLogIn');
                          },
                          textColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical:15.0),
                          child: Text('FARMER LOG IN',style:TextStyle(fontSize:15)),
                        ),
                      ),
                    ),
                    ),

                    SizedBox(height: 30,),

                    FadeAnimation(1.6, Container(
                      height: 60,
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      child: SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(color: Colors.lightBlue[700])
                          ),
                          color: Colors.lightBlue[700],
                          onPressed: () {
                            //Navigator.of(context).pushReplacementNamed('/farmerLogIn');
                          },
                          textColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical:15.0),
                          child: Text('AGRICULTURE OFFICE LOG IN',style:TextStyle(fontSize:15)),
                        ),
                      ),
                    ),
                    ),

                    SizedBox(height: 30,),

                    FadeAnimation(1.6, InkWell(
                      child: Container(
                        height: 60,
                        margin: EdgeInsets.symmetric(horizontal: 50),
                        child: SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                side: BorderSide(color: Colors.brown[400])
                            ),
                            color: Colors.brown[400],
                            onPressed: () {
                              //Navigator.of(context).pushReplacementNamed('/farmerLogIn');
                            },
                            textColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical:15.0),
                            child: Text('VIEW LATEST SARAI ALERTS',style:TextStyle(fontSize:15)),
                          ),
                        ),
                      ),
                      onTap: () {

                      },
                    )
                    ),

                    SizedBox(height: 40,),
                    FadeAnimation(1.5, Text("© 2017-2021 - Project SARAI", style: TextStyle(color: Colors.grey),)),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
