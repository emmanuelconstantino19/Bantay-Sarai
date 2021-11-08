import 'package:flutter/material.dart';
import 'package:bantay_sarai/widgets/provider_widget.dart';
import 'package:bantay_sarai/screens/add_harvesting_data.dart';
import 'package:bantay_sarai/screens/add_planting_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bantay_sarai/models/Farm.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bantay_sarai/screens/records.dart';

class CropView extends StatefulWidget {
  final String crop, totalSize;
  CropView({Key key, @required this.crop, this.totalSize}) : super(key: key);

  @override
  _CropViewState createState() => _CropViewState();
}

class _CropViewState extends State<CropView> {
  static const String ViewFarmDetails = 'View farm details';
  static const String ViewRecordDetails = 'View record details';
  static const String CreateRecord = 'Create new record';
  static const String DeleteRecord = 'Delete current record';

  static const List<String> choices = <String>[
    ViewFarmDetails,
    ViewRecordDetails,
    CreateRecord,
    DeleteRecord
  ];

  void showToast(message, Color color) {
    print(message);
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void choiceAction(String choice, DocumentSnapshot farmData) async {
    if(choice==ViewFarmDetails)
      buildFarmAbout(context, farmData);
    else if(choice==ViewRecordDetails){
      final uid = await Provider.of(context).auth.getCurrentUID();
      List<DocumentSnapshot> records = await _getRecordData(uid, farmData.documentID);
      print(records);
      if(records.length > 0) {
        buildRecordAbout(context, records[0]);
      } else{
        showToast('No records available for this farm.', Colors.grey[700]);
      }
    }
    else if(choice==CreateRecord){
      buildAddRecordDialog(context, farmData['farmName'], farmData['cropsPlanted'], farmData.documentID);
      //farmName, cropPlanted, farmID, recordId
      //AddHarvestingDataInner(farmName:snapshot.data.documents[index]['farmName'],cropPlanted:snapshot.data.documents[index]['cropsPlanted'], farmID: snapshot.data.documents[index].documentID , recordID: recordSnapshot.data.documents[0].documentID)
    }
    else if(choice==DeleteRecord){
      final uid = await Provider.of(context).auth.getCurrentUID();
      List<DocumentSnapshot> records = await _getRecordData(uid, farmData.documentID);
      if(records.length == 0){
        showToast('No current record.', Colors.grey[700]);
      }
      else{
        print(records[0].documentID);
        await _deleteRecordData(uid, farmData.documentID,records[0].documentID);
        showToast('Successfully deleted current entry.', Colors.green);
      }

    }
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

  buildFarmAbout(BuildContext context, DocumentSnapshot farmData){
    return showDialog<String>(
      context: context,
//      barrierDismissible: false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState){
              return AlertDialog(
                title: Text('Farm details'),
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
                              horizontalMargin: 0,
//                  columnSpacing: 15,
                              headingRowHeight: 0,
                              columns: [
                                DataColumn(label: Text('')),
                                DataColumn(label: Text('')),
                              ],
                              rows: [
                                DataRow(cells: [
                                  DataCell(Text("Farm Name")),
                                  DataCell(Text(farmData['farmName']==null ? '' : farmData['farmName'])),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Farm Area")),
                                  DataCell(Text(farmData['farmSize']==null ? '' : '${farmData['farmSize']} ha')),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Annual Income")),
                                  DataCell(Text(farmData['annualIncome']==null ? '' : farmData['annualIncome'])),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Crop planted")),
                                  DataCell(Text(farmData['cropsPlanted']==null ? '' : farmData['cropsPlanted'])),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Farm Ownership")),
                                  DataCell(Text(farmData['farmOwnership']==null ? '' : farmData['farmOwnership'])),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Farm Type")),
                                  DataCell(Text(farmData['farmType']==null ? '' : farmData['farmType'])),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Location")),
                                  DataCell(Text(farmData['location']==null ? '' : farmData['location'])),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Organic Practitioner")),
                                  DataCell(Text(farmData['organicPractitioner']==null ? '' : farmData['organicPractitioner'])),
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
          title: Text("Records"),
          centerTitle: true,
          //elevation: 0,
          elevation: 1,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
//              decoration: BoxDecoration(
//                color: Colors.white
//              ),
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Card( // with Card
                      child: Image(
                        image: AssetImage('assets/images/'+ widget.crop.toLowerCase() +'1_light.png'),
                        height: 170,
                        //width: double.infinity,
                        //fit: BoxFit.cover,
                      ),
                      elevation: 5.0,
                      shape: CircleBorder(),
                      clipBehavior: Clip.antiAlias,

                    ),
                  ),
                  SizedBox(height:15),
                  Text('${filipinoTerm(widget.crop)} (${widget.crop})', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0)),
//                  SizedBox(height:20),
//                  Divider(color:Colors.grey),
                  Text(
                    'Total Area: ${widget.totalSize} ha',
                    style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ],
              ),
            ),

            StreamBuilder<QuerySnapshot>(
                stream: getFarmStreamSnapshots(context),
                builder: (context, snapshot) {
                  if(!snapshot.hasData) return Center(child: CircularProgressIndicator());
                  return new Expanded(
                      child: Center(
                        child: Container(
                          constraints: BoxConstraints(maxWidth: 700),
                          child: ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (BuildContext context, int index){
                              return Card(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child:Row(
                                        children: [
//                                  Text('${snapshot.data.documents[index]['farmName']} (${snapshot.data.documents[index]['farmSize']} ha)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                                          RichText(
                                            text: TextSpan(
                                              style: TextStyle(color:Colors.black),
                                              children: <TextSpan>[
                                                TextSpan(text: '${snapshot.data.documents[index]['farmName']} (${snapshot.data.documents[index]['farmSize']} ha)\n', style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16.0)),
                                                TextSpan(text: snapshot.data.documents[index]['location'], style: TextStyle(color: Colors.grey[700])),
                                              ],
                                            ),
                                          ),
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
                                              choiceAction(value,snapshot.data.documents[index]);
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
//                                  GestureDetector(
//                                    onTap: () {},
//                                    child: Icon(
//                                        Icons.more_horiz
//                                    ),
//                                  ),
                                        ],
                                      ),
                                    ),
                                    //title
                                    Divider(height:0),
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
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
                                                                MaterialPageRoute(builder: (context) => AddPlantingDataInner(farmName:snapshot.data.documents[index]['farmName'],cropPlanted:snapshot.data.documents[index]['cropsPlanted'], farmID: snapshot.data.documents[index].documentID, record: null )),
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
                                                                MaterialPageRoute(builder: (context) => AddHarvestingDataInner(farmName:snapshot.data.documents[index]['farmName'],cropPlanted:snapshot.data.documents[index]['cropsPlanted'], farmID: snapshot.data.documents[index].documentID , record: null )),
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
                                                                    (recordSnapshot.data.documents[0]['plantedDate'] != null) ? DateFormat('MMM dd, yyyy').format(recordSnapshot.data.documents[0]['plantedDate'].toDate()) : '+ Add Entry',
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
                                                                            MaterialPageRoute(builder: (context) => AddPlantingDataInner(farmName:snapshot.data.documents[index]['farmName'],cropPlanted:snapshot.data.documents[index]['cropsPlanted'], farmID: snapshot.data.documents[index].documentID , record: recordSnapshot.data.documents[0])),
                                                                          );
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
                                                                MaterialPageRoute(builder: (context) => AddPlantingDataInner(farmName:snapshot.data.documents[index]['farmName'],cropPlanted:snapshot.data.documents[index]['cropsPlanted'], farmID: snapshot.data.documents[index].documentID , record: recordSnapshot.data.documents[0])),
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
                                                                    (recordSnapshot.data.documents[0]['harvestDate'] != null) ? DateFormat('MMM dd, yyyy').format(recordSnapshot.data.documents[0]['harvestDate'].toDate()) : '+ Add Entry',
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
                                                                            MaterialPageRoute(builder: (context) => AddHarvestingDataInner(farmName:snapshot.data.documents[index]['farmName'],cropPlanted:snapshot.data.documents[index]['cropsPlanted'], farmID: snapshot.data.documents[index].documentID , record: recordSnapshot.data.documents[0])),
                                                                          );
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
                                                                MaterialPageRoute(builder: (context) => AddHarvestingDataInner(farmName:snapshot.data.documents[index]['farmName'],cropPlanted:snapshot.data.documents[index]['cropsPlanted'], farmID: snapshot.data.documents[index].documentID , record: recordSnapshot.data.documents[0])),
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
                                      ),
                                    ), //body
                                    Divider(height:0),
                                    InkWell(
                                        child: Container(padding:EdgeInsets.all(15),child:Text("View all records", style: TextStyle(color: Colors.blue),), alignment: Alignment.center),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => Records(farmData: snapshot.data.documents[index])),
                                          );

                                        }
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      )
                  );
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
    var result = await Provider.of(context).db.collection('userData').document(uid).collection('farms').document(farmId).collection('records').orderBy('plantedDate',descending: true).limit(1).getDocuments();
    return result.documents;
  }

  _deleteRecordData(uid,farmId,recordId) async {
    await Provider.of(context).db.collection('userData').document(uid).collection('farms').document(farmId).collection('records').document(recordId).delete();
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
