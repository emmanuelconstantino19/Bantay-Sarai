import 'package:flutter/material.dart';
import 'package:bantay_sarai/services/auth_service.dart';
import 'package:bantay_sarai/screens/home_view.dart';
import 'package:bantay_sarai/screens/add_farm_view.dart';
import 'package:bantay_sarai/screens/profile_view.dart';
import 'package:bantay_sarai/models/Farm.dart';
import 'package:bantay_sarai/pages.dart';
import 'package:bantay_sarai/widgets/provider_widget.dart';
import 'package:bantay_sarai/models/User.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User user = User("","","","","","","","");
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeView(),
    ExplorePage(),
    ProfileView(),
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
          padding: EdgeInsets.zero,
          children: <Widget>[
            FutureBuilder(
            future: _getProfileData(),
            builder: (context, snapshot) {
              return UserAccountsDrawerHeader(
                decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.green, Colors.blue])),
                //accountEmail: Text('project.sarai.ph@gmail.com'), // Displays email of user
                accountName: Text(user.firstName + ' ' + user.middleName + ' ' + user.lastName),
                currentAccountPicture: CircleAvatar(
                  child: Text(
                    user.firstName.substring(0,1), // Displays first letter of email
                    style: TextStyle(fontSize: 40.00),
                  ),
                ),
              );
            }
            ),
            ListTile(
              title: Text('Manage Farms'),
              trailing: Icon(Icons.collections_bookmark),
            ),
            ListTile(
              title: Text('About Us'),
              trailing: Icon(Icons.info),
            ),
            ListTile(
              title: Text('Enable Passcode'),
              trailing: Icon(Icons.lock),
            ),
            ListTile(
              title: Text('Log Out'),
              trailing: Icon(Icons.exit_to_app),
              onTap: () async {
                try {
                  AuthService auth = Provider.of(context).auth;
                  await auth.signOut();
                  print("Signed Out!");
                } catch (e) {
                  print (e);
                }
              },
            ),

          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Bantay Sarai"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
//              Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => NewTripLocationView(trip: newTrip,)),
//              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddFarmView(farm: newFarm,)),
              );
            },
          ),
        ],
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
              icon: new Icon(Icons.explore),
              title: new Text("Explore"),
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
