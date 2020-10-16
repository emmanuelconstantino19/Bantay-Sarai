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
  User user = User("","","","","","","","");
  final newFarm = new Farm(null, null, null, null, null, null, null, null);
  String loc = '', noOfFarms = '', noOfCrops = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("FARMS"),
          centerTitle: true,
          backgroundColor: Colors.green,
          elevation: 0,
        ),
        body: Stack(
          children: [
            ClipPath(
              clipper: OvalBottomBorderClipper(),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.green,
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
                                side: BorderSide(color: Colors.green[600])
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
                                          style: TextStyle(color:Colors.green,fontSize:18),
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
                                          style: TextStyle(color:Colors.green,fontSize:18),
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
                    builder: (context, snapshot) {
                      if(!snapshot.hasData) return Center(child: CircularProgressIndicator());
                      return new Expanded(child: new ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index){
                          String key = snapshot.data.keys.elementAt(index);
                          return new Column(
                            children: [
                              SizedBox(height:20),
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
                              SizedBox(height:20),
                            ],
                          );
                        },

                      ));
                    }
                ),
//                Container(
//                  margin: EdgeInsets.symmetric(vertical: 10,horizontal:16.0),
//                  child: SizedBox(
//                    width: double.infinity,
//                    child: RaisedButton(
//                      shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(8.0),
//                          side: BorderSide(color: Colors.green[600])
//                      ),
//                      color: Colors.green[400],
//                      onPressed: () {
//                        Navigator.push(
//                          context,
//                          MaterialPageRoute(builder: (context) => AddFarmView(farm: newFarm,)),
//                        );
//                      },
//                      textColor: Colors.white,
//                      padding: const EdgeInsets.symmetric(vertical:20.0),
//                      child: Text('+ Magdagdag ng Farm',style:TextStyle(fontSize:15)),
//                    ),
//                  ),
//                ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
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
