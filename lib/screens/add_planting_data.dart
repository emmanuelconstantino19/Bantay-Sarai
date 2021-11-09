import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bantay_sarai/widgets/provider_widget.dart';
import 'package:bantay_sarai/models/Record.dart';

import 'package:fluttertoast/fluttertoast.dart';

class AddPlantingData extends StatefulWidget {
  @override
  _AddPlantingDataState createState() => _AddPlantingDataState();
}


class _AddPlantingDataState extends State<AddPlantingData> {
  final db = Firestore.instance;
  TextEditingController _targetMarketController = new TextEditingController();
  TextEditingController _expectedQtyOfHarvest = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String farmChosen;
  DateTime _landPreparationDate, _seedlingPreparationDate, _plantedDate, _targetDateOfHarvest;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Planting Data"),
          centerTitle: true,
          elevation: 1,
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/10, vertical:20),
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    StreamBuilder<QuerySnapshot>(
                        stream: getFarmStreamSnapshots(context),
                        builder: (context, snapshot) {
                          if(!snapshot.hasData) return Center(child: CircularProgressIndicator());
                          return new DropdownButtonFormField<String>(
                            validator: (value) => value == null ? 'field required' : null,
                            value: farmChosen,
//                            hint: Text('Farms'),
                            decoration: new InputDecoration(
                                border: OutlineInputBorder(),
                                fillColor: Colors.white,
                                filled: true,
                                labelText: 'Farms'),
                            onChanged: (String newValue) {
                              setState(() {
                                farmChosen = newValue;
                              });
                            },
                            items: snapshot.data.documents.map((DocumentSnapshot document) {
                              return new DropdownMenuItem<String>(
                                  value: document.documentID,
                                  child: Text('${document['farmName']} - ${document['cropsPlanted']}')
                              );
                            }).toList(),
                          );
                        }
                    ),
                    SizedBox(height:10),
                    Card(
                      clipBehavior: Clip.antiAlias,
                      child: ListTile(
//                            leading: Icon(Icons.arrow_drop_down_circle),
                        title: const Text('Land Preparation date'),
                        subtitle: _landPreparationDate == null ? Row(
                          children: [
                            Icon(
                                Icons.error,
                                color: Colors.red,
                                size:15
                            ),
                            SizedBox(width:5),
                            Text('Please pick a date')
                          ],
                        ) : Text(
                            DateFormat('MMMM dd, yyyy').format(_landPreparationDate)
                        ),
                        trailing: ElevatedButton.icon(
                          label: Text('Set Date'),
                          icon: Icon(Icons.date_range),
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2018),
                              lastDate: DateTime(2030),
                            ).then((date) {
                              setState((){
                                //_landPreparationDate = DateFormat('MM/dd/yyyy').format(date);
                                _landPreparationDate = date;
                              });
                            });
                          },
                        ),
                      ),
                    ),
                    Card(
                      clipBehavior: Clip.antiAlias,
                      child: ListTile(
//                            leading: Icon(Icons.arrow_drop_down_circle),
                        title: const Text('Seedling Preparation date'),
                        subtitle: _seedlingPreparationDate == null ? Row(
                          children: [
                            Icon(
                                Icons.error,
                                color: Colors.red,
                                size:15
                            ),
                            SizedBox(width:5),
                            Text('Please pick a date')
                          ],
                        ) : Text(
                            DateFormat('MMMM dd, yyyy').format(_seedlingPreparationDate)
                        ),
                        trailing: ElevatedButton.icon(
                          label: Text('Set Date'),
                          icon: Icon(Icons.date_range),
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2018),
                              lastDate: DateTime(2030),
                            ).then((date) {
                              setState((){
                                _seedlingPreparationDate = date;
                              });
                            });
                          },
                        ),
                      ),
                    ),
                    Card(
                      clipBehavior: Clip.antiAlias,
                      child: ListTile(
//                            leading: Icon(Icons.arrow_drop_down_circle),
                        title: const Text('Planted/Transplanted date'),
                        subtitle: _plantedDate == null ? Row(
                          children: [
                            Icon(
                                Icons.error,
                                color: Colors.red,
                                size:15
                            ),
                            SizedBox(width:5),
                            Text('Please pick a date')
                          ],
                        ) : Text(
                            DateFormat('MMMM dd, yyyy').format(_plantedDate)
                        ),
                        trailing: ElevatedButton.icon(
                          label: Text('Set Date'),
                          icon: Icon(Icons.date_range),
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2018),
                              lastDate: DateTime(2030),
                            ).then((date) {
                              setState((){
                                _plantedDate = date;
                              });
                            });
                          },
                        ),
                      ),
                    ),
                    Card(
                      clipBehavior: Clip.antiAlias,
                      child: ListTile(
//                            leading: Icon(Icons.arrow_drop_down_circle),
                        title: const Text('Target date of harvest'),
                        subtitle: _targetDateOfHarvest == null ? Row(
                          children: [
                            Icon(
                                Icons.error,
                                color: Colors.red,
                                size:15
                            ),
                            SizedBox(width:5),
                            Text('Please pick a date')
                          ],
                        ) : Text(
                            DateFormat('MMMM dd, yyyy').format(_targetDateOfHarvest)
                        ),
                        trailing: ElevatedButton.icon(
                          label: Text('Set Date'),
                          icon: Icon(Icons.date_range),
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2018),
                              lastDate: DateTime(2030),
                            ).then((date) {
                              setState((){
                                _targetDateOfHarvest = date;
                              });
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height:10),
                    TextFormField(
                      validator: (val) => val.isEmpty ? 'field required' : null,
                      //autofocus: true,
                      decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                          labelText: 'Target market'),
                      controller: _targetMarketController,
                    ),
                    SizedBox(height:10),
                    TextFormField(
                        validator: (val) => val.isEmpty ? 'field required' : null,
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Expected quantity of harvest (cavan/kg)'),
                        controller: _expectedQtyOfHarvest
                    ),
                    SizedBox(height:10),
                    Row(
                      children: [
                        Expanded(
                          child:
                          ElevatedButton(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text('Submit'),
                            ),
                            onPressed: () async {
                              if(_formKey.currentState.validate() && _landPreparationDate!=null && _seedlingPreparationDate!=null && _plantedDate!=null && _targetDateOfHarvest!=null){
                                Record record = new Record(_landPreparationDate, _seedlingPreparationDate, _plantedDate, _targetDateOfHarvest, _targetMarketController.text, _expectedQtyOfHarvest.text,null,null,null,null,null,null);
                                final uid = await Provider.of(context).auth.getCurrentUID();
                                await db.collection("userData").document(uid).collection("farms").document(farmChosen).collection("records").add(record.toJson());
                                showToast('Successfully added new record.', Colors.green);
                                Navigator.of(context).popUntil((route) => route.isFirst);
                              } else {
                                showToast('Please complete the form.', Colors.red);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
//                    InkWell(
//                      child: Container(
//                        height: 50,
//                        margin: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
//                        decoration: BoxDecoration(
//                            borderRadius: BorderRadius.circular(10),
//                            color: Colors.black,
//                            boxShadow: [
//                              BoxShadow(
//                                offset: const Offset(1.0, 1.0),
//                                blurRadius: 5.0,
//                              ),
//                            ]
//                        ),
//                        child: Center(
//                          child: Text("Submit", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
//                        ),
//                      ),
//                      onTap: () async {
//                        if(_formKey.currentState.validate()){
//                          Record record = new Record(_landPreparationDate, _seedlingPreparationDate, _plantedDate, _targetDateOfHarvest, _targetMarketController.text, _expectedQtyOfHarvest.text,null,null,null,null,null,null);
//                          final uid = await Provider.of(context).auth.getCurrentUID();
//                          await db.collection("userData").document(uid).collection("farms").document(farmChosen).collection("records").add(record.toJson());
//                          Navigator.of(context).popUntil((route) => route.isFirst);
//                        }
//                      },
//                    ),
                  ],
                )
            )
        )
    );
  }

  Stream<QuerySnapshot> getFarmStreamSnapshots(BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance.collection('userData').document(uid).collection('farms').snapshots();
  }
}


class AddPlantingDataInner extends StatefulWidget {
  final String farmName, cropPlanted, farmID;
  final record;

  AddPlantingDataInner({Key key, @required this.farmName, @required this.cropPlanted, @required this.farmID, @required this.record}) : super(key: key);

  @override
  _AddPlantingDataInnerState createState() => _AddPlantingDataInnerState();
}

class _AddPlantingDataInnerState extends State<AddPlantingDataInner> {
  final db = Firestore.instance;
  TextEditingController _targetMarketController = new TextEditingController();
  TextEditingController _expectedQtyOfHarvest = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String farmChosen;
  DateTime _landPreparationDate, _seedlingPreparationDate, _plantedDate, _targetDateOfHarvest;

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

  @override
  void initState() {
    super.initState();
    if(widget.record!=null && widget.record['plantedDate']!=null) {
      print(widget.record);
      _landPreparationDate = widget.record['landPreparationDate']!=null ? widget.record['landPreparationDate'].toDate() : null;
      _seedlingPreparationDate = widget.record['seedlingPreparationDate']!=null ? widget.record['seedlingPreparationDate'].toDate() : null;
      _plantedDate = widget.record['plantedDate']!=null ? widget.record['plantedDate'].toDate() : null;
      _targetDateOfHarvest = widget.record['targetDateOfHarvest']!=null ? widget.record['targetDateOfHarvest'].toDate() : null;
      _targetMarketController.text = widget.record['targetMarket'];
      _expectedQtyOfHarvest.text =  widget.record['expectedQtyOfHarvest'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Planting Data"),
          centerTitle: true,
          elevation: 1,
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/10, vertical:20),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Farm Name: ${widget.farmName} (${widget.cropPlanted})', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                          SizedBox(height:16),
//                          Text('Crop: ${widget.cropPlanted}', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                          Text('Please fill in the information needed below.'),
                        ],
                      ),
                    ),
                    Card(
                      clipBehavior: Clip.antiAlias,
                      child: ListTile(
//                            leading: Icon(Icons.arrow_drop_down_circle),
                        title: const Text('Land Preparation date'),
                        subtitle: _landPreparationDate == null ? Row(
                          children: [
                            Icon(
                                Icons.error,
                                color: Colors.red,
                                size:15
                            ),
                            SizedBox(width:5),
                            Text('Please pick a date')
                          ],
                        ) : Text(
                            DateFormat('MMMM dd, yyyy').format(_landPreparationDate)
                        ),
                        trailing: ElevatedButton.icon(
                          label: Text('Set Date'),
                          icon: Icon(Icons.date_range),
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2018),
                              lastDate: DateTime(2030),
                            ).then((date) {
                              setState((){
                                //_landPreparationDate = DateFormat('MM/dd/yyyy').format(date);
                                _landPreparationDate = date;
                              });
                            });
                          },
                        ),
                      ),
                    ),
                    Card(
                      clipBehavior: Clip.antiAlias,
                      child: ListTile(
//                            leading: Icon(Icons.arrow_drop_down_circle),
                        title: const Text('Seedling preparation date'),
                        subtitle: _seedlingPreparationDate == null ? Row(
                          children: [
                            Icon(
                                Icons.error,
                                color: Colors.red,
                                size:15
                            ),
                            SizedBox(width:5),
                            Text('Please pick a date')
                          ],
                        ) : Text(
                            DateFormat('MMMM dd, yyyy').format(_seedlingPreparationDate)
                        ),
                        trailing: ElevatedButton.icon(
                          label: Text('Set Date'),
                          icon: Icon(Icons.date_range),
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2018),
                              lastDate: DateTime(2030),
                            ).then((date) {
                              setState((){
                                _seedlingPreparationDate = date;
                              });
                            });
                          },
                        ),
                      ),
                    ),
                    Card(
                      clipBehavior: Clip.antiAlias,
                      child: ListTile(
//                            leading: Icon(Icons.arrow_drop_down_circle),
                        title: const Text('Planted/Transplanted date'),
                        subtitle: _plantedDate == null ? Row(
                          children: [
                            Icon(
                                Icons.error,
                                color: Colors.red,
                                size:15
                            ),
                            SizedBox(width:5),
                            Text('Please pick a date')
                          ],
                        ) : Text(
                            DateFormat('MMMM dd, yyyy').format(_plantedDate)
                        ),
                        trailing: ElevatedButton.icon(
                          label: Text('Set Date'),
                          icon: Icon(Icons.date_range),
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2018),
                              lastDate: DateTime(2030),
                            ).then((date) {
                              setState((){
                                _plantedDate = date;
                              });
                            });
                          },
                        ),
                      ),
                    ),
                    Card(
                      clipBehavior: Clip.antiAlias,
                      child: ListTile(
//                            leading: Icon(Icons.arrow_drop_down_circle),
                        title: const Text('Target date of harvest'),
                        subtitle: _targetDateOfHarvest == null ? Row(
                          children: [
                            Icon(
                                Icons.error,
                                color: Colors.red,
                                size:15
                            ),
                            SizedBox(width:5),
                            Text('Please pick a date')
                          ],
                        ) : Text(
                            DateFormat('MMMM dd, yyyy').format(_targetDateOfHarvest)
                        ),
                        trailing: ElevatedButton.icon(
                          label: Text('Set Date'),
                          icon: Icon(Icons.date_range),
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2018),
                              lastDate: DateTime(2030),
                            ).then((date) {
                              setState((){
                                _targetDateOfHarvest = date;
                              });
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height:10),
                    TextFormField(
                      validator: (val) => val.isEmpty ? 'field required' : null,
                      //autofocus: true,
                      decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                          labelText: 'Target market'),
                      controller: _targetMarketController,
                    ),
                    SizedBox(height:10),
                    TextFormField(
                        validator: (val) => val.isEmpty ? 'field required' : null,
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Expected quantity of harvest (cavan/kg)'),
                        controller: _expectedQtyOfHarvest
                    ),
                    SizedBox(height:10),
                    Row(
                      children: [
                        Expanded(
                          child:
                          ElevatedButton(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text('Submit'),
                            ),
                            onPressed: () async {
                              if(_formKey.currentState.validate() && _landPreparationDate!=null && _seedlingPreparationDate!=null && _plantedDate!=null && _targetDateOfHarvest!=null){
                                Record record = new Record(_landPreparationDate, _seedlingPreparationDate, _plantedDate, _targetDateOfHarvest, _targetMarketController.text, _expectedQtyOfHarvest.text,null,null,null,null,null,null);
                                final uid = await Provider.of(context).auth.getCurrentUID();
                                if(widget.record == null){
                                  await db.collection("userData").document(uid).collection("farms").document(widget.farmID).collection("records").add(record.toJson());
                                  showToast('Successfully added new record.', Colors.green);
                                }
                                else{
                                  await db.collection("userData").document(uid).collection("farms").document(widget.farmID).collection("records").document(widget.record.documentID)
                                      .updateData({
                                    'landPreparationDate': _landPreparationDate,
                                    'seedlingPreparationDate': _seedlingPreparationDate,
                                    'plantedDate': _plantedDate,
                                    'targetDateOfHarvest': _targetDateOfHarvest,
                                    'targetMarket': _targetMarketController.text,
                                    'expectedQtyOfHarvest': _expectedQtyOfHarvest.text,
                                  });
                                  showToast('Successfully updated record.', Colors.green);
                                }
                                Navigator.of(context).pop();
                              } else {
                                showToast('Please complete the form.', Colors.red);
                              }
                            },
                          ),
                        ),
                      ],
                    ),

//                    InkWell(
//                      child: Container(
//                        height: 50,
//                        margin: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
//                        decoration: BoxDecoration(
//                            borderRadius: BorderRadius.circular(10),
//                            color: Colors.black,
//                            boxShadow: [
//                              BoxShadow(
//                                offset: const Offset(1.0, 1.0),
//                                blurRadius: 5.0,
//                              ),
//                            ]
//                        ),
//                        child: Center(
//                          child: Text("Submit", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
//                        ),
//                      ),
//                      onTap: () async {
//                        if(_formKey.currentState.validate()){
//                          Record record = new Record(_landPreparationDate, _seedlingPreparationDate, _plantedDate, _targetDateOfHarvest, _targetMarketController.text, _expectedQtyOfHarvest.text,null,null,null,null,null,null);
//                          final uid = await Provider.of(context).auth.getCurrentUID();
//                          if(widget.recordID == null){
//                            await db.collection("userData").document(uid).collection("farms").document(widget.farmID).collection("records").add(record.toJson());
//                          }
//                          else{
//                            await db.collection("userData").document(uid).collection("farms").document(widget.farmID).collection("records").document(widget.recordID)
//                                .updateData({
//                                  'landPreparationDate': _landPreparationDate,
//                                  'seedlingPreparationDate': _seedlingPreparationDate,
//                                  'plantedDate': _plantedDate,
//                                  'targetDateOfHarvest': _targetDateOfHarvest,
//                                  'targetMarket': _targetMarketController.text,
//                                  'expectedQtyOfHarvest': _expectedQtyOfHarvest.text,
//                                });
//                          }
//                          Navigator.of(context).pop();
//                        }
//                      },
//                    ),
                  ],
                )
            )
        )
    );
  }
}
