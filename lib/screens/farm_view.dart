import 'package:flutter/material.dart';
import 'package:bantay_sarai/widgets/provider_widget.dart';
import 'package:bantay_sarai/models/User.dart';
import 'package:bantay_sarai/models/Farm.dart';
import 'package:bantay_sarai/screens/add_farm_view.dart';

class FarmView extends StatefulWidget {
  @override
  _FarmViewState createState() => _FarmViewState();
}

class _FarmViewState extends State<FarmView> {
  User user = User("","","","","","","","");
  final newFarm = new Farm(null, null, null, null, null, null, null, null);
  String loc = '', noOfFarms = '', noOfCrops = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("MGA FARMS"),
          elevation: 1,
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: FutureBuilder(
                  future: _getUserData(),
                  builder: (context, snapshot) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(color:Colors.blue),
                        Text('Pangalan: ' + user.lastName + ', ' + user.firstName, style: TextStyle(color:Colors.blue,fontWeight: FontWeight.bold, fontSize: 15)),
                        Text('Bayan: ' + loc, style: TextStyle(color:Colors.blue,fontWeight: FontWeight.bold, fontSize: 15)),
                        Text('Bilang ng Farms: ' + noOfFarms, style: TextStyle(color:Colors.blue,fontWeight: FontWeight.bold, fontSize: 15)),
                        Text('Bilang / Mga Uri ng Crops: ' + noOfCrops, style: TextStyle(color:Colors.blue,fontWeight: FontWeight.bold, fontSize: 15)),
                        Divider(color:Colors.blue),
                      ],
                    );
                  }
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                    child: Column(
                      children: <Widget>[
                        Center(
                            child: Column(
                              children: [
                                Stack(
                                  children: <Widget>[
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: GestureDetector(
                                        onTap:(){
                                          print("Delete");
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(20.0),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                          child: Icon(
                                            Icons.highlight_off,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Image(
                                        image: AssetImage('assets/images/corn1.png'),
                                        height: 170,
                                        //width: double.infinity,
                                        //fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                        height: 170,
                                        alignment: Alignment.center,
                                        child: Text(
                                          '1.4 ha',
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30.0),
                                        )),
                                  ],
                                ),
                                Text('Palay (Rice)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                                SizedBox(height:40),

                                Stack(
                                  children: <Widget>[
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: GestureDetector(
                                        onTap:(){
                                          print("Delete");
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(20.0),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                          child: Icon(
                                            Icons.highlight_off,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Image(
                                        image: AssetImage('assets/images/rice1.png'),
                                        height: 170,
                                        //width: double.infinity,
                                        //fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                        height: 170,
                                        alignment: Alignment.center,
                                        child: Text(
                                          '1.4 ha',
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30.0),
                                        )),
                                  ],
                                ),
                                Text('Mais (Corn)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                                SizedBox(height:40),
                              ],
                            )
                        ),
                      ],
                    )
                )
            ),
            InkWell(
              child: Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddFarmView(farm: newFarm,)),
                );
              },
            ),
          ],
        )
    );
  }

  _getUserData() async {
    List<String> cropList = [];
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

    await Provider.of(context)
        .db
        .collection('userData')
        .document(uid)
        .collection('farms').getDocuments().then((result) {
            result.documents.forEach((f) => cropList.add(f.data['cropsPlanted']));
            noOfCrops = cropList.toSet().toList().length.toString();
            noOfFarms = result.documents.length.toString();
            loc = result.documents[0].data['location'];
        });

  }
}
