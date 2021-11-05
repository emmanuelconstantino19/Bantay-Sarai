import 'package:flutter/material.dart';
import 'package:bantay_sarai/models/Farm.dart';
import 'package:bantay_sarai/screens/finalize_farm.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddFarmView extends StatefulWidget {
  final Farm farm;
  AddFarmView({Key key, @required this.farm}) : super(key: key);

  @override
  _AddFarmViewState createState() => _AddFarmViewState();
}


class _AddFarmViewState extends State<AddFarmView> {
  String _choice = 'Yes';
  String cropPlanted, location, farmType, farmOwnership;
  TextEditingController _farmNameController = new TextEditingController();
  TextEditingController _annualIncomeController = new TextEditingController();
  TextEditingController _farmSizeController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Farm"),
          centerTitle: true,
          elevation: 1,
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/10, vertical:20),
            child: Form(
                key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (val) => val.isEmpty ? 'field required' : null,
                    //autofocus: true,
                    decoration: new InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Farm name'),
                    controller: _farmNameController,
                  ),
                  SizedBox(height:10),
                  DropdownButtonFormField<String>(
                    validator: (value) => value == null ? 'field required' : null,
                    value: cropPlanted,
                    decoration: new InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Crop Planted'),
                    onChanged: (String newValue) {
                      setState(() {
                        cropPlanted = newValue;
                      });
                    },
                    items: <String>[
                      'Banana',
                      'Cacao',
                      'Coconut',
                      'Coffee',
                      'Corn',
                      'Rice',
                      'Soybean',
                      'Sugarcane',
                      'Tomato',
                      'Other Crop'
                    ]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height:10),
                  TextFormField(
                      validator: (val) => val.isEmpty ? 'field required' : null,
                      //autofocus: true,
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                          labelText: 'Gross Annual Income Last Year'),
                      controller: _annualIncomeController
                  ),
                  SizedBox(height:10),
                  DropdownButtonFormField<String>(
                    validator: (value) => value == null ? 'field required' : null,
                    value: location,
                    decoration: new InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Location'),
                    onChanged: (String newValue) {
                      setState(() {
                        location = newValue;
                      });
                    },
                    items: <String>[
                      'Bae, Laguna',
                      'Nagcarlan, Laguna',
                      'Pakil, Laguna',
                    ]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height:10),
                  TextFormField(
                      validator: (val) => val.isEmpty ? 'field required' : null,
                      //autofocus: true,
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                          labelText: 'Farm Size (ha)'),
                      controller: _farmSizeController
                  ),
                  SizedBox(height:10),
                  DropdownButtonFormField<String>(
                    validator: (value) => value == null ? 'field required' : null,
                    value: farmType,
                    decoration: new InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Farm Type'),
                    onChanged: (String newValue) {
                      setState(() {
                        farmType = newValue;
                      });
                    },
                    items: <String>[
                      'Irrigated',
                      'Rainfed Upland',
                      'Rainfed Lowland',
                    ]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top:20),
                        child: Text('Are you an organic practioner?',style: TextStyle(color:Colors.grey[600],fontSize: 15),),
                      ),
                      ListTile(
                        title: const Text('Yes'),
                        leading: Radio(
                          value: 'Yes',
                          groupValue: _choice,
                          onChanged: (String value) {
                            setState(() {
                              _choice = value;
                              print(_choice);
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('No'),
                        leading: Radio(
                          value: 'No',
                          groupValue: _choice,
                          onChanged: (String value) {
                            setState(() {
                              _choice = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  DropdownButtonFormField<String>(
                    validator: (value) => value == null ? 'field required' : null,
                    value: farmOwnership,
                    decoration: new InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Farm Ownership'),
                    onChanged: (String newValue) {
                      setState(() {
                        farmOwnership = newValue;
                      });
                    },
                    items: <String>[
                      'Registered Owner',
                      'Tenant',
                      'Lessee',
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
                              widget.farm.farmName = _farmNameController.text;
                              widget.farm.cropsPlanted = cropPlanted;
                              widget.farm.annualIncome = _annualIncomeController.text;
                              widget.farm.location = location;
                              widget.farm.farmSize = _farmSizeController.text;
                              widget.farm.farmType = farmType;
                              widget.farm.organicPractitioner = _choice;
                              widget.farm.farmOwnership = farmOwnership;
                              FocusScopeNode currentFocus = FocusScope.of(context);

                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => FinalizeFarm(farm: widget.farm)),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
//                  Padding(
//                    padding: const EdgeInsets.symmetric(horizontal:40.0),
//                    child: SizedBox(
//                      width: double.infinity,
//                      child: RaisedButton(
//                        shape: RoundedRectangleBorder(
//                            borderRadius: BorderRadius.circular(30.0),
//                            side: BorderSide(color: Colors.lightGreen[700])
//                        ),
//                        color: Colors.lightGreen[700],
//                        onPressed: () {
//                          if(_formKey.currentState.validate()){
//                            widget.farm.farmName = _farmNameController.text;
//                            widget.farm.cropsPlanted = cropPlanted;
//                            widget.farm.annualIncome = _annualIncomeController.text;
//                            widget.farm.location = location;
//                            widget.farm.farmSize = _farmSizeController.text;
//                            widget.farm.farmType = farmType;
//                            widget.farm.organicPractitioner = _choice;
//                            widget.farm.farmOwnership = farmOwnership;
//                            FocusScopeNode currentFocus = FocusScope.of(context);
//
//                            if (!currentFocus.hasPrimaryFocus) {
//                              currentFocus.unfocus();
//                            }
//                            Navigator.push(
//                              context,
//                              MaterialPageRoute(builder: (context) => FinalizeFarm(farm: widget.farm)),
//                            );
//                          }
//                        },
//                        textColor: Colors.white,
//                        padding: const EdgeInsets.symmetric(vertical:15.0),
//                        child: Text('Submit',style:TextStyle(fontSize:15)),
//                      ),
//                    ),
//                  ),
                ],
              )
            )
        )
    );
  }
}
