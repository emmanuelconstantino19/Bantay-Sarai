import 'package:flutter/material.dart';
import 'package:bantay_sarai/widgets/provider_widget.dart';
import 'package:bantay_sarai/models/User.dart';
import 'package:bantay_sarai/models/Farm.dart';
import 'package:bantay_sarai/screens/add_farm_view.dart';
import 'package:bantay_sarai/screens/crop_view.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class FarmView extends StatefulWidget {
  @override
  _FarmViewState createState() => _FarmViewState();
}

class _FarmViewState extends State<FarmView> {
  FUser user = FUser("","","","","","","","");
  final newFarm = new Farm(null, null, null, null, null, null, null, null);
  String loc = '', noOfFarms = '', noOfCrops = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("FARMS"),
          centerTitle: true,
          elevation: 0,
        ),
        body: Stack(
          children: [
            ClipPath(
              clipper: OvalBottomBorderClipper(),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Color(0xFF369d34),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                FutureBuilder(
                    future: _getUserData(),
                    builder: (context, snapshot) {
                      return Column(
                        children: [
                          const SizedBox(height: 30),
                          Text(
                            "${user.firstName} ${user.lastName}",
                            style: TextStyle(color:Colors.white,fontSize:22),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            loc,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 30.0),
                          Card(
                            color: Colors.white,
                            elevation: 0,
                            margin: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 32.0,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: Colors.lightGreen[700])
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          noOfFarms,
                                          style: TextStyle(color:Colors.grey[600],fontSize:36),
                                        ),
                                        const SizedBox(height: 10.0),
                                        Text(
                                          "Farms",
                                          style: TextStyle(color:Colors.lightGreen[700],fontSize:18),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          noOfCrops,
                                          style: TextStyle(color:Colors.grey[600],fontSize:36),
                                        ),
                                        const SizedBox(height: 10.0),
                                        Text(
                                          "Crops",
                                          style: TextStyle(color:Colors.lightGreen[700],fontSize:18),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  ),
                  FutureBuilder(
                    future: _getFarmData(),
                    builder: (context,snapshot) {
                      if(!snapshot.hasData) return Center(child: CircularProgressIndicator());
                      return Expanded(
                        child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context,index){
                              String key = snapshot.data.keys.elementAt(index);
                              return InkWell(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => CropView(crop: key, totalSize: snapshot.data[key].toString())),
                                  );
                                },
                                child: Card(
                                  child: Container(
                                    margin: EdgeInsets.all(20.0),
                                    color: Colors.white,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          flex: 6,
                                          child: Image(
                                            image: AssetImage('assets/images/'+ key.toLowerCase() +'1.png'),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
//                                              color: Colors.red,
                                              child: FittedBox(
                                                fit: BoxFit.fill,
                                                child: Text('${snapshot.data[key]} ha', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                              )
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
//                                              color: Colors.red,
                                              child: FittedBox(
                                                fit: BoxFit.fill,
                                                child: Text('${filipinoTerm(key)} ($key)', style: TextStyle(fontWeight: FontWeight.bold)),
                                              )
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      );
                    },
                  ),

//                  FutureBuilder(
//                    future: _getFarmData(),
//                    builder: (context, snapshot) {
//                      if(!snapshot.hasData) return Center(child: CircularProgressIndicator());
//                      return new Expanded(child: new ListView.builder(
//                        itemCount: snapshot.data.length,
//                        itemBuilder: (BuildContext context, int index){
//                          String key = snapshot.data.keys.elementAt(index);
//                          return new Column(
//                            children: [
//                              SizedBox(height:20),
//                              InkWell(
//                                child: Stack(
//                                  children: <Widget>[
//                                    Container(
//                                        alignment: Alignment.center,
//                                        child: Image(
//                                          image: AssetImage('assets/images/'+ key.toLowerCase() +'1.png'),
//                                          height: 170,
//                                          //width: double.infinity,
//                                          //fit: BoxFit.cover,
//                                        ),
//                                      ),
//                                    Container(
//                                        height: 170,
//                                        alignment: Alignment.center,
//                                        child: Text(
//                                          '${snapshot.data[key]} ha',
//                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30.0),
//                                        )),
//                                  ],
//                                ),
//                                onTap: (){
//                                  Navigator.push(
//                                    context,
//                                    MaterialPageRoute(builder: (context) => CropView(crop: key, totalSize: snapshot.data[key].toString())),
//                                  );
//                                },
//                              ),
//
//                              Text('${filipinoTerm(key)} ($key)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
//                              SizedBox(height:20),
//                            ],
//                          );
//                        },
//
//                      ));
//                    }
//                ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF369d34),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddFarmView(farm: newFarm,)),
            );
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
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
      'Tomato' : 'Kamatis',
      'Other Crop':''
    };
    return cropTerms[crop];
  }



  _getFarmData() async {
    Map map1 = {};
    final uid = await Provider.of(context).auth.getCurrentUID();
    await Provider.of(context)
        .db
        .collection('userData')
        .doc(uid)
        .collection('farms').get().then((result) {
      result.docs.forEach((f) => (map1.containsKey(f['cropsPlanted'])) ? map1[f['cropsPlanted']] += double.parse(f['farmSize']) : map1[f['cropsPlanted']] = double.parse(f['farmSize']));
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
        .doc(uid)
        .get().then((result) {
      user.firstName = result['firstName'];
      user.lastName = result['lastName'];
      user.middleName = result['middleName'];
    });

    await Provider.of(context)
        .db
        .collection('userData')
        .doc(uid)
        .collection('farms').get().then((result) {
            result.docs.forEach((f) => cropList.add(f['cropsPlanted']));
            noOfCrops = cropList.toSet().toList().length.toString();
            noOfFarms = result.docs.length.toString();
            loc = result.docs[0]['location'];
        });

  }
}
