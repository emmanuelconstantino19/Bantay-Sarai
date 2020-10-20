import 'package:flutter/material.dart';
import 'package:bantay_sarai/services/auth_service.dart';
import 'package:bantay_sarai/screens/home_view.dart';
import 'package:bantay_sarai/screens/add_farm_view.dart';
import 'package:bantay_sarai/screens/profile_view.dart';
import 'package:bantay_sarai/models/Farm.dart';
import 'package:bantay_sarai/pages.dart';
import 'package:bantay_sarai/widgets/provider_widget.dart';
import 'package:bantay_sarai/models/User.dart';
import 'package:bantay_sarai/screens/sarai_alerts.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User user = User("","","","","","","","");
  int _currentIndex = 0;
  final List<Widget> _children = [
    ExplorePage(),
    SaraiAlerts(),
    ProfileScreen(),
  ];

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
                    color: Colors.lightGreen[700],
                    size: 50.0,
                  ),
                  title: Text(user.firstName + ' ' + user.lastName, style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('0916-***-****')
                );
            }
            ),
            SizedBox(height:25),
            ListTile(
              title: Text('FARMER PROFILE', style: TextStyle(color:Colors.green[700],fontWeight:FontWeight.bold,fontSize: 18)),
              onTap: (){
                onTabTapped(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('MGA FARMS', style: TextStyle(color:Colors.green[700],fontWeight:FontWeight.bold,fontSize: 18)),
            ),
            ListTile(
              title: Text('MGA CROPS', style: TextStyle(color:Colors.green[700],fontWeight:FontWeight.bold,fontSize: 18)),
            ),
            ListTile(
              title: Text('MGA RECORDS', style: TextStyle(color:Colors.green[700],fontWeight:FontWeight.bold,fontSize: 18)),
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text('MGA MAPA', style: TextStyle(color:Colors.black,fontWeight:FontWeight.bold,fontSize: 18)),
            ),
            ListTile(
              title: Text('MGA SETTINGS', style: TextStyle(color:Colors.black,fontWeight:FontWeight.bold,fontSize: 18
              )),
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
                      side: BorderSide(color: Colors.lightGreen[700])
                  ),
                  color: Colors.lightGreen[700],
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
                      side: BorderSide(color: Colors.lightGreen[700])
                  ),
                  color: Colors.white,
                  onPressed: () {
                  },
                  textColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical:15.0),
                  child: Text('ABOUT BANTAY SARAI',style:TextStyle(fontSize:15,color:Colors.lightGreen[700])),
                ),
              ),
            ),

          ],
        ),
      ),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Text('Bantay SARAI', style: TextStyle(color: Colors.white))
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
      user.firstName = result.data['firstName'];
      user.lastName = result.data['lastName'];
      user.middleName = result.data['middleName'];
    });
  }
}
