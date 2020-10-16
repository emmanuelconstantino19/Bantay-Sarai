import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bantay_sarai/widgets/provider_widget.dart';
import 'package:bantay_sarai/models/Record.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("PLANTING DATA"),
          centerTitle: true,
          elevation: 1,
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
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
                            isExpanded: true,
                            value: farmChosen,
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.black, fontSize:15),
                            hint: Text('Farms'),
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
                    Text('Land preparation date:'),
                    Text(_landPreparationDate == null? 'Please pick a date' : DateFormat('MM/dd/yyyy').format(_landPreparationDate)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.60,
                      child: RaisedButton(
                        child: Text("Pick date"),
                        color: Colors.lightBlue,
                        textColor: Colors.white,
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2018),
                            lastDate: DateTime(2021),
                          ).then((date) {
                            setState((){
                              //_landPreparationDate = DateFormat('MM/dd/yyyy').format(date);
                              _landPreparationDate = date;
                            });
                          });
                        },
                      ),
                    ),
                    Text('Seedling preparation date:'),
                    Text(_seedlingPreparationDate == null? 'Please pick a date' : DateFormat('MM/dd/yyyy').format(_seedlingPreparationDate)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.60,
                      child: RaisedButton(
                        child: Text("Pick date"),
                        color: Colors.lightBlue,
                        textColor: Colors.white,
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2018),
                            lastDate: DateTime(2021),
                          ).then((date) {
                            setState((){
                              _seedlingPreparationDate = date;
                            });
                          });
                        },
                      ),
                    ),
                    Text('Planted/Transplanted date:'),
                    Text(_plantedDate == null? 'Please pick a date' : DateFormat('MM/dd/yyyy').format(_plantedDate)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.60,
                      child: RaisedButton(
                        child: Text("Pick date"),
                        color: Colors.lightBlue,
                        textColor: Colors.white,
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2018),
                            lastDate: DateTime(2021),
                          ).then((date) {
                            setState((){
                              _plantedDate = date;
                            });
                          });
                        },
                      ),
                    ),
                    Text('Target date of harvest:'),
                    Text(_targetDateOfHarvest == null? 'Please pick a date' : DateFormat('MM/dd/yyyy').format(_targetDateOfHarvest)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.60,
                      child: RaisedButton(
                        child: Text("Pick date"),
                        color: Colors.lightBlue,
                        textColor: Colors.white,
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2018),
                            lastDate: DateTime(2021),
                          ).then((date) {
                            setState((){
                              _targetDateOfHarvest = date;
                            });
                          });
                        },
                      ),
                    ),
                    TextFormField(
                      validator: (val) => val.isEmpty ? 'field required' : null,
                      //autofocus: true,
                      decoration: new InputDecoration(
                          labelText: 'Target market'),
                      controller: _targetMarketController,
                    ),
                    TextFormField(
                        validator: (val) => val.isEmpty ? 'field required' : null,
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                            labelText: 'Expected quantity of harvest (cavan/kg)'),
                        controller: _expectedQtyOfHarvest
                    ),
                    SizedBox(height:10),
                    InkWell(
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(1.0, 1.0),
                                blurRadius: 5.0,
                              ),
                            ]
                        ),
                        child: Center(
                          child: Text("Submit", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        ),
                      ),
                      onTap: () async {
                        if(_formKey.currentState.validate()){
                          Record record = new Record(_landPreparationDate, _seedlingPreparationDate, _plantedDate, _targetDateOfHarvest, _targetMarketController.text, _expectedQtyOfHarvest.text,null,null,null,null,null,null);
                          final uid = await Provider.of(context).auth.getCurrentUID();
                          await db.collection("userData").document(uid).collection("farms").document(farmChosen).collection("records").add(record.toJson());
                          Navigator.of(context).popUntil((route) => route.isFirst);
                        }
                      },
                    ),
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
  final String farmName, cropPlanted, farmID, recordID;

  AddPlantingDataInner({Key key, @required this.farmName, @required this.cropPlanted, @required this.farmID, @required this.recordID}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("PLANTING DATA"),
          centerTitle: true,
          elevation: 1,
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text('${widget.farmName} - ${widget.cropPlanted}', style: TextStyle(fontSize: 20)),
                    SizedBox(height:20),
                    Text('Land preparation date:'),
                    Text(_landPreparationDate == null? 'Please pick a date' : DateFormat('MM/dd/yyyy').format(_landPreparationDate)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.60,
                      child: RaisedButton(
                        child: Text("Pick date"),
                        color: Colors.lightBlue,
                        textColor: Colors.white,
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2018),
                            lastDate: DateTime(2021),
                          ).then((date) {
                            setState((){
                              //_landPreparationDate = DateFormat('MM/dd/yyyy').format(date);
                              _landPreparationDate = date;
                            });
                          });
                        },
                      ),
                    ),
                    Text('Seedling preparation date:'),
                    Text(_seedlingPreparationDate == null? 'Please pick a date' : DateFormat('MM/dd/yyyy').format(_seedlingPreparationDate)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.60,
                      child: RaisedButton(
                        child: Text("Pick date"),
                        color: Colors.lightBlue,
                        textColor: Colors.white,
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2018),
                            lastDate: DateTime(2021),
                          ).then((date) {
                            setState((){
                              _seedlingPreparationDate = date;
                            });
                          });
                        },
                      ),
                    ),
                    Text('Planted/Transplanted date:'),
                    Text(_plantedDate == null? 'Please pick a date' : DateFormat('MM/dd/yyyy').format(_plantedDate)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.60,
                      child: RaisedButton(
                        child: Text("Pick date"),
                        color: Colors.lightBlue,
                        textColor: Colors.white,
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2018),
                            lastDate: DateTime(2021),
                          ).then((date) {
                            setState((){
                              _plantedDate = date;
                            });
                          });
                        },
                      ),
                    ),
                    Text('Target date of harvest:'),
                    Text(_targetDateOfHarvest == null? 'Please pick a date' : DateFormat('MM/dd/yyyy').format(_targetDateOfHarvest)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.60,
                      child: RaisedButton(
                        child: Text("Pick date"),
                        color: Colors.lightBlue,
                        textColor: Colors.white,
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2018),
                            lastDate: DateTime(2021),
                          ).then((date) {
                            setState((){
                              _targetDateOfHarvest = date;
                            });
                          });
                        },
                      ),
                    ),
                    TextFormField(
                      validator: (val) => val.isEmpty ? 'field required' : null,
                      //autofocus: true,
                      decoration: new InputDecoration(
                          labelText: 'Target market'),
                      controller: _targetMarketController,
                    ),
                    TextFormField(
                        validator: (val) => val.isEmpty ? 'field required' : null,
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                            labelText: 'Expected quantity of harvest (cavan/kg)'),
                        controller: _expectedQtyOfHarvest
                    ),
                    SizedBox(height:10),
                    InkWell(
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(1.0, 1.0),
                                blurRadius: 5.0,
                              ),
                            ]
                        ),
                        child: Center(
                          child: Text("Submit", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        ),
                      ),
                      onTap: () async {
                        if(_formKey.currentState.validate()){
                          Record record = new Record(_landPreparationDate, _seedlingPreparationDate, _plantedDate, _targetDateOfHarvest, _targetMarketController.text, _expectedQtyOfHarvest.text,null,null,null,null,null,null);
                          final uid = await Provider.of(context).auth.getCurrentUID();
                          if(widget.recordID == null){
                            await db.collection("userData").document(uid).collection("farms").document(widget.farmID).collection("records").add(record.toJson());
                          }
                          else{
                            await db.collection("userData").document(uid).collection("farms").document(widget.farmID).collection("records").document(widget.recordID)
                                .updateData({
                                  'landPreparationDate': _landPreparationDate,
                                  'seedlingPreparationDate': _seedlingPreparationDate,
                                  'plantedDate': _plantedDate,
                                  'targetDateOfHarvest': _targetDateOfHarvest,
                                  'targetMarket': _targetMarketController.text,
                                  'expectedQtyOfHarvest': _expectedQtyOfHarvest.text,
                                });
                          }
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ],
                )
            )
        )
    );
  }
}
