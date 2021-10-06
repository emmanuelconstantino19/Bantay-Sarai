import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:bantay_sarai/models/User.dart';
import 'package:bantay_sarai/widgets/provider_widget.dart';
import 'package:bantay_sarai/screens/farm_view.dart';
import 'package:bantay_sarai/screens/add_planting_data.dart';
import 'package:bantay_sarai/screens/add_harvesting_data.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  FUser user = FUser("","","","","","","","");

  GoogleMapController _controller;

  CameraPosition _initialPosition;

  List<Marker> markers;

  String location;

  addMarker(cordinate){
    int id = Random().nextInt(100);

    print(cordinate);

    setState(() {
      markers.add(Marker(position: cordinate, markerId: MarkerId(id.toString())));
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      Stack(
        children: [
          FutureBuilder(
              future: _getLocation(),
              builder: (context,snapshot) {
                if(location==null) return Center(child: CircularProgressIndicator());
                return GoogleMap(
                  initialCameraPosition: _initialPosition,
                  mapType: MapType.normal,
                  zoomControlsEnabled: false,
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
                );
              }),
          FutureBuilder(
              future: _getProfileData(),
              builder: (context, snapshot) {
                return
                  Container(
                    margin: EdgeInsets.all(16.0),
//                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                          color:  Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),

                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top:16.0,left:16.0),
                            child: Image.asset(
                              'assets/logos/half_lady_sarai.png',
                              fit: BoxFit.contain,
                              height: 70,
                            ),
                          ),
                          SizedBox(width:10),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey[800]),
                              children: [
                                TextSpan(text:'Mabuhay,\n', style: TextStyle(fontSize:15)),
                                TextSpan(text:user.firstName + ' ' + user.lastName + '!', style: TextStyle(fontSize:20)),
                              ]
                            ),
                          ),
//                          Text('Mabuhay,', style: TextStyle(fontSize:15,fontWeight: FontWeight.bold,color: Colors.black)),
//                          Text(user.firstName + ' ' + user.lastName + '!', style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color: Color(0xFF369d34))),
                        ],
                      )
                  );
              }
          ),
        ],
      );
  }

  _getLocation() async {
    final uid = await Provider.of(context).auth.getCurrentUID();
    await Provider.of(context)
        .db
        .collection('userData')
        .document(uid)
        .collection('farms').getDocuments().then((result) {
          if(result.documents.length==0){
            print("HERE");
            location="Luzon";
            _initialPosition = CameraPosition(target: LatLng(14.14888901625053, 121.38876356184483), zoom:6);
            markers = [Marker(position: LatLng(14.14888901625053, 121.38876356184483), markerId: MarkerId('1'))];
          }else{
            print("here location");
            location = result.documents[0].data['location'];
            if(location=="Pakil, Laguna"){
              _initialPosition = CameraPosition(target: LatLng(14.402397618883445, 121.44038200378418), zoom:12);
              markers = [Marker(position: LatLng(14.402397618883445, 121.44038200378418), markerId: MarkerId('1'))];
            }else if(location=="Bae, Laguna"){
              _initialPosition = CameraPosition(target: LatLng(14.130610546629763, 121.25636536628008), zoom:12);
              markers = [Marker(position: LatLng(14.130610546629763, 121.25636536628008), markerId: MarkerId('1'))];
            }else if(location=="Nagcarlan, Laguna"){
              _initialPosition = CameraPosition(target: LatLng(14.14888901625053, 121.38876356184483), zoom:12);
              markers = [Marker(position: LatLng(14.14888901625053, 121.38876356184483), markerId: MarkerId('1'))];
              print('Here in Bae');
            }
          }
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

//class PastTripsPage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      color: Colors.orange,
//    );
//  }
//}