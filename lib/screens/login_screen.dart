import 'package:flutter/material.dart';
import 'package:bantay_sarai/Animation/FadeAnimation.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController contactNumberControl = new TextEditingController();
  String phoneNo;

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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 30,),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onTap: () {Navigator.pop(context);},
                    ),
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
                                  child: TextFormField(
                                    validator: (val) => val.isEmpty ? 'field required' : null,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.local_phone,
                                          color: Colors.grey,
                                        ),
                                        hintText: "Contact Number",
                                        hintStyle: TextStyle(color: Colors.grey),
                                        border: InputBorder.none
                                    ),
                                    controller: contactNumberControl,
                                  ),
                                ),
                              ],
                            ),
                          )),
                          SizedBox(height: 40,),
                          FadeAnimation(1.5, Text("Don't have an account? Register", style: TextStyle(color: Colors.grey),)),
                          SizedBox(height: 40,),
                          FadeAnimation(1.6, InkWell(
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.lightGreen[700]
                              ),
                              child: Center(
                                child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                              ),
                            ),
                            onTap: () {
//                            Navigator.pushAndRemoveUntil(
//                              context,
//                              MaterialPageRoute(builder: (context) => HomeScreen()),
//                                  (Route<dynamic> route) => false,
//                            );
                              print(contactNumberControl.text);
                            },
                          )
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }

  Future<void> verifyPhone(phoneNo) async{
  }
}