import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bantay_sarai/widgets/provider_widget.dart';
import 'package:bantay_sarai/models/Record.dart';
import 'package:intl/intl.dart';

class AddHarvestingData extends StatefulWidget {
  @override
  _AddHarvestingDataState createState() => _AddHarvestingDataState();
}


class _AddHarvestingDataState extends State<AddHarvestingData> {
  final db = FirebaseFirestore.instance;
  String harvestingProcedure, farmChosen;
  TextEditingController _qtyOfHarvestController = new TextEditingController();
  TextEditingController _qtyOfHarvestSoldController = new TextEditingController();
  TextEditingController _grossIncomeController = new TextEditingController();
  TextEditingController _netIncomeController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime _harvestDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("HARVESTING DATA"),
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
                            items: snapshot.data.docs.map((DocumentSnapshot document) {
                              return new DropdownMenuItem<String>(
                                  value: document.id,
                                  child: Text('${document['farmName']} - ${document['cropsPlanted']}')
                              );
                            }).toList(),
                          );
                        }
                    ),
                    Text('Harvest date:'),
                    Text(_harvestDate == null? 'Please pick a date' : DateFormat('MM/dd/yyyy').format(_harvestDate)),
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
                            lastDate: DateTime(2030),
                          ).then((date) {
                            setState((){
                              _harvestDate = date;
                            });
                          });
                        },
                      ),
                    ),
                    TextFormField(
                        validator: (val) => val.isEmpty ? 'field required' : null,
                        autofocus: true, keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                            labelText: 'Quantity of harvest (cavan/kg)'),
                        controller: _qtyOfHarvestController
                    ),
                    TextFormField(
                        validator: (val) => val.isEmpty ? 'field required' : null,
                        autofocus: true, keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                            labelText: 'Quantity of harvest sold/ to be sold (cavan/kg)'),
                        controller: _qtyOfHarvestSoldController
                    ),
                    TextFormField(
                        validator: (val) => val.isEmpty ? 'field required' : null,
                        autofocus: true, keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                            labelText: 'Gross income (harvest)'),
                        controller: _grossIncomeController
                    ),
                    TextFormField(
                        validator: (val) => val.isEmpty ? 'field required' : null,
                        autofocus: true, keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                            labelText: 'Net Income (harvest) - minus personal consumption'),
                        controller: _netIncomeController
                    ),
                    DropdownButtonFormField<String>(
                      validator: (value) => value == null ? 'field required' : null,
                      isExpanded: true,
                      value: harvestingProcedure,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black, fontSize:15),
                      hint: Text('Harvesting Procedure'),
                      onChanged: (String newValue) {
                        setState(() {
                          harvestingProcedure = newValue;
                        });
                      },
                      items: <String>[
                        'Harvester',
                        'Manual',
                      ]
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
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
                          Record record = new Record(null,null,null,null,null,null,_harvestDate,_qtyOfHarvestController.text,_qtyOfHarvestSoldController.text,_grossIncomeController.text,_netIncomeController.text,harvestingProcedure);
                          final uid = await Provider.of(context).auth.getCurrentUID();
                          await db.collection("userData").doc(uid).collection("farms").doc(farmChosen).collection("records").add(record.toJson());
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
    yield* FirebaseFirestore.instance.collection('userData').doc(uid).collection('farms').snapshots();
  }
}

class AddHarvestingDataInner extends StatefulWidget {
  final String farmName, cropPlanted, farmID, recordID;

  AddHarvestingDataInner({Key key, @required this.farmName, @required this.cropPlanted, @required this.farmID, @required this.recordID}) : super(key: key);

  @override
  _AddHarvestingDataInnerState createState() => _AddHarvestingDataInnerState();
}

class _AddHarvestingDataInnerState extends State<AddHarvestingDataInner> {
  final db = FirebaseFirestore.instance;
  String harvestingProcedure;
  TextEditingController _qtyOfHarvestController = new TextEditingController();
  TextEditingController _qtyOfHarvestSoldController = new TextEditingController();
  TextEditingController _grossIncomeController = new TextEditingController();
  TextEditingController _netIncomeController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime _harvestDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("HARVESTING DATA"),
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
                    Text('Harvest date:'),
                    Text(_harvestDate == null? 'Please pick a date' : DateFormat('MM/dd/yyyy').format(_harvestDate)),
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
                            lastDate: DateTime(2030),
                          ).then((date) {
                            setState((){
                              _harvestDate = date;
                            });
                          });
                        },
                      ),
                    ),
                    TextFormField(
                        validator: (val) => val.isEmpty ? 'field required' : null,
                        autofocus: true, keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                            labelText: 'Quantity of harvest (cavan/kg)'),
                        controller: _qtyOfHarvestController
                    ),
                    TextFormField(
                        validator: (val) => val.isEmpty ? 'field required' : null,
                        autofocus: true, keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                            labelText: 'Quantity of harvest sold/ to be sold (cavan/kg)'),
                        controller: _qtyOfHarvestSoldController
                    ),
                    TextFormField(
                        validator: (val) => val.isEmpty ? 'field required' : null,
                        autofocus: true, keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                            labelText: 'Gross income (harvest)'),
                        controller: _grossIncomeController
                    ),
                    TextFormField(
                        validator: (val) => val.isEmpty ? 'field required' : null,
                        autofocus: true, keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                            labelText: 'Net Income (harvest) - minus personal consumption'),
                        controller: _netIncomeController
                    ),
                    DropdownButtonFormField<String>(
                      validator: (value) => value == null ? 'field required' : null,
                      isExpanded: true,
                      value: harvestingProcedure,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black, fontSize:15),
                      hint: Text('Harvesting Procedure'),
                      onChanged: (String newValue) {
                        setState(() {
                          harvestingProcedure = newValue;
                        });
                      },
                      items: <String>[
                        'Harvester',
                        'Manual',
                      ]
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
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
                          Record record = new Record(null,null,null,null,null,null,_harvestDate,_qtyOfHarvestController.text,_qtyOfHarvestSoldController.text,_grossIncomeController.text,_netIncomeController.text,harvestingProcedure);
                          final uid = await Provider.of(context).auth.getCurrentUID();
                          if(widget.recordID == null){
                            await db.collection("userData").doc(uid).collection("farms").doc(widget.farmID).collection("records").add(record.toJson());
                          }
                          else{
                            await db.collection("userData").doc(uid).collection("farms").doc(widget.farmID).collection("records").doc(widget.recordID)
                                .update({
                              'harvestDate': _harvestDate,
                              'qtyOfHarvest': _qtyOfHarvestController.text,
                              'qtyOfHarvestSold': _qtyOfHarvestSoldController.text,
                              'grossIncome': _grossIncomeController.text,
                              'netIncome': _netIncomeController.text,
                              'harvestingProcedure': harvestingProcedure,
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

