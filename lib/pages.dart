import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:bantay_sarai/models/User.dart';
import 'package:bantay_sarai/widgets/provider_widget.dart';
import 'package:bantay_sarai/screens/farm_view.dart';
import 'package:bantay_sarai/screens/add_planting_data.dart';
import 'package:bantay_sarai/screens/add_harvesting_data.dart';
import 'package:bantay_sarai/Animation/FadeAnimation.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  User user = User("","","","","","","","");

  GoogleMapController _controller;

  final CameraPosition _initialPosition = CameraPosition(target: LatLng(14.402397618883445, 121.44038200378418), zoom:12);

  final List<Marker> markers = [Marker(position: LatLng(14.402397618883445, 121.44038200378418), markerId: MarkerId('1'))];

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
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              crossAxisAlignment: CrossAxisAlignment.baseline,
//              textBaseline: TextBaseline.alphabetic,
//              children: <Widget>[
//                FadeAnimation(1, Text('Farms', style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold, fontSize: 25),)),
//                SizedBox(width: 5,),
//                InkWell(
//                  child: Text("View All",
//                  style: TextStyle(color: Colors.grey[600], decoration: TextDecoration.underline,)),
//                  onTap: () {print("haha");},
//                ),
//              ],
//            ),
//            SizedBox(height: 20,),
//            Container(
//              height: 50,
//              child: Row(
//                children: [
//                  Container(
//                    //margin: EdgeInsets.only(right: 10),
//                    child:MaterialButton(
//                      minWidth: 0,
//                      onPressed: () {
//                        //_addPlantation(context);
//                      },
//                      elevation: 2.0,
//                      color:Colors.blue,
//                      child: Icon(
//                        Icons.add,
//                        color: Colors.white,
//                      ),
//                      shape: CircleBorder(),
//                    ),
//                  ),
//                  Expanded(
//                    child: ListView(
//                      scrollDirection: Axis.horizontal,
//                      children: <Widget>[
//                        FadeAnimation(1, makeCategory(isActive: true, title: 'Farm1')),
//                        FadeAnimation(1.3, makeCategory(isActive: false, title: 'Farm2')),
//                        FadeAnimation(1.4, makeCategory(isActive: false, title: 'Farm3')),
//                        FadeAnimation(1.5, makeCategory(isActive: false, title: 'Farm4')),
//                        FadeAnimation(1.6, makeCategory(isActive: false, title: 'Farm5')),
//                      ],
//                    ),
//                  ),
//                ],
//              ),
//            ),
            SizedBox(height: 10,),
            FutureBuilder(
                future: _getProfileData(),
                builder: (context, snapshot) {
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
//            SizedBox(height: 20),
//            InkWell(
//              child: Container(
//                height: 50,
//                margin: EdgeInsets.symmetric(horizontal: 25),
//                decoration: BoxDecoration(
//                    borderRadius: BorderRadius.circular(10),
//                    color: Colors.green[400],
//                    boxShadow: [
//                      BoxShadow(
//                        offset: const Offset(1.0, 1.0),
//                        blurRadius: 5.0,
//                      ),
//                    ]
//                ),
//                child: Center(
//                  child: Text("Mag-update ng Farmer Profile", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
//                ),
//              ),
//              onTap: () {
//              },
//            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:40.0),
              child: SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.green[600])
                  ),
                  color: Colors.green[400],
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FarmView()),
                    );
                  },
                  textColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical:15.0),
                  child: Text('+ Magdagdag ng Farm',style:TextStyle(fontSize:15)),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:40.0),
              child: SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.green[600])
                  ),
                  color: Colors.green[400],
                  onPressed: () {
                    buildAddRecordDialog(context);
                  },
                  textColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical:15.0),
                  child: Text('+ Magdagdag ng Record',style:TextStyle(fontSize:15)),
                ),
              ),
            ),
            SizedBox(height: 10),
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

  Widget makeCategory({isActive, title}) {
    return AspectRatio(
      aspectRatio: isActive ? 3 : 2.5 / 1,
      child: Container(
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          //color: isActive ? Colors.lightGreen[700] : Colors.grey[200],
          gradient: isActive ? LinearGradient(colors: [ Colors.green,Colors.blue]) : LinearGradient(colors: [Colors.grey[200], Colors.grey[200]]),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Align(
          child: Text(title, style: TextStyle(color: isActive ? Colors.white : Colors.black, fontSize: 18, fontWeight: isActive ? FontWeight.bold : FontWeight.w100),),
        ),
      ),
    );
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

class PastTripsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
    );
  }
}