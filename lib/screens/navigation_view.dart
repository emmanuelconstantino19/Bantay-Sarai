import 'package:flutter/material.dart';
import 'package:bantay_sarai/services/auth_service.dart';
import 'package:bantay_sarai/screens/home_view.dart';
import 'package:bantay_sarai/screens/add_farm_view.dart';
import 'package:bantay_sarai/screens/other_apps.dart';
import 'package:bantay_sarai/screens/damage_reporting/damage_reporting.dart';
import 'package:bantay_sarai/screens/profile_view.dart';
import 'package:bantay_sarai/screens/farm_view.dart';
import 'package:bantay_sarai/models/Farm.dart';
import 'package:bantay_sarai/pages.dart';
import 'package:bantay_sarai/widgets/provider_widget.dart';
import 'package:bantay_sarai/models/User.dart';
import 'package:bantay_sarai/screens/sarai_alerts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bantay_sarai/screens/add_planting_data.dart';
import 'package:bantay_sarai/screens/add_harvesting_data.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FUser user = FUser("","","","","","","","");
  String contactNumber;
  int _currentIndex = 0;
  ExplorePage explore = ExplorePage(myLocation:null);
  List<Widget> _children;

  _HomeState() {
    _children = [
      explore,
      SaraiAlerts(),
      ProfileScreen(),
    ];
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    final newFarm = new Farm(null, null, null, null, null, null, null, null);
    return Scaffold(
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the Drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.symmetric(vertical:40.0, horizontal: 10.0),
          children: <Widget>[
            FutureBuilder(
            future: _getProfileData(),
            builder: (context, snapshot) {
//              return UserAccountsDrawerHeader(
//                decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.green, Colors.blue])),
//                //accountEmail: Text('project.sarai.ph@gmail.com'), // Displays email of user
//                accountName: Text(user.firstName + ' ' + user.middleName + ' ' + user.lastName),
//                accountEmail: Text('0917-***-****'),
//                currentAccountPicture: CircleAvatar(
//                  child: Text(
//                    user.firstName.substring(0,1), // Displays first letter of email
//                    style: TextStyle(fontSize: 40.00),
//                  ),
//                ),
//              );
                return ListTile(
                  leading: Icon(
                    Icons.account_circle,
                    color: Color(0xFF369d34),
                    size: 50.0,
                  ),
                  title: Text(user.firstName + ' ' + user.lastName, style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(contactNumber)
                );
            }
            ),
            SizedBox(height:25),
            ListTile(
              title: Text('FARMER PROFILE', style: TextStyle(color:Color(0xFF369d34),fontWeight:FontWeight.bold,fontSize: 18)),
              onTap: (){
                Navigator.pop(context);
                onTabTapped(2);
              },
            ),
            ListTile(
              title: Text('MGA FARMS', style: TextStyle(color:Color(0xFF369d34),fontWeight:FontWeight.bold,fontSize: 18)),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FarmView()),
                );
              },
            ),
            ListTile(
              title: Text('MGA CROPS', style: TextStyle(color:Color(0xFF369d34),fontWeight:FontWeight.bold,fontSize: 18)),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FarmView()),
                );
              },
            ),
            ListTile(
              title: Text('MGA RECORDS', style: TextStyle(color:Color(0xFF369d34),fontWeight:FontWeight.bold,fontSize: 18)),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FarmView()),
                );
              },
            ),
            ListTile(
              title: Text('DAMAGE REPORTING', style: TextStyle(color:Color(0xFF369d34),fontWeight:FontWeight.bold,fontSize: 18)),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DamageReporting()),
                );
//                showToast('Under construction', Colors.grey[700]);
              },
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text('MGA MAPA', style: TextStyle(color:Colors.black,fontWeight:FontWeight.bold,fontSize: 18)),
              onTap: (){
                Navigator.pop(context);
                onTabTapped(0);
              },
            ),
//            ListTile(
//              title: Text('MGA SETTINGS', style: TextStyle(color:Colors.black,fontWeight:FontWeight.bold,fontSize: 18)),
//              onTap: (){
//                showToast('Under construction', Colors.grey[700]);
//              },
//            ),
            ListTile(
              title: Text('IBANG SARAI APPS', style: TextStyle(color:Colors.black,fontWeight:FontWeight.bold,fontSize: 18)),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OtherApps()),
                );
              },
            ),
//            ListTile(
//              title: Text('Log Out'),
//              trailing: Icon(Icons.exit_to_app),
//              onTap: () async {
//                try {
//                  AuthService auth = Provider.of(context).auth;
//                  await auth.signOut();
//                  print("Signed Out!");
//                } catch (e) {
//                  print (e);
//                }
//              },
//            ),
            SizedBox(height:25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:40.0),
              child: SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Color(0xFF369d34))
                  ),
                  color: Color(0xFF369d34),
                  onPressed: () async {
                    try {
                      AuthService auth = Provider.of(context).auth;
                      await auth.signOut();
                      print("Signed Out!");
                    } catch (e) {
                      print (e);
                    }
                  },
                  textColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical:15.0),
                  child: Text('MAG-LOGOUT',style:TextStyle(fontSize:15)),
                ),
              ),
            ),
            SizedBox(height:20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:40.0),
              child: SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Color(0xFF369d34))
                  ),
                  color: Colors.white,
                  onPressed: () async {
                    await launch('https://sarai.ph/about-us');
                  },
                  textColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical:15.0),
                  child: Text('ABOUT PROJECT SARAI',style:TextStyle(fontSize:15,color:Color(0xFF369d34))),
                ),
              ),
            ),

          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF369d34)),
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              'assets/logos/bantay_sarai_header.png',
              fit: BoxFit.contain,
//              height: 30,
            width:110,
            ),
            Expanded(
              //child: Text('Bantay SARAI', style: TextStyle(color: Colors.white))
              child: Container(),
            ),
            Image.asset(
              'assets/logos/dost-pcaarrd-uplb.png',
              fit: BoxFit.contain,
              height: 30,
            ),

          ],
        ),
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.add),
//            onPressed: () {
////              Navigator.push(
////                context,
////                MaterialPageRoute(builder: (context) => NewTripLocationView(trip: newTrip,)),
////              );
//              Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => AddFarmView(farm: newFarm,)),
//              );
//            },
//          ),
//        ],
      ),
      body: _children[_currentIndex],
      floatingActionButton: Visibility(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SpeedDial(
              child: Icon(Icons.add),
              closedForegroundColor: Colors.white,
              openForegroundColor: Color(0xFF369d34),
              closedBackgroundColor: Color(0xFF369d34),
              openBackgroundColor: Colors.white,
              labelsStyle: TextStyle(fontSize: 18),
//          controller: /* Your custom animation controller goes here */,
              speedDialChildren: <SpeedDialChild>[
                SpeedDialChild(
                  child: Icon(Icons.grass),
                  foregroundColor: Colors.white,
                  backgroundColor:Color(0xFF369d34),
                  label: 'Magdagdag ng Farm',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FarmView()),
                    );
                  },
                  closeSpeedDialOnPressed: false,
                ),
                SpeedDialChild(
                  child: Icon(Icons.event_note),
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF369d34),
                  label: 'Magdagdag ng Record',
                  onPressed: () {
                    buildAddRecordDialog(context);
                  },
                ),
                //  Your other SpeeDialChildren go here.
              ],
            ),
            SizedBox(height:10),
            FloatingActionButton(
              onPressed: () async {
                var currentCoordinates = await _determinePosition();
                setState(() {
                  _children[0] = ExplorePage(myLocation: currentCoordinates);
                });
                // Add your onPressed code here!
              },
              child: const Icon(Icons.my_location),
              backgroundColor: Colors.white,
              foregroundColor: Colors.blue,
            ),
          ],
        ),
        visible: _currentIndex==0,
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text("Home"),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.cloud_circle),
              title: new Text("SARAI Alerts"),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.account_circle),
              title: new Text("Profile"),
            ),
          ]
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  _getProfileData() async {
    final uid = await Provider.of(context).auth.getCurrentUID();
    await Provider.of(context)
        .db
        .collection('userData')
        .document(uid)
        .get().then((result) {
      user.firstName = result['firstName'];
      user.lastName = result['lastName'];
      user.middleName = result['middleName'];
    });

    await Provider
        .of(context)
        .auth
        .getCurrentUser().then((result){
          contactNumber = result.phoneNumber;
    });
  }

  void showToast(message, Color color) {
    print(message);
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  buildAddRecordDialog(BuildContext context){
    return showDialog<String>(
      context: context,
      barrierDismissible: true, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState){
              return AlertDialog(
                //title: Text('Weather Forecast'),
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(8.0)),
                content: Container(
                    child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
//                            Align(
//                              alignment: Alignment(1, 0),
//                              child: InkWell(
//                                onTap: () {
//                                  Navigator.pop(context);
//                                },
//                                child: Container(
//                                  child: Icon(
//                                    Icons.close,
//                                    color: Colors.grey[300],
//                                  ),
//                                ),
//                              ),
//                            ),
//                            SizedBox(height: 10),
                            Center(
                              child: Text(
                                'Choose type of record',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal:20.0),
                              child: SizedBox(
                                width: double.infinity,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side: BorderSide(color: Colors.blue[600])
                                  ),
                                  color: Colors.blue[400],
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => AddPlantingData()),
                                    );
                                  },
                                  textColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical:15.0),
                                  child: Text('Planting data',style:TextStyle(fontSize:15)),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal:20.0),
                              child: SizedBox(
                                width: double.infinity,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side: BorderSide(color: Colors.green[600])
                                  ),
                                  color: Colors.green[400],
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => AddHarvestingData()),
                                    );
                                  },
                                  textColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical:15.0),
                                  child: Text('Harvesting data',style:TextStyle(fontSize:15)),
                                ),
                              ),
                            ),
                          ],
                        )
                    )
                ),
//                actions: <Widget>[
//                  FlatButton(
//                    child: Text('Close',
//                      style: TextStyle(color: Colors.grey),
//                    ),
//                    onPressed: () {
//                      Navigator.of(context).pop();
//                    },
//                  ),
//                ],
              );
            }
        );
      },
    );
  }
}
