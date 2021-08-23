import 'package:flutter/material.dart';
import 'package:bantay_sarai/widgets/provider_widget.dart';
import 'package:bantay_sarai/screens/add_harvesting_data.dart';
import 'package:bantay_sarai/screens/add_planting_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bantay_sarai/models/Farm.dart';
import 'package:intl/intl.dart';

class CropView extends StatefulWidget {
  final String crop, totalSize;
  CropView({Key key, @required this.crop, this.totalSize}) : super(key: key);

  @override
  _CropViewState createState() => _CropViewState();
}

class _CropViewState extends State<CropView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("RECORDS"),
          centerTitle: true,
          //elevation: 0,
          elevation: 1,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height:40),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image(
                      image: AssetImage('assets/images/'+ widget.crop.toLowerCase() +'1_light.png'),
                      height: 170,
                      //width: double.infinity,
                      //fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height:20),
                  Text('${filipinoTerm(widget.crop)} (${widget.crop})', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0)),
                  SizedBox(height:20),
                  Divider(color:Colors.blue),
                  SizedBox(height:10),
                  Text(
                    'TOTAL: ${widget.totalSize} ha',
                    style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ],
              ),
            ),

            StreamBuilder<QuerySnapshot>(
                stream: getFarmStreamSnapshots(context),
                builder: (context, snapshot) {
                  if(!snapshot.hasData) return Center(child: CircularProgressIndicator());
                  return new Expanded(child: new ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index){
                      return new Column(
                        children: [
                      Card(
                        child: ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            title:
                            Text('${snapshot.data.documents[index]['farmName']} (${snapshot.data.documents[index]['farmSize']} ha)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height:10),
                                StreamBuilder<QuerySnapshot>(
                                    stream: getRecordStreamSnapshots(context,snapshot.data.documents[index].documentID),
                                    builder: (context,recordSnapshot){
                                      if(!recordSnapshot.hasData) return Center(child: CircularProgressIndicator());

                                      //when nothing is set yet
                                      if(recordSnapshot.data.documents.length == 0){
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Expanded(
                                              child: GestureDetector(
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 30),
                                                  decoration: BoxDecoration(
                                                      color:Color(0xffE9F4F9), borderRadius: BorderRadius.circular(15)),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Center(
                                                        child: Text(
                                                          "Petsa ng \nPagtanim:",
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w600,
                                                              color: Color(0xff5A6C64)),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Center(
                                                        child: Text(
                                                          '+ Add Entry',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight: FontWeight.bold,
                                                              color: Color(0xff5A6C64)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => AddPlantingDataInner(farmName:snapshot.data.documents[index]['farmName'],cropPlanted:snapshot.data.documents[index]['cropsPlanted'], farmID: snapshot.data.documents[index].documentID, recordID: null )),
                                                  );
                                                },
                                              )
                                            ),
                                            SizedBox(width: 10),

                                            Expanded(
                                              child: GestureDetector(
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 30),
                                                  decoration: BoxDecoration(
                                                      color: Color(0xffEAFAF0), borderRadius: BorderRadius.circular(15)),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Center(
                                                        child: Text(
                                                          "Petsa ng \nPag-aani:",
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w600,
                                                              color: Color(0xff5A6C64)),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Center(
                                                        child: Text(
                                                          '+ Add Entry',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight: FontWeight.bold,
                                                              color: Color(0xff5A6C64)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                onTap: (){
//                                                  final snackBar = SnackBar(content: Text("Tap"));
//
//                                                  Scaffold.of(context).showSnackBar(snackBar);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => AddHarvestingDataInner(farmName:snapshot.data.documents[index]['farmName'],cropPlanted:snapshot.data.documents[index]['cropsPlanted'], farmID: snapshot.data.documents[index].documentID , recordID: null )),
                                                  );

                                                },
                                              )
                                            ),
                                          ],
                                        );
                                      }

                                      //when atleast planting or harvesting date is set
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Expanded(
                                            child: GestureDetector(
                                              child: Container(
                                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 30),
                                                decoration: BoxDecoration(
                                                    color:Color(0xffE9F4F9), borderRadius: BorderRadius.circular(15)),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        "Petsa ng \nPagtanim:",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w600,
                                                            color: Color(0xff5A6C64)),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Center(
                                                      child: Text(
                                                        (recordSnapshot.data.documents[0]['plantedDate'] != null) ? DateFormat('MM/dd/yyyy').format(recordSnapshot.data.documents[0]['plantedDate'].toDate()) : '+ Add Entry',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.bold,
                                                            color: Color(0xff5A6C64)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              onLongPress: () {
                                                if(recordSnapshot.data.documents[0]['plantedDate'] != null){
                                                  showModalBottomSheet<void>(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return Container(
                                                          height: 50,
                                                          color: Colors.white,
                                                          child: ElevatedButton(
                                                            child: const Text('DELETE ENTRY'),
                                                            style: ButtonStyle(
                                                                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                    RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.zero,
                                                                    )
                                                                )
                                                            ),
                                                            onPressed: () async {
                                                              final uid = await Provider.of(context).auth.getCurrentUID();
                                                              var farmId = snapshot.data.documents[0].documentID;
                                                              var recordId = recordSnapshot.data.documents[0].documentID;
                                                              Firestore.instance.collection('userData').document(uid).collection('farms').document(farmId).collection('records').document(recordId)
                                                                  .updateData({
                                                                "plantedDate":null
                                                              }).then((result){
                                                                print("Deleted entry");
                                                              }).catchError((onError){
                                                                print("onError");
                                                              });
                                                              Navigator.pop(context);
                                                            },
                                                          )
                                                      );
                                                    },
                                                  );
                                                }
                                              },
                                              onTap: () {
                                                if(recordSnapshot.data.documents[0]['plantedDate'] == null){
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => AddPlantingDataInner(farmName:snapshot.data.documents[index]['farmName'],cropPlanted:snapshot.data.documents[index]['cropsPlanted'], farmID: snapshot.data.documents[index].documentID , recordID: recordSnapshot.data.documents[0].documentID)),
                                                  );
                                                }
                                              },
                                            )
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: GestureDetector(
                                              child: Container(
                                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 30),
                                                decoration: BoxDecoration(
                                                    color: Color(0xffEAFAF0), borderRadius: BorderRadius.circular(15)),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        "Petsa ng \nPag-aani:",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w600,
                                                            color: Color(0xff5A6C64)),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Center(
                                                      child: Text(
                                                        (recordSnapshot.data.documents[0]['harvestDate'] != null) ? DateFormat('MM/dd/yyyy').format(recordSnapshot.data.documents[0]['harvestDate'].toDate()) : '+ Add Entry',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.bold,
                                                            color: Color(0xff5A6C64)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              onLongPress: () {
                                                if(recordSnapshot.data.documents[0]['harvestDate'] != null) {
                                                  showModalBottomSheet<void>(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return Container(
                                                          height: 50,
                                                          color: Colors.white,
                                                          child: ElevatedButton(
                                                            child: const Text('DELETE ENTRY'),
                                                            style: ButtonStyle(
                                                                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                    RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.zero,
                                                                    )
                                                                )
                                                            ),
                                                            onPressed: () async {
                                                              final uid = await Provider.of(context).auth.getCurrentUID();
                                                              var farmId = snapshot.data.documents[0].documentID;
                                                              var recordId = recordSnapshot.data.documents[0].documentID;
                                                              Firestore.instance.collection('userData').document(uid).collection('farms').document(farmId).collection('records').document(recordId)
                                                                  .updateData({
                                                                "harvestDate":null
                                                              }).then((result){
                                                                print("Deleted entry");
                                                              }).catchError((onError){
                                                                print("onError");
                                                              });
                                                              Navigator.pop(context);
                                                            },
                                                          )
                                                      );
                                                    },
                                                  );
                                                }
                                              },
                                              onTap: () {
                                                if(recordSnapshot.data.documents[0]['harvestDate'] == null){
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => AddHarvestingDataInner(farmName:snapshot.data.documents[index]['farmName'],cropPlanted:snapshot.data.documents[index]['cropsPlanted'], farmID: snapshot.data.documents[index].documentID , recordID: recordSnapshot.data.documents[0].documentID)),
                                                  );
                                                }
                                              },
                                            )
                                          ),
                                        ],
                                      );
                                    }
                                ),

                              ],
                            ))
                    ),
                        ],
                      );
                    },

                  ));
                }
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
      'Tomato' : 'Kamatis',
      'Other Crop' : ''
    };
    return cropTerms[crop];
  }

  _getRecordData(uid,farmId) async {
    var dates;
    await Provider.of(context).db.collection('userData').document(uid).collection('farms').document(farmId).collection('records').orderBy('plantedDate',descending: true).limit(1).getDocuments().then((result){
      result.documents.forEach((f){
        dates = f.data;
      });
    });
    return dates;
  }

  Stream<QuerySnapshot> getFarmStreamSnapshots(BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance.collection('userData').document(uid).collection('farms').where('cropsPlanted', isEqualTo: widget.crop).snapshots();
  }

  Stream<QuerySnapshot> getRecordStreamSnapshots(BuildContext context, farmId) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance.collection('userData').document(uid).collection('farms').document(farmId).collection('records').orderBy('plantedDate',descending: true).limit(1).snapshots();
  }

  _getFarmData() async {
    Map map1 = {};
    final uid = await Provider.of(context).auth.getCurrentUID();
    await Provider.of(context)
        .db
        .collection('userData')
        .document(uid)
        .collection('farms').where('cropsPlanted', isEqualTo: widget.crop).getDocuments().then((result) {
      result.documents.forEach((f){
        map1[f.data['farmName']] = FarmRecord(f.data['farmName'],f.data['cropsPlanted'],f.data['annualIncome'],f.data['location'],f.data['farmSize'],f.data['farmType'],f.data['organicPractitioner'],f.data['farmOwnership'],null,null);
      });
    });





//    var doc_ref = await Provider.of(context)
//        .db
//        .collection('userData')
//        .document(uid)
//        .collection('farms').getDocuments();
//
//    print(doc_ref.documents[1].documentID);
    //print(farms);

    return map1;
  }
}
