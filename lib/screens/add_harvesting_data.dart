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
  final db = Firestore.instance;
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
          title: Text("Harvesting Data"),
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
                        title: const Text('Harvest date'),
                        subtitle: Text(
                          _harvestDate == null? 'Please pick a date' : DateFormat('MM/dd/yyyy').format(_harvestDate),
                          style: TextStyle(color: Colors.black.withOpacity(0.6)),
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
                                _harvestDate = date;
                              });
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height:10),
                    TextFormField(
                        validator: (val) => val.isEmpty ? 'field required' : null,
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Quantity of harvest (cavan/kg)'),
                        controller: _qtyOfHarvestController
                    ),
                    SizedBox(height:10),
                    TextFormField(
                        validator: (val) => val.isEmpty ? 'field required' : null,
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Quantity of harvest sold/ to be sold (cavan/kg)'),
                        controller: _qtyOfHarvestSoldController
                    ),
                    SizedBox(height:10),
                    TextFormField(
                        validator: (val) => val.isEmpty ? 'field required' : null,
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Gross income (harvest)'),
                        controller: _grossIncomeController
                    ),
                    SizedBox(height:10),
                    TextFormField(
                        validator: (val) => val.isEmpty ? 'field required' : null,
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Net Income (harvest) - minus personal consumption'),
                        controller: _netIncomeController
                    ),
                    SizedBox(height:10),
                    DropdownButtonFormField<String>(
                      validator: (value) => value == null ? 'field required' : null,
                      value: harvestingProcedure,
                      decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                          labelText: 'Harvesting Procedure'),
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
                              if(_formKey.currentState.validate()){
                                Record record = new Record(null,null,null,null,null,null,_harvestDate,_qtyOfHarvestController.text,_qtyOfHarvestSoldController.text,_grossIncomeController.text,_netIncomeController.text,harvestingProcedure);
                                final uid = await Provider.of(context).auth.getCurrentUID();
                                await db.collection("userData").document(uid).collection("farms").document(farmChosen).collection("records").add(record.toJson());
                                Navigator.of(context).popUntil((route) => route.isFirst);
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
//                          Record record = new Record(null,null,null,null,null,null,_harvestDate,_qtyOfHarvestController.text,_qtyOfHarvestSoldController.text,_grossIncomeController.text,_netIncomeController.text,harvestingProcedure);
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

class AddHarvestingDataInner extends StatefulWidget {
  final String farmName, cropPlanted, farmID, recordID;

  AddHarvestingDataInner({Key key, @required this.farmName, @required this.cropPlanted, @required this.farmID, @required this.recordID}) : super(key: key);

  @override
  _AddHarvestingDataInnerState createState() => _AddHarvestingDataInnerState();
}

class _AddHarvestingDataInnerState extends State<AddHarvestingDataInner> {
  final db = Firestore.instance;
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
          title: Text("Harvesting Data"),
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
                        title: const Text('Harvest date'),
                        subtitle: Text(
                            _harvestDate == null? 'Please pick a date' : DateFormat('MM/dd/yyyy').format(_harvestDate),
                          style: TextStyle(color: Colors.black.withOpacity(0.6)),
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
                                _harvestDate = date;
                              });
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height:10),
                    TextFormField(
                        validator: (val) => val.isEmpty ? 'field required' : null,
                        autofocus: true, keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Quantity of harvest (cavan/kg)'),
                        controller: _qtyOfHarvestController
                    ),
                    SizedBox(height:10),
                    TextFormField(
                        validator: (val) => val.isEmpty ? 'field required' : null,
                        autofocus: true, keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Quantity of harvest sold/ to be sold (cavan/kg)'),
                        controller: _qtyOfHarvestSoldController
                    ),
                    SizedBox(height:10),
                    TextFormField(
                        validator: (val) => val.isEmpty ? 'field required' : null,
                        autofocus: true, keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Gross income (harvest)'),
                        controller: _grossIncomeController
                    ),
                    SizedBox(height:10),
                    TextFormField(
                        validator: (val) => val.isEmpty ? 'field required' : null,
                        autofocus: true, keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Net Income (harvest) - minus personal consumption'),
                        controller: _netIncomeController
                    ),
                    SizedBox(height:10),
                    DropdownButtonFormField<String>(
                      validator: (value) => value == null ? 'field required' : null,
                      value: harvestingProcedure,
                      decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                          labelText: 'Harvesting Procedure'),
                      //hint: Text('Harvesting Procedure'),
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
                              if(_formKey.currentState.validate()){
                                Record record = new Record(null,null,null,null,null,null,_harvestDate,_qtyOfHarvestController.text,_qtyOfHarvestSoldController.text,_grossIncomeController.text,_netIncomeController.text,harvestingProcedure);
                                final uid = await Provider.of(context).auth.getCurrentUID();
                                if(widget.recordID == null){
                                  await db.collection("userData").document(uid).collection("farms").document(widget.farmID).collection("records").add(record.toJson());
                                }
                                else{
                                  await db.collection("userData").document(uid).collection("farms").document(widget.farmID).collection("records").document(widget.recordID)
                                      .updateData({
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
//                          Record record = new Record(null,null,null,null,null,null,_harvestDate,_qtyOfHarvestController.text,_qtyOfHarvestSoldController.text,_grossIncomeController.text,_netIncomeController.text,harvestingProcedure);
//                          final uid = await Provider.of(context).auth.getCurrentUID();
//                          if(widget.recordID == null){
//                            await db.collection("userData").document(uid).collection("farms").document(widget.farmID).collection("records").add(record.toJson());
//                          }
//                          else{
//                            await db.collection("userData").document(uid).collection("farms").document(widget.farmID).collection("records").document(widget.recordID)
//                                .updateData({
//                              'harvestDate': _harvestDate,
//                              'qtyOfHarvest': _qtyOfHarvestController.text,
//                              'qtyOfHarvestSold': _qtyOfHarvestSoldController.text,
//                              'grossIncome': _grossIncomeController.text,
//                              'netIncome': _netIncomeController.text,
//                              'harvestingProcedure': harvestingProcedure,
//                            });
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

