import 'package:flutter/material.dart';
import 'package:bantay_sarai/widgets/provider_widget.dart';
import 'package:bantay_sarai/models/User.dart';
import 'package:bantay_sarai/models/Farm.dart';
import 'package:bantay_sarai/screens/add_farm_view.dart';
import 'package:bantay_sarai/screens/crop_view.dart';

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
            FutureBuilder(
                future: _getFarmData(),
                builder: (context, snapshot) {
                  if(!snapshot.hasData) return Center(child: CircularProgressIndicator());
                  return new Expanded(child: new ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index){
                      String key = snapshot.data.keys.elementAt(index);
                      return new Column(
                        children: [
                          InkWell(
                            child: Stack(
                              children: <Widget>[
//                              Positioned(
//                                top: 0,
//                                right: 0,
//                                child: GestureDetector(
//                                  onTap:(){
//                                    print("Delete");
//                                  },
//                                  child: Container(
//                                    padding: EdgeInsets.all(20.0),
//                                    decoration: BoxDecoration(
//                                      borderRadius: BorderRadius.circular(8.0),
//                                    ),
//                                    child: Icon(
//                                      Icons.highlight_off,
//                                    ),
//                                  ),
//                                ),
//                              ),
                                Container(
                                    alignment: Alignment.center,
                                    child: Image(
                                      image: AssetImage('assets/images/'+ key.toLowerCase() +'1.png'),
                                      height: 170,
                                      //width: double.infinity,
                                      //fit: BoxFit.cover,
                                    ),
                                  ),
                                Container(
                                    height: 170,
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${snapshot.data[key]} ha',
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30.0),
                                    )),
                              ],
                            ),
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => CropView(crop: key, totalSize: snapshot.data[key].toString())),
                              );
                            },
                          ),

                          Text('${filipinoTerm(key)} ($key)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                          SizedBox(height:40),
                        ],
                      );
                    },

                  ));
                }
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

  filipinoTerm(crop) {
    Map cropTerms = {
      'Banana':'Saging',
      'Cacao':'Kakaw',
      'Coconut' : 'Niyog',
      'Coffee' : 'Kape',
      'Corn' : 'Mais',
      'Rice' : 'Palay',
      'Soybean' : 'Soybean',
      'Sugarcane' : 'Tubo',
      'Tomato' : 'Kamatis'
    };
    return cropTerms[crop];
  }



  _getFarmData() async {
    Map map1 = {};
    final uid = await Provider.of(context).auth.getCurrentUID();
    await Provider.of(context)
        .db
        .collection('userData')
        .document(uid)
        .collection('farms').getDocuments().then((result) {
      result.documents.forEach((f) => (map1.containsKey(f.data['cropsPlanted'])) ? map1[f.data['cropsPlanted']] += double.parse(f.data['farmSize']) : map1[f.data['cropsPlanted']] = double.parse(f.data['farmSize']));
    });

//    var doc_ref = await Provider.of(context)
//        .db
//        .collection('userData')
//        .document(uid)
//        .collection('farms').getDocuments();
//
//    print(doc_ref.documents[1].documentID);

    return map1;
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
