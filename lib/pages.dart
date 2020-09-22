import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:bantay_sarai/models/User.dart';
import 'package:bantay_sarai/widgets/provider_widget.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  User user = User("","","","","","","","");

  GoogleMapController _controller;

  final CameraPosition _initialPosition = CameraPosition(target: LatLng(14.3730, 121.4399), zoom:12);

  final List<Marker> markers = [];

  addMarker(cordinate){

    int id = Random().nextInt(100);

    setState(() {
      markers.add(Marker(position: cordinate, markerId: MarkerId(id.toString())));
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  return
                    Padding(
                      padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Mabuhay,', style: TextStyle(fontSize:15,fontWeight: FontWeight.bold,color: Colors.green)),
                            Text(user.firstName + ' ' + user.lastName + '!', style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color: Colors.green)),
                          ],
                        )
                    );
                }
            ),
            Expanded(
              child: GoogleMap(
                initialCameraPosition: _initialPosition,
                mapType: MapType.hybrid,
                onMapCreated: (controller){
                  setState(() {
                    _controller = controller;
                  });
                },
                markers: markers.toSet(),
                onTap: (cordinate){
                  _controller.animateCamera(CameraUpdate.newLatLng(cordinate));
                  addMarker(cordinate);
                },
              )
            ),
            SizedBox(height: 20),
            InkWell(
              child: Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green[400],
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(1.0, 1.0),
                        blurRadius: 5.0,
                      ),
                    ]
                ),
                child: Center(
                  child: Text("Mag-update ng Farmer Profile", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                ),
              ),
              onTap: () {
              },
            ),
            SizedBox(height: 10),
            InkWell(
              child: Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green[400],
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(1.0, 1.0),
                        blurRadius: 5.0,
                      ),
                    ]
                ),
                child: Center(
                  child: Text("+ Magdagdag ng Farm", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                ),
              ),
              onTap: () {
              },
            ),
            SizedBox(height: 10),
            InkWell(
              child: Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green[400],
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(1.0, 1.0),
                        blurRadius: 5.0,
                      ),
                    ]
                ),
                child: Center(
                  child: Text("+ Magdagdag ng Record", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                ),
              ),
              onTap: () {
              },
            ),
            SizedBox(height: 20),
          ],
        )
      );
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

class PastTripsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
    );
  }
}