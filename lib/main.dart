import 'package:flutter/material.dart';
import 'package:bantay_sarai/Animation/FadeAnimation.dart';

import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("assets/images/rice_banner.jpg"), context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Bantay Sarai'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/rice_banner.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child:
        ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            children: <Widget>[
              const SizedBox(height: 140.0),
              Container(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text("BANTAY",
                    style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),

                ),

              ),
              Container(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text("SARAI",
                    style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),

                ),

              ),
              Text(
                "Bantay Sarai helps farmers to report their crop planting date, expected harvest date, expected yield, then later on actual yield.",
                style: TextStyle(color: Colors.white,),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 80.0),
              RaisedButton(
                child: const Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'OpenSans',
                  ),
                ),
                color: Colors.lightGreen[700],
                padding: EdgeInsets.all(10.0),
                elevation: 5.0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
              ),
              FlatButton(
                child: const Text(
                  "Already have an account? Log in",
                  style: TextStyle(color: Colors.white,decoration: TextDecoration.underline,),
                ),
                shape: const BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7.0)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              ),
//              const SizedBox(height: 40.0),
//              Column(
//                crossAxisAlignment: CrossAxisAlignment.center,
//                mainAxisSize: MainAxisSize.max,
//                mainAxisAlignment: MainAxisAlignment.end,
//                children: <Widget>[
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                      Image.asset(
//                        'assets/logos/sarai_logo.png',
//                        fit: BoxFit.contain,
//                        height:70,
//                      ),
//                      const SizedBox(width: 10.0),
//                      Image.asset(
//                        'assets/logos/dost-pcaarrd-uplb.png',
//                        fit: BoxFit.contain,
//                        height: 40,
//                      ),
//                    ],
//                  ),
//
//                  //your elements here
//                ],
//              )
            ],
        ),

      )
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration:
        BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.lightGreen[900],
                  Colors.lightGreen[800],
                  Colors.lightGreen[400]
                ]
            )
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
                  InkWell(
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onTap: () {Navigator.pop(context);},
                  ),
                  SizedBox(height: 20,),
                  FadeAnimation(1, Text("Login", style: TextStyle(color: Colors.white, fontSize: 40),)),
                  SizedBox(height: 10,),
                  FadeAnimation(1.3, Text("Welcome to Bantay SARAI!", style: TextStyle(color: Colors.white, fontSize: 18),)),
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
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: Colors.grey,
                                      ),
                                      hintText: "Email Address",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none
                                  ),
                                ),
                              ),
                              Container(
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
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                        SizedBox(height: 40,),
                        FadeAnimation(1.5, Text("Forgot Password?", style: TextStyle(color: Colors.grey),)),
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
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => HomeScreen()),
                                  (Route<dynamic> route) => false,
                            );
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
      ),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration:
        BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.lightGreen[900],
                  Colors.lightGreen[800],
                  Colors.lightGreen[400]
                ]
            )
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
                  InkWell(
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onTap: () {Navigator.pop(context);},
                  ),
                  SizedBox(height: 20,),
                  FadeAnimation(1, Text("Register", style: TextStyle(color: Colors.white, fontSize: 40),)),
                  SizedBox(height: 10,),
                  FadeAnimation(1.3, Text("Welcome to Bantay SARAI!", style: TextStyle(color: Colors.white, fontSize: 18),)),
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
                                        Icons.email,
                                        color: Colors.grey,
                                      ),
                                      hintText: "Email Address",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.account_circle,
                                        color: Colors.grey,
                                      ),
                                      hintText: "Full name",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.location_on,
                                        color: Colors.grey,
                                      ),
                                      hintText: "Location",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                ),
                                child: TextField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Colors.grey,
                                      ),
                                      suffixIcon: Icon(
                                        Icons.visibility,
                                        color: Colors.grey,
                                      ),
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
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
                              child: Text("Register", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            ),
                          ),
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => HomeScreen()),
                                  (Route<dynamic> route) => false,
                            );
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
      ),
    );
  }
}

//bottom nav

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedPos = 0;

  double bottomNavBarHeight = 60;

  List<TabItem> tabItems = List.of([
    new TabItem(Icons.home, "Home", Colors.lightGreen[700], labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.lightGreen[700])),
    new TabItem(Icons.cloud, "Forecast", Colors.lightGreen[700], labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.lightGreen[700])),
    new TabItem(Icons.location_on, "Map", Colors.lightGreen[700], labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.lightGreen[700])),
  ]);

  CircularBottomNavigationController _navigationController;

  @override
  void initState() {
    super.initState();
    _navigationController = new CircularBottomNavigationController(selectedPos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the Drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.green, Colors.blue])),
              accountEmail: Text('project.sarai.ph@gmail.com'), // Displays email of user
              accountName: Text('Project SARAI'),
              currentAccountPicture: CircleAvatar(
                child: Text(
                  'P', // Displays first letter of email
                  style: TextStyle(fontSize: 40.00),
                ),
              ),
            ),
            ListTile(
              title: Text('Manage Plantations'),
              trailing: Icon(Icons.collections_bookmark),
            ),
            ListTile(
              title: Text('About Us'),
              trailing: Icon(Icons.info),
            ),

            ListTile(
              title: Text('Log Out'),
              trailing: Icon(Icons.exit_to_app),
            ),

          ],
        ),
      ),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              'assets/logos/sarai.png',
              fit: BoxFit.contain,
            ),
            Expanded(child: Container(),),

            Image.asset(
              'assets/logos/dost-pcaarrd-uplb.png',
              fit: BoxFit.contain,
              height: 40,
            ),

          ],
        ),
        iconTheme: IconThemeData(color: Colors.green),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
        body: bodyContainer(),
//      body: Stack(
//        children: <Widget>[
//          Padding(child: bodyContainer(), padding: EdgeInsets.only(bottom: bottomNavBarHeight),),
//          Align(alignment: Alignment.bottomCenter, child: bottomNav())
//        ],
//      ),
      bottomNavigationBar: bottomNav(),
//      floatingActionButton: FloatingActionButton(
//        backgroundColor: Colors.blue,
//        child: Icon(Icons.add),
//      ),
    );
  }

  void addRecord() async {
    final String name = await _asyncInputDialog(context);
    print(name);
  }

  Future<String> _asyncInputDialog(BuildContext context) async {

    return showDialog<String>(
      context: context,
      barrierDismissible:
      false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return QuestionDialog();
      },
    );
  }

  Future<String> _addPlantation(BuildContext context) async {
    return showDialog<String>(
      context: context,
      barrierDismissible: false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Plantation'),
          content: Container(
              child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      TextField(
                        autofocus: true,
                        decoration: new InputDecoration(
                            labelText: 'Name of farmer'),
                      ),
                      TextField(
                        autofocus: true,
                        decoration: new InputDecoration(
                            labelText: 'Home Address'),
                      ),
                      TextField(
                        autofocus: true,
                        decoration: new InputDecoration(
                            labelText: 'Farm Location', hintText: 'coordinates if possible'),
                      ),
                      TextField(
                        autofocus: true,
                        decoration: new InputDecoration(
                            labelText: 'Land Ownership'),
                      ),
                      TextField(
                        autofocus: true,
                        decoration: new InputDecoration(
                            labelText: 'Farm size (ha)'),
                      ),
                    ],
                  )
              )
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel',
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Submit'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget bodyContainer() {
    Color selectedColor = tabItems[selectedPos].circleColor;
    String slogan;
    switch (selectedPos) {
      case 0:
        slogan = "Familly, Happiness, Food";
        break;
      case 1:
        slogan = "Find, Check, Use";
        break;
      case 2:
        slogan = "Receive, Review, Rip";
        break;
      case 3:
        slogan = "Noise, Panic, Ignore";
        break;
    }

//    return Container(
//        width: double.infinity,
//        height: double.infinity,
//        child: Center(
//          child: Text(
//            slogan,
//            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 20),
//          ),
//        ),
//      );
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        FadeAnimation(1, Text('Plantations', style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold, fontSize: 25),)),
                        SizedBox(width: 5,),
                        InkWell(
                          child: Text("view all",
                          style: TextStyle(color: Colors.grey[600], decoration: TextDecoration.underline,)),
                          onTap: () {print("haha");},
                        ),
                      ],
                    ),

                    SizedBox(height: 20,),
                    Container(
                      height: 50,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child:MaterialButton(
                              minWidth: 0,
                              onPressed: () {
                                _addPlantation(context);
                              },
                              elevation: 2.0,
                              color:Colors.blue,
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              shape: CircleBorder(),
                            ),
                          ),

                          FadeAnimation(1, makeCategory(isActive: true, title: 'Farm1')),
                          FadeAnimation(1.3, makeCategory(isActive: false, title: 'Farm2')),
                          FadeAnimation(1.4, makeCategory(isActive: false, title: 'Farm3')),
                          FadeAnimation(1.5, makeCategory(isActive: false, title: 'Farm4')),
                          FadeAnimation(1.6, makeCategory(isActive: false, title: 'Farm5')),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                  ]
                )
              ),
              FadeAnimation(1, Padding(
                padding: EdgeInsets.all(20),
                child: Text('Records', style: TextStyle(color: Colors.grey[700], fontSize: 20, fontWeight: FontWeight.bold),),
              )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal:20),
                child:RaisedButton(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Icon(
                          IconData(57669, fontFamily: 'MaterialIcons'),
                          color: Colors.white,
                        ),
                        const Text(
                          'Add Record',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                      ]),
                  color: Colors.lightGreen[700],
                  padding: EdgeInsets.all(10.0),
                  elevation: 5.0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  onPressed: () {
                    addRecord();
                  },
                ),
              ),



              SizedBox(height: 20,),

              Card(
                child: ListTile(
                  title: Text("Rice RC-14"),
                    subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("Land preparation date:"),
                      Text("Seedling preparation date:"),
                      Text("Planted/Transplanted date:"),
                      Text("Target date of harvest:"),
                      Text("Expected quantity of harvest (cavan):"),
                      Text("Target market:"),
                    ],
                    ))
              ),
              Card(
                  child: ListTile(
                      title: Text("Rice RC-14"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text("Land preparation date:"),
                          Text("Seedling preparation date:"),
                          Text("Planted/Transplanted date:"),
                          Text("Target date of harvest:"),
                          Text("Expected quantity of harvest (cavan):"),
                          Text("Target market:"),
                        ],
                      ))
              ),
              Card(
                  child: ListTile(
                      title: Text("Rice RC-14"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text("Land preparation date:"),
                          Text("Seedling preparation date:"),
                          Text("Planted/Transplanted date:"),
                          Text("Target date of harvest:"),
                          Text("Expected quantity of harvest (cavan):"),
                          Text("Target market:"),
                        ],
                      ))
              ),
            ]
        )
      );
  }

  Widget makeCategory({isActive, title}) {
    return AspectRatio(
      aspectRatio: isActive ? 3 : 2.5 / 1,
      child: Container(
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          //color: isActive ? Colors.lightGreen[700] : Colors.grey[200],
          gradient: isActive ? LinearGradient(colors: [Colors.green, Colors.blue]) : LinearGradient(colors: [Colors.grey[200], Colors.grey[200]]),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Align(
          child: Text(title, style: TextStyle(color: isActive ? Colors.white : Colors.black, fontSize: 18, fontWeight: isActive ? FontWeight.bold : FontWeight.w100),),
        ),
      ),
    );
  }

  Widget bottomNav() {
    return CircularBottomNavigation(
      tabItems,
      controller: _navigationController,
      barHeight: bottomNavBarHeight,
      barBackgroundColor: Colors.white,
      animationDuration: Duration(milliseconds: 300),
      selectedCallback: (int selectedPos) {
        setState(() {
          this.selectedPos = selectedPos;
          print(_navigationController.value);
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _navigationController.dispose();
  }
}


class QuestionDialog extends StatefulWidget {
  @override
  _QuestionDialogState createState() => _QuestionDialogState();
}

class _QuestionDialogState extends State<QuestionDialog> {
  int selectedRadio = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Choose between the two:",
        style: TextStyle(color: Colors.green),
      ),
      content: Container(
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RadioListTile(
                    value: 1,
                    groupValue: this.selectedRadio,
                    title: Text("Planting data monitoring"),
                    activeColor: Colors.green,
                    onChanged: (val){
                      setSelectedRadio(val);
                    },
                  ),
                  RadioListTile(
                      value: 2,
                      groupValue: this.selectedRadio,
                      title: Text("Harvesting data monitoring"),
                      activeColor: Colors.green,
                      onChanged: (val){
                        setSelectedRadio(val);
                      }
                  ),
                ]
            ),
          )
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel',
            style: TextStyle(color: Colors.grey),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('Next'),
          onPressed: () {
            Navigator.of(context).pop();
            _asyncInputDialog(context, this.selectedRadio);
          },
        ),
      ],
    );
  }

  setSelectedRadio(int val){
    setState(() {
      this.selectedRadio = val;
    });
  }

  Future<String> _asyncInputDialog(BuildContext context, int val) async {
    if(val == 1){
      return showDialog<String>(
        context: context,
        barrierDismissible: false, // dialog is dismissible with a tap on the barrier
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Planting data monitoring'),
            content: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    TextField(
                      autofocus: true,
                      decoration: new InputDecoration(
                          labelText: 'Variety', hintText: 'e.g. Rice RC-14'),
                    ),
                    TextField(
                      autofocus: true,
                      decoration: new InputDecoration(
                          labelText: 'Land preparation date'),
                    ),
                    TextField(
                      autofocus: true,
                      decoration: new InputDecoration(
                          labelText: 'Seedling preparation date'),
                    ),
                    TextField(
                      autofocus: true,
                      decoration: new InputDecoration(
                          labelText: 'Planted/Transplanted date'),
                    ),
                    TextField(
                      autofocus: true,
                      decoration: new InputDecoration(
                          labelText: 'Target date of harvest'),
                    ),
                    TextField(
                      autofocus: true,
                      decoration: new InputDecoration(
                          labelText: 'Expected quantity\nof harvest(cavan)'),
                    ),
                    TextField(
                      autofocus: true,
                      decoration: new InputDecoration(
                          labelText: 'Target market'),
                    ),
                  ],
                )
              )
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Submit'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    return showDialog<String>(
      context: context,
      barrierDismissible: false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Harvesting data monitoring'),
          content: Container(
              child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      TextField(
                        autofocus: true,
                        decoration: new InputDecoration(
                            labelText: 'Variety', hintText: 'e.g. Rice RC-14'),
                      ),
                      TextField(
                        autofocus: true,
                        decoration: new InputDecoration(
                            labelText: 'Date planted'),
                      ),
                      TextField(
                        autofocus: true,
                        decoration: new InputDecoration(
                            labelText: 'Date harvested'),
                      ),
                      TextField(
                        autofocus: true,
                        decoration: new InputDecoration(
                            labelText: 'Qty of harvest(cavan)'),
                      ),
                      TextField(
                        autofocus: true,
                        decoration: new InputDecoration(
                            labelText: 'Qty of harvest sold/\nto be sold(cavan)'),
                      ),
                      TextField(
                        autofocus: true,
                        decoration: new InputDecoration(
                            labelText: 'Kilo per cavan'),
                      ),
                      TextField(
                        autofocus: true,
                        decoration: new InputDecoration(
                            labelText: 'Gross income'),
                      ),
                      TextField(
                        autofocus: true,
                        decoration: new InputDecoration(
                            labelText: 'Net income'),
                      ),
                      TextField(
                        autofocus: true,
                        decoration: new InputDecoration(
                            labelText: 'Harvesting Procedure(Harvester/Manual)'),
                      ),
                    ],
                  )
              )
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Submit'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
