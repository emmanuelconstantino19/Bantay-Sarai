import 'package:flutter/material.dart';
import 'package:bantay_sarai/models/Farm.dart';
import 'package:bantay_sarai/screens/finalize_farm.dart';
import 'package:intl/intl.dart';

class AddHarvestingData extends StatefulWidget {
  final Farm farm;
  AddHarvestingData({Key key, @required this.farm}) : super(key: key);

  @override
  _AddHarvestingDataState createState() => _AddHarvestingDataState();
}


class _AddHarvestingDataState extends State<AddHarvestingData> {
  String harvestingProcedure;
  TextEditingController _qtyOfHarvestController = new TextEditingController();
  TextEditingController _qtyOfHarvestSoldController = new TextEditingController();
  TextEditingController _grossIncomeController = new TextEditingController();
  TextEditingController _netIncomeController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _harvestDate = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Harvesting data monitoring"),
          elevation: 1,
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text('Harvest date:'),
                    Text(_harvestDate == ''? 'Please pick a date' : _harvestDate),
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
                              _harvestDate = DateFormat('MM/dd/yyyy').format(date);
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
                      onTap: () {
                        if(_formKey.currentState.validate()){
                          Navigator.pop(context);
//                          Navigator.push(
//                            context,
//                            MaterialPageRoute(builder: (context) => FinalizeFarm(farm: widget.farm)),
//                          );
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
