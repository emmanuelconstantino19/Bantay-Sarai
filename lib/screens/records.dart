import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bantay_sarai/widgets/provider_widget.dart';
import 'package:intl/intl.dart';
import 'package:bantay_sarai/screens/add_harvesting_data.dart';
import 'package:bantay_sarai/screens/add_planting_data.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class Records extends StatefulWidget {
  final farmData;
  Records({Key key, @required this.farmData}) : super(key: key);

  @override
  _RecordsState createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  static const String ViewRecordDetails = 'View record details';
  static const String DeleteRecord = 'Delete record';

  static const List<String> choices = <String>[
    ViewRecordDetails,
    DeleteRecord
  ];


  Stream<QuerySnapshot> getRecordStreamSnapshots(BuildContext context, farmId) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* FirebaseFirestore.instance.collection('userData').doc(uid).collection('farms').doc(farmId).collection('records').orderBy('plantedDate',descending: true).snapshots();
  }

  void showToast(message, Color color) {
    print(message);
    // Fluttertoast.showToast(
    //     msg: message,
    //     toastLength: Toast.LENGTH_LONG,
    //     gravity: ToastGravity.BOTTOM,
    //     backgroundColor: color,
    //     textColor: Colors.white,
    //     fontSize: 16.0);
  }

  void choiceAction(String choice, DocumentSnapshot recordData) async {
    if(choice==ViewRecordDetails){
      buildRecordAbout(context, recordData);
    }
    else if(choice==DeleteRecord){
        final uid = await Provider.of(context).auth.getCurrentUID();
        await _deleteRecordData(uid, widget.farmData.docID,recordData.id);
        showToast('Successfully deleted entry.', Colors.green);

    }
  }

  _deleteRecordData(uid,farmId,recordId) async {
    await Provider.of(context).db.collection('userData').doc(uid).collection('farms').doc(farmId).collection('records').doc(recordId).delete();
  }

  buildAddRecordDialog(BuildContext context, String farmName, String cropPlanted, String farmId){
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
                                      MaterialPageRoute(builder: (context) => AddPlantingDataInner(farmName: farmName,cropPlanted: cropPlanted, farmID: farmId , record: null)),
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
                                      MaterialPageRoute(builder: (context) => AddHarvestingDataInner(farmName: farmName,cropPlanted: cropPlanted, farmID: farmId , record: null)),
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

  buildRecordAbout(BuildContext context, DocumentSnapshot recordData){
    return showDialog<String>(
      context: context,
//      barrierDismissible: false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState){
              return AlertDialog(
                title: Text('Record details'),
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(20.0)),
                content: Container(
                    child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            DataTable(
                              columnSpacing: 15,
                              horizontalMargin: 0,
                              headingRowHeight: 0,
                              columns: [
                                DataColumn(label: Text('')),
                                DataColumn(label: Text('')),
                              ],
                              rows: [
                                DataRow(cells: [
                                  DataCell(Text("Land Preparation date")),
                                  DataCell(Text(recordData['landPreparationDate']==null ? '' : DateFormat('MMM dd, yyyy').format(recordData['landPreparationDate'].toDate()))),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Seedling preparation date")),
                                  DataCell(Text(recordData['seedlingPreparationDate']==null ? '' : DateFormat('MMM dd, yyyy').format(recordData['seedlingPreparationDate'].toDate()))),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Planted/Transplanted date")),
                                  DataCell(Text(recordData['plantedDate']==null ? '' : DateFormat('MMM dd, yyyy').format(recordData['plantedDate'].toDate()))),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Target date of harvest")),
                                  DataCell(Text(recordData['targetDateOfHarvest']==null ? '' : DateFormat('MMM dd, yyyy').format(recordData['targetDateOfHarvest'].toDate()))),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Target market")),
                                  DataCell(Text(recordData['targetMarket']==null ? '' : recordData['targetMarket'])),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Expected quantity of harvest")),
                                  DataCell(Text(recordData['expectedQtyOfHarvest']==null ? '' : recordData['expectedQtyOfHarvest'])),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Harvest Date")),
                                  DataCell(Text(recordData['harvestDate']==null ? '' : DateFormat('MMM dd, yyyy').format(recordData['harvestDate'].toDate()))),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Quantity of harvest")),
                                  DataCell(Text(recordData['qtyOfHarvest']==null ? '' : recordData['qtyOfHarvest'])),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Quantity of harvest sold/ to be sold")),
                                  DataCell(Text(recordData['qtyOfHarvestSold']==null ? '' : recordData['qtyOfHarvestSold'])),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Gross income (harvest)")),
                                  DataCell(Text(recordData['grossIncome']==null ? '' : recordData['grossIncome'])),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Net Income (harvest)")),
                                  DataCell(Text(recordData['netIncome']==null ? '' : recordData['netIncome'])),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Harvesting Procedure")),
                                  DataCell(Text(recordData['harvestingProcedure']==null ? '' : recordData['harvestingProcedure'])),
                                ]),
                              ],
                            ),
//                            Text('Know which provinces are affected and will be affected by moisture stress. Indices are aggregated per province.', style: TextStyle(color:Colors.blueGrey),),
//                            SizedBox(height:20),
//                            RichText(
//                              text: TextSpan(
//                                style: TextStyle(
//                                    fontSize: 14,
//                                    color: Colors.black),
//                                children: <TextSpan>[
//                                  TextSpan(text: "Source:", style: new TextStyle(fontWeight: FontWeight.bold)),
//                                  TextSpan(text: " DCAF Project"),
//                                ],
//                              ),
//                            ),
                          ],
                        )
                    )
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Close',
                      style: TextStyle(color: Colors.grey),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            }
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.farmData['farmName']} records"),
        centerTitle: true,
        //elevation: 0,
        elevation: 1,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: getRecordStreamSnapshots(context,widget.farmData.docID),
          builder: (context,recordSnapshot){
            if(!recordSnapshot.hasData) return Center(child: CircularProgressIndicator());
            if(recordSnapshot.data.docs.length==0){
              return Center(child: Text("No records for this farm yet.",style: TextStyle(fontSize: 18)),);
            }
            return ListView.builder(
                itemCount: recordSnapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index){
                  return Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child:Row(
                            children: [
                              Expanded(child:Container()),
                              PopupMenuButton<String>(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child:Icon(
                                    Icons.more_horiz,
                                    color: Colors.blueGrey,
//                                          size: 22.0,
                                  ),
                                ),
                                onSelected: (value){
                                  choiceAction(value,recordSnapshot.data.docs[index]);
                                },
                                itemBuilder: (BuildContext context){
                                  return choices.map((String choice){
                                    return PopupMenuItem<String>(
                                      value: choice,
                                      child: Text(choice),
                                      textStyle: TextStyle(color: choice==DeleteRecord ? Colors.red : Colors.black,),
                                    );
                                  }).toList();
                                },
                              ),
                            ],
                          ),
                        ),
                        //title
                        Divider(height:0),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
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
                                              (recordSnapshot.data.docs[index]['plantedDate'] != null) ? DateFormat('MMM dd, yyyy').format(recordSnapshot.data.docs[index]['plantedDate'].toDate()) : '+ Add Entry',
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
                                      if(recordSnapshot.data.docs[index]['plantedDate'] != null) {
                                        showModalBottomSheet<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Container(
                                                height: 50,
                                                color: Colors.white,
                                                child: ElevatedButton(
                                                  child: const Text('EDIT PLANTING DATE'),
                                                  style: ButtonStyle(
                                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.zero,
                                                          )
                                                      )
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => AddPlantingDataInner(farmName:widget.farmData['farmName'],cropPlanted:widget.farmData['cropsPlanted'], farmID: widget.farmData.docID , record: recordSnapshot.data.docs[index])),
                                                    );
                                                  },
                                                )
                                            );
                                          },
                                        );
                                      }
                                    },
                                    onTap: () {
                                      if(recordSnapshot.data.docs[index]['plantedDate'] == null){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => AddPlantingDataInner(farmName:widget.farmData['farmName'],cropPlanted:widget.farmData['cropsPlanted'], farmID: widget.farmData.docID , record: recordSnapshot.data.docs[index])),
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
                                              (recordSnapshot.data.docs[index]['harvestDate'] != null) ? DateFormat('MMM dd, yyyy').format(recordSnapshot.data.docs[index]['harvestDate'].toDate()) : '+ Add Entry',
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
                                      if(recordSnapshot.data.docs[index]['harvestDate'] != null) {
                                        showModalBottomSheet<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Container(
                                                height: 50,
                                                color: Colors.white,
                                                child: ElevatedButton(
                                                  child: const Text('EDIT HARVESTING DATE'),
                                                  style: ButtonStyle(
                                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.zero,
                                                          )
                                                      )
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => AddHarvestingDataInner(farmName:widget.farmData['farmName'],cropPlanted:widget.farmData['cropsPlanted'], farmID: widget.farmData.docID , record: recordSnapshot.data.docs[index])),
                                                    );
                                                  },
                                                )
                                            );
                                          },
                                        );
                                      }
                                    },
                                    onTap: () {
                                      if(recordSnapshot.data.docs[index]['harvestDate'] == null){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => AddHarvestingDataInner(farmName:widget.farmData['farmName'],cropPlanted:widget.farmData['cropsPlanted'], farmID: widget.farmData.docID , record: recordSnapshot.data.docs[index])),
                                        );
                                      }
                                    },
                                  )
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  );
                });
          }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF369d34),
        onPressed: (){
          buildAddRecordDialog(context, widget.farmData['farmName'], widget.farmData['cropsPlanted'], widget.farmData.docID);
        },
        tooltip: 'Add Record',
        child: Icon(Icons.add),
      ),
    );
  }
}
