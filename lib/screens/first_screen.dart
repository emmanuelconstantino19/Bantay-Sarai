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
            SizedBox(height: 80,),
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
                    child: FadeAnimation(1, Text("BANTAY SARAI", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),)),
                  ),

                  SizedBox(height: 10,),
                  Center(
                    child: FadeAnimation(1.3, Text("A Project SARAI App", style: TextStyle(color: Colors.white, fontSize: 18, fontStyle: FontStyle.italic),)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 80),
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

                    FadeAnimation(1.6, InkWell(
                      child: Container(
                        height: 60,
                        margin: EdgeInsets.symmetric(horizontal: 50),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.lightGreen[700],
                            boxShadow: [
                                BoxShadow(
                                offset: const Offset(1.0, 1.0),
                                blurRadius: 5.0,
                              ),
                            ]
                        ),
                        child: Center(
                          child: Text("FARMER LOG IN", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        ),
                      ),
                      onTap: () {
//                        Navigator.push(
//                          context,
//                          MaterialPageRoute(builder: (context) => FarmerLoginScreen()),
//                        );
                        Navigator.of(context).pushReplacementNamed('/farmerLogIn');
                      },
                    )
                    ),

                    SizedBox(height: 30,),

                    FadeAnimation(1.6, InkWell(
                      child: Container(
                        height: 60,
                        margin: EdgeInsets.symmetric(horizontal: 50),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.lightBlue[700],
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(1.0, 1.0),
                                blurRadius: 5.0,
                              ),
                            ]
                        ),
                        child: Center(
                          child: Text("AGRICULTURE OFFICE LOG IN", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        ),
                      ),
                      onTap: () {

                      },
                    )
                    ),

                    SizedBox(height: 30,),

                    FadeAnimation(1.6, InkWell(
                      child: Container(
                        height: 60,
                        margin: EdgeInsets.symmetric(horizontal: 50),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.orangeAccent[400],
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(1.0, 1.0),
                                blurRadius: 5.0,
                              ),
                            ]
                        ),
                        child: Center(
                          child: Text("VIEW LATEST SARAI ALERTS", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
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
