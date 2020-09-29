import 'package:flutter/material.dart';
import 'package:bantay_sarai/models/Farm.dart';
import 'package:bantay_sarai/screens/finalize_farm.dart';

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
          elevation: 1,
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: Form(
                key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (val) => val.isEmpty ? 'field required' : null,
                    autofocus: true,
                    decoration: new InputDecoration(
                        labelText: 'Farm name'),
                    controller: _farmNameController,
                  ),
                  DropdownButtonFormField<String>(
                    validator: (value) => value == null ? 'field required' : null,
                    isExpanded: true,
                    value: cropPlanted,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.black, fontSize:15),
                    hint: Text('Crop Planted'),
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
                    ]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  TextFormField(
                      validator: (val) => val.isEmpty ? 'field required' : null,
                      autofocus: true, keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                          labelText: 'Gross Annual Income Last Year'),
                      controller: _annualIncomeController
                  ),
                  DropdownButtonFormField<String>(
                    validator: (value) => value == null ? 'field required' : null,
                    isExpanded: true,
                    value: location,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.black, fontSize:15),
                    hint: Text('Location'),
                    onChanged: (String newValue) {
                      setState(() {
                        location = newValue;
                      });
                    },
                    items: <String>[
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
                  TextFormField(
                      validator: (val) => val.isEmpty ? 'field required' : null,
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                          labelText: 'Farm Size (ha)'),
                      controller: _farmSizeController
                  ),
                  DropdownButtonFormField<String>(
                    validator: (value) => value == null ? 'field required' : null,
                    isExpanded: true,
                    value: farmType,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.black, fontSize:15),
                    hint: Text('Farm Type'),
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
                    isExpanded: true,
                    value: farmOwnership,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.black, fontSize:15),
                    hint: Text('Farm Ownership'),
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
                    onTap: () {
                      if(_formKey.currentState.validate()){
                        widget.farm.farmName = _farmNameController.text;
                        widget.farm.cropsPlanted = cropPlanted;
                        widget.farm.annualIncome = _annualIncomeController.text;
                        widget.farm.location = location;
                        widget.farm.farmSize = _farmSizeController.text;
                        widget.farm.farmType = farmType;
                        widget.farm.organicPractitioner = _choice;
                        widget.farm.farmOwnership = farmOwnership;
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FinalizeFarm(farm: widget.farm)),
                        );
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
