import 'package:flutter/material.dart';
import 'package:bantay_sarai/screens/farmer_login_screen.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Container(
          // we will give media query height
          // double.infinity make it big as my parent allows
          // while MediaQuery make it big as per the screen
          color:Colors.white,
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            // even space distribution
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/logos/bantay_sarai_header.png")
                    )
                ),
              ),

              Column(
                children: <Widget>[
                  // the login button
                  // MaterialButton(
                  //   minWidth: double.infinity,
                  //   height: 60,
                  //   onPressed: () {
                  //     //Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));

                  //   },
                  //   // defining the shape
                  //   shape: RoundedRectangleBorder(
                  //     side: BorderSide(
                  //       color: Colors.black
                  //     ),
                  //     borderRadius: BorderRadius.circular(50)
                  //   ),
                  //   child: Text(
                  //     "Login",
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.w600,
                  //       fontSize: 18
                  //     ),
                  //   ),
                  // ),
                  // creating the signup button
                  // SizedBox(height:20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 50,
                      onPressed: (){
                        Navigator.of(context).pushReplacementNamed('/farmerLogIn');
                      },
                      color: Color(0xFF369d34),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height:20),
                  Text('© 2021 - Project SARAI')

                ],
              )



            ],
          ),
        ),
      ),
    );

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
                      child: Text("BANTAY SARAI", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
                    ),

                    SizedBox(height: 10,),
                    Center(
                      child: Text("A Project SARAI App", style: TextStyle(color: Colors.white, fontSize: 18, fontStyle: FontStyle.italic),),
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
                    Container(
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


                    SizedBox(height: 30,),

                    Container(
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


                    SizedBox(height: 30,),

                    InkWell(
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
                    ),


                    SizedBox(height: 40,),
                    Text("© 2017-2021 - Project SARAI", style: TextStyle(color: Colors.grey),),

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
