import 'package:flutter/material.dart';
import 'package:bantay_sarai/Animation/FadeAnimation.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:bantay_sarai/screens/navigation_view.dart';
import 'package:bantay_sarai/services/auth_service.dart';
import 'package:bantay_sarai/widgets/provider_widget.dart';
import 'package:bantay_sarai/screens/login_screen.dart';
import 'package:bantay_sarai/screens/first_screen.dart';
import 'package:bantay_sarai/screens/farmer_login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      auth: AuthService(),
      db: Firestore.instance,
      child: MaterialApp(
        title: "Bantay Sarai",
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: HomeController(),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => HomeController(),
          '/farmerLogIn': (BuildContext context) => FarmerLoginScreen(),
        },
      ),
    );
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder<String>(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn ? Home() : FirstScreen();
        }
        return CircularProgressIndicator();
      },
    );
  }
}


//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//
//  final String title;
//
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  @override
//  Widget build(BuildContext context) {
//    // This method is rerun every time setState is called, for instance as done
//    // by the _incrementCounter method above.
//    //
//    // The Flutter framework has been optimized to make rerunning build methods
//    // fast, so that you can just rebuild anything that needs updating rather
//    // than having to individually change instances of widgets.
//    return Scaffold(
//      body: Container(
//        decoration: BoxDecoration(
//          image: DecorationImage(
//            image: AssetImage("assets/images/rice_banner.jpg"),
//            fit: BoxFit.cover,
//          ),
//        ),
//        child:
//        ListView(
//            padding: const EdgeInsets.symmetric(horizontal: 24.0),
//            children: <Widget>[
//              const SizedBox(height: 140.0),
//              Container(
//                child: FittedBox(
//                  fit: BoxFit.contain,
//                  child: Text("BANTAY",
//                    style: TextStyle(color: Colors.white,
//                        fontWeight: FontWeight.bold
//                    ),
//                  ),
//
//                ),
//
//              ),
//              Container(
//                child: FittedBox(
//                  fit: BoxFit.contain,
//                  child: Text("SARAI",
//                    style: TextStyle(color: Colors.white,
//                        fontWeight: FontWeight.bold
//                    ),
//                  ),
//
//                ),
//
//              ),
//              Text(
//                "A mobile application in collecting the crop production area of Philippine farms",
//                style: TextStyle(color: Colors.white,),
//                textAlign: TextAlign.center,
//              ),
//              const SizedBox(height: 80.0),
//              RaisedButton(
//                child: const Text(
//                  'Register',
//                  style: TextStyle(
//                    color: Colors.white,
//                    fontSize: 20,
//                    fontFamily: 'OpenSans',
//                  ),
//                ),
//                color: Colors.lightGreen[700],
//                padding: EdgeInsets.all(10.0),
//                elevation: 5.0,
//                shape: const RoundedRectangleBorder(
//                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
//                ),
//                onPressed: () {
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(builder: (context) => RegisterScreen()),
//                  );
//                },
//              ),
//              FlatButton(
//                child: const Text(
//                  "Already have an account? Log in",
//                  style: TextStyle(color: Colors.white,decoration: TextDecoration.underline,),
//                ),
//                shape: const BeveledRectangleBorder(
//                  borderRadius: BorderRadius.all(Radius.circular(7.0)),
//                ),
//                onPressed: () {
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(builder: (context) => LoginScreen()),
//                  );
//                },
//              ),
////              const SizedBox(height: 40.0),
////              Column(
////                crossAxisAlignment: CrossAxisAlignment.center,
////                mainAxisSize: MainAxisSize.max,
////                mainAxisAlignment: MainAxisAlignment.end,
////                children: <Widget>[
////                  Row(
////                    mainAxisAlignment: MainAxisAlignment.center,
////                    children: <Widget>[
////                      Image.asset(
////                        'assets/logos/sarai_logo.png',
////                        fit: BoxFit.contain,
////                        height:70,
////                      ),
////                      const SizedBox(width: 10.0),
////                      Image.asset(
////                        'assets/logos/dost-pcaarrd-uplb.png',
////                        fit: BoxFit.contain,
////                        height: 40,
////                      ),
////                    ],
////                  ),
////
////                  //your elements here
////                ],
////              )
//            ],
//        ),
//
//      )
//    );
//  }
//}
//
//class LoginScreen extends StatefulWidget {
//  @override
//  _LoginScreenState createState() => _LoginScreenState();
//}
//
//class _LoginScreenState extends State<LoginScreen> {
//  bool _obscureText = true;
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Container(
//        width: double.infinity,
//        decoration:
//        BoxDecoration(
//          image: DecorationImage(
//            image: AssetImage("assets/images/rice_banner.jpg"),
//            fit: BoxFit.cover,
//          ),
//        ),
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            SizedBox(height: 30,),
//            Padding(
//              padding: EdgeInsets.all(20),
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
//                  InkWell(
//                    child: Icon(
//                      Icons.arrow_back,
//                      color: Colors.white,
//                    ),
//                    onTap: () {Navigator.pop(context);},
//                  ),
//                  SizedBox(height: 20,),
//                  FadeAnimation(1, Text("Bantay Sarai", style: TextStyle(color: Colors.white, fontSize: 40),)),
//                  SizedBox(height: 10,),
//                  FadeAnimation(1.3, Text("Phone Login", style: TextStyle(color: Colors.white, fontSize: 18),)),
//                ],
//              ),
//            ),
//            SizedBox(height: 20),
//            Expanded(
//              child: Container(
//                decoration: BoxDecoration(
//                    color: Colors.white,
//                    borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
//                ),
//                child: SingleChildScrollView(
//                  child: Padding(
//                    padding: EdgeInsets.all(30),
//                    child: Column(
//                      children: <Widget>[
//                        SizedBox(height: 60,),
//                        FadeAnimation(1.4, Container(
//                          decoration: BoxDecoration(
//                              color: Colors.white,
//                              borderRadius: BorderRadius.circular(10),
//                              boxShadow: [BoxShadow(
//                                  color: Color.fromRGBO(0,128,0, .3),
//                                  blurRadius: 20,
//                                  offset: Offset(0, 10)
//                              )]
//                          ),
//                          child: Column(
//                            children: <Widget>[
//                              Container(
//                                padding: EdgeInsets.all(10),
//                                decoration: BoxDecoration(
//                                    border: Border(bottom: BorderSide(color: Colors.grey[200]))
//                                ),
//                                child: TextField(
//                                  decoration: InputDecoration(
//                                      prefixIcon: Icon(
//                                        Icons.local_phone,
//                                        color: Colors.grey,
//                                      ),
//                                      hintText: "Contact Number",
//                                      hintStyle: TextStyle(color: Colors.grey),
//                                      border: InputBorder.none
//                                  ),
//                                ),
//                              ),
//                            ],
//                          ),
//                        )),
//                        SizedBox(height: 40,),
//                        FadeAnimation(1.5, Text("Don't have an account? Register", style: TextStyle(color: Colors.grey),)),
//                        SizedBox(height: 40,),
//                        FadeAnimation(1.6, InkWell(
//                          child: Container(
//                            height: 50,
//                            margin: EdgeInsets.symmetric(horizontal: 50),
//                            decoration: BoxDecoration(
//                                borderRadius: BorderRadius.circular(50),
//                                color: Colors.lightGreen[700]
//                            ),
//                            child: Center(
//                              child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
//                            ),
//                          ),
//                          onTap: () {
//                            Navigator.pushAndRemoveUntil(
//                              context,
//                              MaterialPageRoute(builder: (context) => HomeScreen()),
//                                  (Route<dynamic> route) => false,
//                            );
//                          },
//                        )
//                        ),
//
//                      ],
//                    ),
//                  ),
//                ),
//              ),
//            )
//          ],
//        ),
//      ),
//    );
//  }
//}
//
//class RegisterScreen extends StatefulWidget {
//  @override
//  _RegisterScreenState createState() => _RegisterScreenState();
//}
//
//class _RegisterScreenState extends State<RegisterScreen> {
//  bool _obscureText = true;
//  bool checkBoxValue = false;
//  String birthplaceValue, sexValue, pwdValue;
//  final TextEditingController fnameControl = new TextEditingController();
//  final TextEditingController lnameControl = new TextEditingController();
//  final TextEditingController mnameControl = new TextEditingController();
//  final TextEditingController mshipControl = new TextEditingController();
//  final TextEditingController cnumControl = new TextEditingController();
//  final _formKey = GlobalKey<FormState>();
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Container(
//        width: double.infinity,
//        decoration:
//        BoxDecoration(
//          image: DecorationImage(
//            image: AssetImage("assets/images/rice_banner.jpg"),
//            fit: BoxFit.cover,
//          ),
////            gradient: LinearGradient(
////                begin: Alignment.topCenter,
////                colors: [
////                  Colors.lightGreen[900],
////                  Colors.lightGreen[800],
////                  Colors.lightGreen[400]
////                ]
////            )
//        ),
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            SizedBox(height: 30,),
//            Padding(
//              padding: EdgeInsets.all(20),
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
//                  InkWell(
//                    child: Icon(
//                      Icons.arrow_back,
//                      color: Colors.white,
//                    ),
//                    onTap: () {Navigator.pop(context);},
//                  ),
//                  SizedBox(height: 20,),
//                  FadeAnimation(1, Text("Register", style: TextStyle(color: Colors.white, fontSize: 40),)),
//                  SizedBox(height: 10,),
//                  FadeAnimation(1.3, Text("Welcome to Bantay SARAI!", style: TextStyle(color: Colors.white, fontSize: 18),)),
//                ],
//              ),
//            ),
//            SizedBox(height: 20),
//            Expanded(
//              child: Container(
//                padding: EdgeInsets.only(top:10),
//                decoration: BoxDecoration(
//                    color: Colors.white,
//                    borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
//                ),
//                child: SingleChildScrollView(
//                  child: Padding(
//                    padding: EdgeInsets.all(30),
//                    child: Form(
//                      key: _formKey,
//                      child: Column(
//                        children: <Widget>[
//                          FadeAnimation(1.4, Container(
//                            decoration: BoxDecoration(
//                                color: Colors.white,
//                                borderRadius: BorderRadius.circular(10),
//                                boxShadow: [BoxShadow(
//                                    color: Color.fromRGBO(0,128,0, .3),
//                                    blurRadius: 20,
//                                    offset: Offset(0, 10)
//                                )]
//                            ),
//                            child: Column(
//                              children: <Widget>[
//                                Container(
//                                  padding: EdgeInsets.all(10),
//                                  decoration: BoxDecoration(
//                                      border: Border(bottom: BorderSide(color: Colors.grey[200]))
//                                  ),
//                                  child: TextFormField(
//                                    validator: (val) => val.isEmpty ? 'Enter last name' : null,
//                                    decoration: InputDecoration(
//                                        hintText: "Last name",
//                                        hintStyle: TextStyle(color: Colors.grey),
//                                        border: InputBorder.none
//                                    ),
//                                    controller: lnameControl,
//                                  ),
//                                ),
//                                Container(
//                                  padding: EdgeInsets.all(10),
//                                  decoration: BoxDecoration(
//                                      border: Border(bottom: BorderSide(color: Colors.grey[200]))
//                                  ),
//                                  child: TextFormField(
//                                    validator: (val) => val.isEmpty ? 'Enter first name' : null,
//                                    decoration: InputDecoration(
//                                        hintText: "First name",
//                                        hintStyle: TextStyle(color: Colors.grey),
//                                        border: InputBorder.none
//                                    ),
//                                    controller: fnameControl,
//                                  ),
//                                ),
//                                Container(
//                                  padding: EdgeInsets.all(10),
//                                  decoration: BoxDecoration(
//                                      border: Border(bottom: BorderSide(color: Colors.grey[200]))
//                                  ),
//                                  child: TextFormField(
//                                    validator: (val) => val.isEmpty ? 'Enter middle name' : null,
//                                    decoration: InputDecoration(
//                                        hintText: "Middle name",
//                                        hintStyle: TextStyle(color: Colors.grey),
//                                        border: InputBorder.none
//                                    ),
//                                    controller: mnameControl,
//                                  ),
//                                ),
//                                Container(
//                                  padding: EdgeInsets.all(10),
//                                  decoration: BoxDecoration(
//                                      border: Border(bottom: BorderSide(color: Colors.grey[200]))
//                                  ),
//                                  child: DropdownButtonFormField<String>(
//                                    //isExpanded: true,
//                                    validator: (value) => value == null ? 'field required' : null,
//                                    value: birthplaceValue,
////                                    icon: Icon(Icons.arrow_drop_down),
////                                    iconSize: 24,
////                                    elevation: 16,
////                                    style: TextStyle(color: Colors.black),
//                                    onChanged: (String newValue) {
//                                      setState(() {
//                                        birthplaceValue = newValue;
//                                      });
//                                    },
//                                    hint: Text('Place of birth'),
//                                    items: <String>[
//                                      'Abra',
//                                      'Agusan del Norte',
//                                      'Agusan del Sur',
//                                      'Aklan',
//                                      'Albay',
//                                      'Antique',
//                                      'Apayao',
//                                      'Aurora',
//                                      'Basilan',
//                                      'Bataan',
//                                      'Batanes',
//                                      'Batangas',
//                                      'Benguet',
//                                      'Biliran',
//                                      'Bohol',
//                                      'Bukidnon',
//                                      'Bulacan',
//                                      'Cagayan',
//                                      'Camarines Norte',
//                                      'Camarines Sur',
//                                      'Camiguin',
//                                      'Capiz',
//                                      'Catanduanes',
//                                      'Cavite',
//                                      'Cebu',
//                                      'Compostela Valley',
//                                      'Davao del Norte',
//                                      'Davao del Sur',
//                                      'Davao Oriental',
//                                      'Dinagat Islands',
//                                      'Eastern Samar',
//                                      'Guimaras',
//                                      'Ifugao',
//                                      'Ilocos Norte',
//                                      'Ilocos Sur',
//                                      'Iloilo',
//                                      'Isabela',
//                                      'Kalinga',
//                                      'La Union',
//                                      'Laguna',
//                                      'Lanao del Norte',
//                                      'Lanao del Sur',
//                                      'Leyte',
//                                      'Maguindanao',
//                                      'Marinduque',
//                                      'Masbate',
//                                      'Metropolitan Manila',
//                                      'Misamis Occidental',
//                                      'Misamis Oriental',
//                                      'Mountain Province',
//                                      'Negros Occidental',
//                                      'Negros Oriental',
//                                      'North Cotabato',
//                                      'Northern Samar',
//                                      'Nueva Ecija',
//                                      'Nueva Vizcaya',
//                                      'Occidental Mindoro',
//                                      'Oriental Mindoro',
//                                      'Palawan',
//                                      'Pampanga',
//                                      'Pangasinan',
//                                      'Quezon',
//                                      'Quirino',
//                                      'Rizal',
//                                      'Romblon',
//                                      'Samar',
//                                      'Sarangani',
//                                      'Shariff Kabunsuan',
//                                      'Siquijor',
//                                      'Sorsogon',
//                                      'South Cotabato',
//                                      'Southern Leyte',
//                                      'Sultan Kudarat',
//                                      'Sulu',
//                                      'Surigao del Norte',
//                                      'Surigao del Sur',
//                                      'Tarlac',
//                                      'Tawi-tawi',
//                                      'Zambales',
//                                      'Zamboanga del Norte',
//                                      'Zamboanga del Sur',
//                                      'Zamboanga Sibugay'
//                                    ]
//                                        .map<DropdownMenuItem<String>>((String value) {
//                                      return DropdownMenuItem<String>(
//                                        value: value,
//                                        child: Text(value),
//                                      );
//                                    }).toList(),
//                                  ),
//                                ),
//                                Container(
//                                  padding: EdgeInsets.all(10),
//                                  decoration: BoxDecoration(
//                                      border: Border(bottom: BorderSide(color: Colors.grey[200]))
//                                  ),
//                                  child: DropdownButtonFormField<String>(
//                                    validator: (value) => value == null ? 'field required' : null,
//                                    //isExpanded: true,
//                                    value: sexValue,
////                                    icon: Icon(Icons.arrow_drop_down),
////                                    iconSize: 24,
////                                    elevation: 16,
////                                    style: TextStyle(color: Colors.black),
//                                    onChanged: (String newValue) {
//                                      setState(() {
//                                        sexValue = newValue;
//                                      });
//                                    },
//                                    hint: Text('Sex'),
//                                    items: <String>[
//                                      'Male',
//                                      'Female'
//                                    ]
//                                        .map<DropdownMenuItem<String>>((String value) {
//                                      return DropdownMenuItem<String>(
//                                        value: value,
//                                        child: Text(value),
//                                      );
//                                    }).toList(),
//                                  ),
//                                ),
//                                Container(
//                                  padding: EdgeInsets.all(10),
//                                  decoration: BoxDecoration(
//                                      border: Border(bottom: BorderSide(color: Colors.grey[200]))
//                                  ),
//                                  child: DropdownButtonFormField<String>(
//                                    validator: (value) => value == null ? 'field required' : null,
//                                    //isExpanded: true,
//                                    value: pwdValue,
////                                    icon: Icon(Icons.arrow_drop_down),
////                                    iconSize: 24,
////                                    elevation: 16,
////                                    style: TextStyle(color: Colors.black),
//                                    onChanged: (String newValue) {
//                                      setState(() {
//                                        pwdValue = newValue;
//                                      });
//                                    },
//                                    hint: Text('Person with Disability (PWD)'),
//                                    items: <String>[
//                                      'Yes',
//                                      'No'
//                                    ]
//                                        .map<DropdownMenuItem<String>>((String value) {
//                                      return DropdownMenuItem<String>(
//                                        value: value,
//                                        child: Text(value),
//                                      );
//                                    }).toList(),
//                                  ),
//                                ),
//                                Container(
//                                  padding: EdgeInsets.all(10),
//                                  decoration: BoxDecoration(
//                                      border: Border(bottom: BorderSide(color: Colors.grey[200]))
//                                  ),
//                                  child: TextFormField(
//                                    validator: (val) => val.isEmpty ? 'field required' : null,
//                                    decoration: InputDecoration(
//                                        hintText: "Membership",
//                                        hintStyle: TextStyle(color: Colors.grey),
//                                        border: InputBorder.none
//                                    ),
//                                    controller: mshipControl,
//                                  ),
//                                ),
//                                Container(
//                                  padding: EdgeInsets.all(10),
//                                  decoration: BoxDecoration(
//                                      border: Border(bottom: BorderSide(color: Colors.grey[200]))
//                                  ),
//                                  child: TextFormField(
//                                    validator: (val) => val.isEmpty ? 'field required' : null,
//                                    keyboardType: TextInputType.number,
//                                    decoration: InputDecoration(
//                                        hintText: "Contact Number",
//                                        hintStyle: TextStyle(color: Colors.grey),
//                                        border: InputBorder.none
//                                    ),
//                                    controller: cnumControl,
//                                  ),
//                                ),
////                              Container(
////                                padding: EdgeInsets.all(10),
////                                decoration: BoxDecoration(
////                                    border: Border(bottom: BorderSide(color: Colors.grey[200]))
////                                ),
////                                  child: Row(
////                                  children: <Widget>[
////                                    Checkbox(
////                                      value: checkBoxValue,
////                                      onChanged: (bool value){
////                                        print(value);
////                                        setState((){
////                                          checkBoxValue = value;
////                                        });
////                                      }
////                                    ),
////                                    Text("Enable Passcode")
////                                  ],
////                                )
////                              ),
////                              Visibility(
////                                visible: checkBoxValue,
////                                child: Container(
////                                  padding: EdgeInsets.all(10),
////                                  decoration: BoxDecoration(
////                                      border: Border(bottom: BorderSide(color: Colors.grey[200]))
////                                  ),
////                                  child: TextField(
////                                    obscureText: _obscureText,
////                                    decoration: InputDecoration(
////                                        prefixIcon: Icon(
////                                          Icons.lock,
////                                          color: Colors.grey,
////                                        ),
////                                        suffixIcon: GestureDetector(
////                                          onTap: () {
////                                            setState(() {
////                                              _obscureText = !_obscureText;
////                                            });
////                                          },
////                                          child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
////                                        ),
////                                        hintText: "Passcode",
////                                        hintStyle: TextStyle(color: Colors.grey),
////                                        border: InputBorder.none
////                                    ),
////                                  ),
////                                ),
////                              ),
//                              ],
//                            ),
//                          )),
//                          SizedBox(height: 40,),
//                          FadeAnimation(1.6, InkWell(
//                            child: Container(
//                              height: 50,
//                              margin: EdgeInsets.symmetric(horizontal: 50),
//                              decoration: BoxDecoration(
//                                  borderRadius: BorderRadius.circular(50),
//                                  color: Colors.lightGreen[700]
//                              ),
//                              child: Center(
//                                child: Text("Register", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
//                              ),
//                            ),
//                            onTap: () {
//                              if(_formKey.currentState.validate()){
//                                print(fnameControl.text);
//                                print(lnameControl.text);
//                                print(mnameControl.text);
//                                print(birthplaceValue);
//                                print(sexValue);
//                                print(pwdValue);
//                                print(mshipControl.text);
//                                print(cnumControl.text);
//                              }
//                              Navigator.pushAndRemoveUntil(
//                                context,
//                                MaterialPageRoute(builder: (context) => HomeScreen()),
//                                    (Route<dynamic> route) => false,
//                              );
//                            },
//                          )
//                          ),
//
//                        ],
//                      ),
//                    )
//                  ),
//                ),
//              ),
//            )
//          ],
//        ),
//      ),
//    );
//  }
//}
//
////bottom nav
//
//class HomeScreen extends StatefulWidget {
//  HomeScreen({Key key, this.title}) : super(key: key);
//  final String title;
//
//  @override
//  _HomeScreenState createState() => _HomeScreenState();
//}
//
//class _HomeScreenState extends State<HomeScreen> {
//  int selectedPos = 0;
//
//  double bottomNavBarHeight = 60;
//
//  List<TabItem> tabItems = List.of([
//    new TabItem(Icons.home, "Home", Color(0xFF76B53D), labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF76B53D))),
//    new TabItem(Icons.cloud, "Forecast", Color(0xFF76B53D), labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF76B53D))),
//    new TabItem(Icons.location_on, "Map", Color(0xFF76B53D), labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF76B53D))),
//  ]);
//
//  CircularBottomNavigationController _navigationController;
//
//  @override
//  void initState() {
//    super.initState();
//    _navigationController = new CircularBottomNavigationController(selectedPos);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      drawer: Drawer(
//        // Add a ListView to the drawer. This ensures the user can scroll
//        // through the options in the Drawer if there isn't enough vertical
//        // space to fit everything.
//        child: ListView(
//          // Important: Remove any padding from the ListView.
//          padding: EdgeInsets.zero,
//          children: <Widget>[
//            UserAccountsDrawerHeader(
//              decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.green, Colors.blue])),
//              //accountEmail: Text('project.sarai.ph@gmail.com'), // Displays email of user
//              accountName: Text('Project SARAI'),
//              currentAccountPicture: CircleAvatar(
//                child: Text(
//                  'P', // Displays first letter of email
//                  style: TextStyle(fontSize: 40.00),
//                ),
//              ),
//            ),
//            ListTile(
//              title: Text('Manage Farms'),
//              trailing: Icon(Icons.collections_bookmark),
//            ),
//            ListTile(
//              title: Text('About Us'),
//              trailing: Icon(Icons.info),
//            ),
//            ListTile(
//              title: Text('Enable Passcode'),
//              trailing: Icon(Icons.lock),
//            ),
//            ListTile(
//              title: Text('Log Out'),
//              trailing: Icon(Icons.exit_to_app),
//              onTap: () {
//                _showDialog();
//              },
//            ),
//
//          ],
//        ),
//      ),
//      appBar: AppBar(
//        title: Row(
//          mainAxisAlignment: MainAxisAlignment.start,
//          children: <Widget>[
//            Image.asset(
//              'assets/logos/sarai.png',
//              fit: BoxFit.contain,
//            ),
//            Expanded(child: Container(),),
//
//            Image.asset(
//              'assets/logos/dost-pcaarrd-uplb.png',
//              fit: BoxFit.contain,
//              height: 40,
//            ),
//
//          ],
//        ),
//        iconTheme: IconThemeData(color: Colors.green),
//        backgroundColor: Colors.white,
//        elevation: 1,
//      ),
//        body: bodyContainer(),
////      body: Stack(
////        children: <Widget>[
////          Padding(child: bodyContainer(), padding: EdgeInsets.only(bottom: bottomNavBarHeight),),
////          Align(alignment: Alignment.bottomCenter, child: bottomNav())
////        ],
////      ),
//      bottomNavigationBar: bottomNav(),
////      floatingActionButton: FloatingActionButton(
////        backgroundColor: Colors.blue,
////        child: Icon(Icons.add),
////      ),
//    );
//  }
//
//  void _showDialog() {
//    // flutter defined function
//    showDialog(
//      context: context,
//      builder: (BuildContext context) {
//        // return object of type Dialog
//        return AlertDialog(
//          title: new Text("Leaving so soon!"),
//          content: new Text("Are you sure you want to log-out of your account?"),
//          actions: <Widget>[
//            // usually buttons at the bottom of the dialog
//            new FlatButton(
//              child: new Text("Cancel"),
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//            ),
//            new FlatButton(
//              child: new Text("Log Out"),
//              onPressed: () {
//                Navigator.of(context).popUntil((route) => route.isFirst);
//                Navigator
//                    .of(context)
//                    .pushReplacement(MaterialPageRoute(builder: (BuildContext context) => MyHomePage()));
//              },
//            ),
//          ],
//        );
//      },
//    );
//  }
//
//  Future<String> _addPlantation(BuildContext context) async {
//    return showDialog<String>(
//      context: context,
//      barrierDismissible: false, // dialog is dismissible with a tap on the barrier
//      builder: (BuildContext context) {
//        return AlertDialog(
//          title: Text('Add Farm'),
//          content: Container(
//              child: SingleChildScrollView(
//                  child: Column(
//                    children: <Widget>[
//                      TextField(
//                        autofocus: true,
//                        decoration: new InputDecoration(
//                            labelText: 'Name of farmer'),
//                      ),
//                      TextField(
//                        autofocus: true,
//                        decoration: new InputDecoration(
//                            labelText: 'Home Address'),
//                      ),
//                      TextField(
//                        autofocus: true,
//                        decoration: new InputDecoration(
//                            labelText: 'Farm Location', hintText: 'coordinates if possible'),
//                      ),
//                      TextField(
//                        autofocus: true,
//                        decoration: new InputDecoration(
//                            labelText: 'Land Ownership'),
//                      ),
//                      TextField(
//                        autofocus: true,
//                        decoration: new InputDecoration(
//                            labelText: 'Farm size (ha)'),
//                      ),
//                    ],
//                  )
//              )
//          ),
//          actions: <Widget>[
//            FlatButton(
//              child: Text('Cancel',
//                style: TextStyle(color: Colors.grey),
//              ),
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//            ),
//            FlatButton(
//              child: Text('Submit'),
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//            ),
//          ],
//        );
//      },
//    );
//  }
//
//  Widget bodyContainer() {
//    Color selectedColor = tabItems[selectedPos].circleColor;
//    String slogan;
//    switch (selectedPos) {
//      case 0:
//        slogan = "Familly, Happiness, Food";
//        break;
//      case 1:
//        slogan = "Find, Check, Use";
//        break;
//      case 2:
//        slogan = "Receive, Review, Rip";
//        break;
//      case 3:
//        slogan = "Noise, Panic, Ignore";
//        break;
//    }
//
////    return Container(
////        width: double.infinity,
////        height: double.infinity,
////        child: Center(
////          child: Text(
////            slogan,
////            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 20),
////          ),
////        ),
////      );
//      return SingleChildScrollView(
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//            children: <Widget>[
//              Padding(
//                padding: EdgeInsets.symmetric(horizontal: 20.0),
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    SizedBox(height: 20,),
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      crossAxisAlignment: CrossAxisAlignment.baseline,
//                      textBaseline: TextBaseline.alphabetic,
//                      children: <Widget>[
//                        FadeAnimation(1, Text('Farms', style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold, fontSize: 25),)),
//                        SizedBox(width: 5,),
//                        InkWell(
//                          child: Text("View All",
//                          style: TextStyle(color: Colors.grey[600], decoration: TextDecoration.underline,)),
//                          onTap: () {print("haha");},
//                        ),
//                      ],
//                    ),
//
//                    SizedBox(height: 20,),
//                    Container(
//                      height: 50,
//                      child: ListView(
//                        scrollDirection: Axis.horizontal,
//                        children: <Widget>[
//                          Container(
//                            margin: EdgeInsets.only(right: 10),
//                            child:MaterialButton(
//                              minWidth: 0,
//                              onPressed: () {
//                                _addPlantation(context);
//                              },
//                              elevation: 2.0,
//                              color:Colors.blue,
//                              child: Icon(
//                                Icons.add,
//                                color: Colors.white,
//                              ),
//                              shape: CircleBorder(),
//                            ),
//                          ),
//
//                          FadeAnimation(1, makeCategory(isActive: true, title: 'Farm1')),
//                          FadeAnimation(1.3, makeCategory(isActive: false, title: 'Farm2')),
//                          FadeAnimation(1.4, makeCategory(isActive: false, title: 'Farm3')),
//                          FadeAnimation(1.5, makeCategory(isActive: false, title: 'Farm4')),
//                          FadeAnimation(1.6, makeCategory(isActive: false, title: 'Farm5')),
//                        ],
//                      ),
//                    ),
//                    SizedBox(height: 10,),
//                  ]
//                )
//              ),
//              FadeAnimation(1, Padding(
//                padding: EdgeInsets.all(20),
//                child:
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  crossAxisAlignment: CrossAxisAlignment.baseline,
//                  textBaseline: TextBaseline.alphabetic,
//                  children: <Widget>[
//                    Text('Records', style: TextStyle(color: Colors.grey[700], fontSize: 20, fontWeight: FontWeight.bold),),
//                    SizedBox(width: 5,),
//                    InkWell(
//                      child: Text("Filter",
//                          style: TextStyle(color: Colors.grey[600], decoration: TextDecoration.underline,)),
//                      onTap: () {print("haha");},
//                    ),
//                  ],
//                ),
//              )),
//              Center(
//                child: Text(
//                  'Actual Harvest',
//                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff5A6C64)),
//                )),
//              Container(
//                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 20.0),
//                  child: Center(
//                    child: DataTable(
//                      columns: [
//                        DataColumn(label: Text('')),
//                        DataColumn(label: Text('Variety')),
//                        DataColumn(label: Text('Quantity')),
//                      ],
//                      rows: [
//                        DataRow(cells: [
//                          DataCell(
//                            Checkbox(
//                                value: true,
//                                onChanged: (bool value){
//                                }
//                            ),
//                          ),
//                          DataCell(Text('RC-122')),
//                          DataCell(Text('4.7 ca')),
//                        ]),
//                        DataRow(cells: [
//                          DataCell(Text('Total')),
//                          DataCell(Text('')),
//                          DataCell(Text('4.7 ca')),
//                        ]),
//                      ],
//                    ),
//                  )
//              ),
//              Center(
//                  child: Text(
//                    'Expected Harvest',
//                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff5A6C64)),
//                  )),
//              Container(
//                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 20.0),
//                  child: Center(
//                    child: DataTable(
//                      columns: [
//                        DataColumn(label: Text('')),
//                        DataColumn(label: Text('Variety')),
//                        DataColumn(label: Text('Quantity')),
//                      ],
//                      rows: [
//                        DataRow(cells: [
//                          DataCell(
//                            Checkbox(
//                                value: true,
//                                onChanged: (bool value){
//                                }
//                            ),
//                          ),
//                          DataCell(Text('RC-14')),
//                          DataCell(Text('6.1 ca')),
//                        ]),
//                        DataRow(cells: [
//                          DataCell(Text('Total')),
//                          DataCell(Text('')),
//                          DataCell(Text('6.1 ca')),
//                        ]),
//                      ],
//                    ),
//                  )
//              ),
//              Padding(
//                padding: EdgeInsets.symmetric(horizontal:20),
//                child:RaisedButton(
//                  child: Row(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: const <Widget>[
//                        Icon(
//                          IconData(57669, fontFamily: 'MaterialIcons'),
//                          color: Colors.white,
//                        ),
//                        const Text(
//                          'Add Record',
//                          style: TextStyle(
//                            color: Colors.white,
//                            fontSize: 20,
//                            fontFamily: 'OpenSans',
//                          ),
//                        ),
//                      ]),
//                  color: Color(0xFF76B53D),
//                  padding: EdgeInsets.all(10.0),
//                  elevation: 5.0,
//                  shape: const RoundedRectangleBorder(
//                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
//                  ),
//                  onPressed: () {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) => AddRecordScreen()),
//                    );
//                  },
//                ),
//              ),
//
//
//
//              SizedBox(height: 20,),
//
//              Card(
//                  child: ListTile(
//                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                      title:
//                      Text(
//                        "RC-14",
//                        style: new TextStyle(fontWeight: FontWeight.w600,
//                                              color: Color(0xff5A6C64)
//                        ),
//                      ),
//                      subtitle: Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        children: <Widget>[
//                          SizedBox(height:2),
//                          Text(
//                            "Feb 15, '20",
//                            style: TextStyle(
//                                color: Colors.grey[500]),
//                          ),
//                          SizedBox(height:10),
//                          Row(
//                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                            children: <Widget>[
//                              Expanded(
//                                child: Container(
//                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//                                  decoration: BoxDecoration(
//                                      color: Color(0xffE9F4F9), borderRadius: BorderRadius.circular(8)),
//                                  child: Column(
//                                    crossAxisAlignment: CrossAxisAlignment.start,
//                                    children: [
//                                      Row(
//                                        children: [
//                                          Container(
//                                            padding: EdgeInsets.all(4),
//                                            decoration: BoxDecoration(
//                                                color: Color(0xffD5E6F2),
//                                                borderRadius: BorderRadius.circular(10)),
//                                            child: Icon(
//                                              Icons.event,
//                                              size: 15.0,
//                                              color: Color(
//                                                0xFF789FBB,
//                                              ),
//                                            ),
//                                          ),
//                                          SizedBox(
//                                            width: 8,
//                                          ),
//                                          Text(
//                                            "Planting",
//                                            textAlign: TextAlign.center,
//                                            style: TextStyle(
//                                                fontSize: 16,
//                                                fontWeight: FontWeight.w600,
//                                                color: Color(0xff5A6C64)),
//                                          ),
//                                        ],
//                                      ),
//                                      SizedBox(
//                                        height: 6,
//                                      ),
//                                      RichText(
//                                        text: TextSpan(
//                                          style: TextStyle(
//                                              fontSize: 14,
//                                              color: Color(0xff5A6C64)),
//                                          children: <TextSpan>[
//                                            TextSpan(text: 'Date: ', style: new TextStyle(fontWeight: FontWeight.bold)),
//                                            TextSpan(text: "Feb 14, '20"),
//                                          ],
//                                        ),
//                                      ),
//                                      SizedBox(
//                                        height: 6,
//                                      ),
//                                      RichText(
//                                        text: TextSpan(
//                                          style: TextStyle(
//                                              fontSize: 14,
//                                              color: Color(0xff5A6C64)),
//                                          children: <TextSpan>[
//                                            TextSpan(text: 'Expected: ', style: new TextStyle(fontWeight: FontWeight.bold)),
//                                            TextSpan(text: '6.1 ca'),
//                                          ],
//                                        ),
//                                      ),
//                                      Divider(height: 8.0),
//                                      Align(
//                                        alignment: Alignment.center,
//                                        child:Text(
//                                          "See details",
//                                          textAlign: TextAlign.center,
//                                          style: TextStyle(
//                                              fontSize: 14,
//                                              fontWeight: FontWeight.w600,
//                                              color: Color(0xff879D95)),
//                                        ),
//                                      ),
//
//                                    ],
//                                  ),
//                                ),
//                              ),
//                              SizedBox(width: 10),
//                              Expanded(
//                                child: Container(
//                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//                                  decoration: BoxDecoration(
//                                      color: Color(0xffEAFAF0), borderRadius: BorderRadius.circular(8)),
//                                  child: Column(
//                                    crossAxisAlignment: CrossAxisAlignment.start,
//                                    children: [
//                                      Row(
//                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                        children: [
//                                          Container(
//                                            child: Row(
//                                              children: <Widget>[
//                                                Container(
//                                                  padding: EdgeInsets.all(4),
//                                                  decoration: BoxDecoration(
//                                                      color: Color(0xffD5F4E6),
//                                                      borderRadius: BorderRadius.circular(10)),
//                                                  child: Icon(
//                                                    Icons.event_available,
//                                                    size: 15.0,
//                                                    color: Color(
//                                                      0xff79C4A2,
//                                                    ),
//                                                  ),
//                                                ),
//                                                SizedBox(
//                                                  width: 8,
//                                                ),
//                                                Text(
//                                                  "Harvesting",
//                                                  textAlign: TextAlign.center,
//                                                  style: TextStyle(
//                                                      fontSize: 16,
//                                                      fontWeight: FontWeight.w600,
//                                                      color: Color(0xff5A6C64)),
//                                                ),
//                                              ],
//                                            )
//                                          ),
//                                          Container(
//                                            padding: EdgeInsets.symmetric(horizontal: 6),
//                                            decoration: BoxDecoration(
//                                                color: Colors.red,
//                                                borderRadius: BorderRadius.circular(30)),
//                                            child: Text("!",
//                                                style: TextStyle(
//                                                  color: Colors.white,
//                                                  fontWeight: FontWeight.bold,
//                                                )
//                                            ),
//                                          ),
//                                        ],
//                                      ),
//
//                                      SizedBox(
//                                        height: 6,
//                                      ),
//                                      RichText(
//                                        text: TextSpan(
//                                          style: TextStyle(
//                                              fontSize: 14,
//                                              color: Color(0xff5A6C64)),
//                                          children: <TextSpan>[
//                                            TextSpan(text: 'Expected: ', style: new TextStyle(fontWeight: FontWeight.bold)),
//                                            TextSpan(text: "June 6, '20"),
//                                          ],
//                                        ),
//                                      ),
//                                      SizedBox(
//                                        height: 22,
//                                      ),
//                                      Divider(height: 8.0),
//                                      Align(
//                                        alignment: Alignment.center,
//                                        child:Text(
//                                          "Add entry",
//                                          textAlign: TextAlign.center,
//                                          style: TextStyle(
//                                              fontSize: 14,
//                                              fontWeight: FontWeight.w600,
//                                              color: Color(0xff879D95)),
//                                        ),
//                                      ),
//
//                                    ],
//                                  ),
//                                ),
//                              ),
//                            ],
//                          ),
//                        ],
//                      ))
//              ),
//              Card(
//                  child: ListTile(
//                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                      title:
//                      Text(
//                        "RC-122",
//                        style: new TextStyle(fontWeight: FontWeight.w600,
//                            color: Color(0xff5A6C64)
//                        ),
//                      ),
//                      subtitle: Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        children: <Widget>[
//                          SizedBox(height:2),
//                          Text(
//                            "Dec 7, '20",
//                            style: TextStyle(
//                                color: Colors.grey[500]),
//                          ),
//                          SizedBox(height:10),
//                          Row(
//                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                            children: <Widget>[
//                              Expanded(
//                                child: Container(
//                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//                                  decoration: BoxDecoration(
//                                      color: Color(0xffE9F4F9), borderRadius: BorderRadius.circular(8)),
//                                  child: Column(
//                                    crossAxisAlignment: CrossAxisAlignment.start,
//                                    children: [
//                                      Row(
//                                        children: [
//                                          Container(
//                                            padding: EdgeInsets.all(4),
//                                            decoration: BoxDecoration(
//                                                color: Color(0xffD5E6F2),
//                                                borderRadius: BorderRadius.circular(10)),
//                                            child: Icon(
//                                              Icons.event,
//                                              size: 15.0,
//                                              color: Color(
//                                                0xFF789FBB,
//                                              ),
//                                            ),
//                                          ),
//                                          SizedBox(
//                                            width: 8,
//                                          ),
//                                          Text(
//                                            "Planting",
//                                            textAlign: TextAlign.center,
//                                            style: TextStyle(
//                                                fontSize: 16,
//                                                fontWeight: FontWeight.w600,
//                                                color: Color(0xff5A6C64)),
//                                          ),
//                                        ],
//                                      ),
//                                      SizedBox(
//                                        height: 6,
//                                      ),
//                                      RichText(
//                                        text: TextSpan(
//                                          style: TextStyle(
//                                              fontSize: 14,
//                                              color: Color(0xff5A6C64)),
//                                          children: <TextSpan>[
//                                            TextSpan(text: 'Date: ', style: new TextStyle(fontWeight: FontWeight.bold)),
//                                            TextSpan(text: "Nov 23, '19"),
//                                          ],
//                                        ),
//                                      ),
//                                      SizedBox(
//                                        height: 6,
//                                      ),
//                                      RichText(
//                                        text: TextSpan(
//                                          style: TextStyle(
//                                              fontSize: 14,
//                                              color: Color(0xff5A6C64)),
//                                          children: <TextSpan>[
//                                            TextSpan(text: 'Expected: ', style: new TextStyle(fontWeight: FontWeight.bold)),
//                                            TextSpan(text: '4 ca'),
//                                          ],
//                                        ),
//                                      ),
//                                      Divider(height: 8.0),
//                                      Align(
//                                        alignment: Alignment.center,
//                                        child:Text(
//                                          "See details",
//                                          textAlign: TextAlign.center,
//                                          style: TextStyle(
//                                              fontSize: 14,
//                                              fontWeight: FontWeight.w600,
//                                              color: Color(0xff879D95)),
//                                        ),
//                                      ),
//
//                                    ],
//                                  ),
//                                ),
//                              ),
//                              SizedBox(width: 10),
//                              Expanded(
//                                child: Container(
//                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//                                  decoration: BoxDecoration(
//                                      color: Color(0xffEAFAF0), borderRadius: BorderRadius.circular(8)),
//                                  child: Column(
//                                    crossAxisAlignment: CrossAxisAlignment.start,
//                                    children: [
//                                      Row(
//                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                        children: [
//                                          Container(
//                                              child: Row(
//                                                children: <Widget>[
//                                                  Container(
//                                                    padding: EdgeInsets.all(4),
//                                                    decoration: BoxDecoration(
//                                                        color: Color(0xffD5F4E6),
//                                                        borderRadius: BorderRadius.circular(10)),
//                                                    child: Icon(
//                                                      Icons.event_available,
//                                                      size: 15.0,
//                                                      color: Color(
//                                                        0xff79C4A2,
//                                                      ),
//                                                    ),
//                                                  ),
//                                                  SizedBox(
//                                                    width: 8,
//                                                  ),
//                                                  Text(
//                                                    "Harvesting",
//                                                    textAlign: TextAlign.center,
//                                                    style: TextStyle(
//                                                        fontSize: 16,
//                                                        fontWeight: FontWeight.w600,
//                                                        color: Color(0xff5A6C64)),
//                                                  ),
//                                                ],
//                                              )
//                                          ),
//                                        ],
//                                      ),
//
//                                      SizedBox(
//                                        height: 6,
//                                      ),
//                                      RichText(
//                                        text: TextSpan(
//                                          style: TextStyle(
//                                              fontSize: 14,
//                                              color: Color(0xff5A6C64)),
//                                          children: <TextSpan>[
//                                            TextSpan(text: 'Date: ', style: new TextStyle(fontWeight: FontWeight.bold)),
//                                            TextSpan(text: "Mar 23, '20"),
//                                          ],
//                                        ),
//                                      ),
//                                      SizedBox(
//                                        height: 6,
//                                      ),
//                                      RichText(
//                                        text: TextSpan(
//                                          style: TextStyle(
//                                              fontSize: 14,
//                                              color: Color(0xff5A6C64)),
//                                          children: <TextSpan>[
//                                            TextSpan(text: 'Quantity: ', style: new TextStyle(fontWeight: FontWeight.bold)),
//                                            TextSpan(text: '4.7 ca'),
//                                          ],
//                                        ),
//                                      ),
//                                      Divider(height: 8.0),
//                                      Align(
//                                        alignment: Alignment.center,
//                                        child:Text(
//                                          "See details",
//                                          textAlign: TextAlign.center,
//                                          style: TextStyle(
//                                              fontSize: 14,
//                                              fontWeight: FontWeight.w600,
//                                              color: Color(0xff879D95)),
//                                        ),
//                                      ),
//
//                                    ],
//                                  ),
//                                ),
//                              ),
//                            ],
//                          ),
//                        ],
//                      ))
//              ),
//            ]
//        )
//      );
//  }
//
//  Widget makeCategory({isActive, title}) {
//    return AspectRatio(
//      aspectRatio: isActive ? 3 : 2.5 / 1,
//      child: Container(
//        margin: EdgeInsets.only(right: 10),
//        decoration: BoxDecoration(
//          //color: isActive ? Colors.lightGreen[700] : Colors.grey[200],
//          gradient: isActive ? LinearGradient(colors: [ Colors.green,Colors.blue]) : LinearGradient(colors: [Colors.grey[200], Colors.grey[200]]),
//          borderRadius: BorderRadius.circular(50),
//        ),
//        child: Align(
//          child: Text(title, style: TextStyle(color: isActive ? Colors.white : Colors.black, fontSize: 18, fontWeight: isActive ? FontWeight.bold : FontWeight.w100),),
//        ),
//      ),
//    );
//  }
//
//  Widget bottomNav() {
//    return CircularBottomNavigation(
//      tabItems,
//      controller: _navigationController,
//      barHeight: bottomNavBarHeight,
//      barBackgroundColor: Colors.white,
//      animationDuration: Duration(milliseconds: 300),
//      selectedCallback: (int selectedPos) {
//        setState(() {
//          this.selectedPos = selectedPos;
//          print(_navigationController.value);
//        });
//      },
//    );
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//    _navigationController.dispose();
//  }
//}
//
//class AddRecordHarvestingScreen extends StatefulWidget {
//  @override
//  _AddRecordHarvestingScreenState createState() => _AddRecordHarvestingScreenState();
//}
//
//class _AddRecordHarvestingScreenState extends State<AddRecordHarvestingScreen> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//          title: Text("Add a record"),
//          elevation: 1,
//        ),
//        body: SingleChildScrollView(
//            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
//            child: Column(
//              children: <Widget>[
//                Text(
//                  "Harvesting data monitoring",
//                  textAlign: TextAlign.center,
//                  style: TextStyle(
//                      fontWeight: FontWeight.bold,
//                      fontSize: 18,
//                      color: Color(0xff5A6C64)),
//                ),
//                TextField(
//                  autofocus: true,
//                  decoration: new InputDecoration(
//                      labelText: 'Date planted'),
//                ),
//                TextField(
//                  autofocus: true,
//                  decoration: new InputDecoration(
//                      labelText: 'Date harvested'),
//                ),
//                TextField(
//                  autofocus: true,
//                  decoration: new InputDecoration(
//                      labelText: 'Qty of harvest(cavan)'),
//                ),
//                TextField(
//                  autofocus: true,
//                  decoration: new InputDecoration(
//                      labelText: 'Qty of harvest sold/to be sold(cavan)'),
//                ),
//                TextField(
//                  autofocus: true,
//                  decoration: new InputDecoration(
//                      labelText: 'Kilo per cavan'),
//                ),
//                TextField(
//                  autofocus: true,
//                  decoration: new InputDecoration(
//                      labelText: 'Gross income'),
//                ),
//                TextField(
//                  autofocus: true,
//                  decoration: new InputDecoration(
//                      labelText: 'Net income'),
//                ),
//                TextField(
//                  autofocus: true,
//                  decoration: new InputDecoration(
//                      labelText: 'Harvesting Procedure(Harvester/Manual)'),
//                ),
//                SizedBox(height:10),
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.end,
//                  children: <Widget>[
//                    RaisedButton(
//                      child: const Text(
//                        'Skip',
//                        style: TextStyle(
//                          color: Colors.white,
//                          fontSize: 14,
//                          fontFamily: 'OpenSans',
//                        ),
//                      ),
//                      color: Colors.blueGrey,
//                      padding: EdgeInsets.all(10.0),
//                      elevation: 3.0,
//                      shape: const RoundedRectangleBorder(
//                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
//                      ),
//                      onPressed: () {
////                Navigator.push(
////                  context,
////                  MaterialPageRoute(builder: (context) => RegisterScreen()),
////                );
//                      },
//                    ),
//                    SizedBox(width:10),
//                    RaisedButton(
//                      child: const Text(
//                        'Submit',
//                        style: TextStyle(
//                          color: Colors.white,
//                          fontSize: 14,
//                          fontFamily: 'OpenSans',
//                        ),
//                      ),
//                      color: Colors.green,
//                      padding: EdgeInsets.all(10.0),
//                      elevation: 3.0,
//                      shape: const RoundedRectangleBorder(
//                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
//                      ),
//                      onPressed: () {
//                        Navigator.of(context).pop();
//                        Navigator.of(context).pop();
//                      },
//                    ),
//                  ],
//                ),
//
//              ],
//            )
//        )
//    );
//  }
//}
//
//
//class AddRecordScreen extends StatefulWidget {
//  @override
//  _AddRecordScreenState createState() => _AddRecordScreenState();
//}
//
//class _AddRecordScreenState extends State<AddRecordScreen> {
//
//  Future<DateTime> getDate() {
//    // Imagine that this function is
//    // more complex and slow.
//    return showDatePicker(
//      context: context,
//      initialDate: DateTime.now(),
//      firstDate: DateTime(2018),
//      lastDate: DateTime(2030),
//      builder: (BuildContext context, Widget child) {
//        return Theme(
//          data: ThemeData.light(),
//          child: child,
//        );
//      },
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("Add a record"),
//        elevation: 1,
//      ),
//      body: SingleChildScrollView(
//        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
//        child: Column(
//          children: <Widget>[
//            Text(
//              "Planting data monitoring",
//              textAlign: TextAlign.center,
//              style: TextStyle(
//                  fontWeight: FontWeight.bold,
//                  fontSize: 18,
//                  color: Color(0xff5A6C64)),
//            ),
//            TextField(
//              autofocus: true,
//              decoration: new InputDecoration(
//                  labelText: 'Variety', hintText: 'e.g. Rice RC-14'),
//            ),
//            TextField(
//              autofocus: true,
//              decoration: new InputDecoration(
//                  labelText: 'Land preparation date'),
//            ),
//            TextField(
//              autofocus: true,
//              decoration: new InputDecoration(
//                  labelText: 'Seedling preparation date'),
//            ),
//            TextField(
//              autofocus: true,
//              decoration: new InputDecoration(
//                  labelText: 'Planted/Transplanted date'),
//            ),
//            TextField(
//              autofocus: true,
//              decoration: new InputDecoration(
//                  labelText: 'Target date of harvest'),
//            ),
//            TextField(
//              autofocus: true,
//              decoration: new InputDecoration(
//                  labelText: 'Expected quantity of harvest(cavan)'),
//            ),
//            TextField(
//              autofocus: true,
//              decoration: new InputDecoration(
//                  labelText: 'Target market'),
//            ),
//            SizedBox(height:10),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.end,
//              children: <Widget>[
//                RaisedButton(
//                  child: const Text(
//                    'Skip',
//                    style: TextStyle(
//                      color: Colors.white,
//                      fontSize: 14,
//                      fontFamily: 'OpenSans',
//                    ),
//                  ),
//                  color: Colors.blueGrey,
//                  padding: EdgeInsets.all(10.0),
//                  elevation: 3.0,
//                  shape: const RoundedRectangleBorder(
//                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
//                  ),
//                  onPressed: () {
//                    getDate();
////                Navigator.push(
////                  context,
////                  MaterialPageRoute(builder: (context) => RegisterScreen()),
////                );
//                  },
//                ),
//                SizedBox(width:10),
//                RaisedButton(
//                  child: const Text(
//                    'Next',
//                    style: TextStyle(
//                      color: Colors.white,
//                      fontSize: 14,
//                      fontFamily: 'OpenSans',
//                    ),
//                  ),
//                  color: Colors.green,
//                  padding: EdgeInsets.all(10.0),
//                  elevation: 3.0,
//                  shape: const RoundedRectangleBorder(
//                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
//                  ),
//                  onPressed: () {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) => AddRecordHarvestingScreen()),
//                    );
//                  },
//                ),
//              ],
//            ),
//
//          ],
//        )
//      )
//    );
//  }
//}
