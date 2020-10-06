import 'package:flutter/material.dart';
import 'package:bantay_sarai/models/Farm.dart';
import 'package:bantay_sarai/screens/finalize_farm.dart';
import 'package:intl/intl.dart';

class AddPlantingData extends StatefulWidget {
  final Farm farm;
  AddPlantingData({Key key, @required this.farm}) : super(key: key);

  @override
  _AddPlantingDataState createState() => _AddPlantingDataState();
}


class _AddPlantingDataState extends State<AddPlantingData> {
  TextEditingController _targetMarketController = new TextEditingController();
  TextEditingController _qtyOfHarvest = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _landPreparationDate = '', _seedlingPreparationDate = '', _plantedDate = '', _targetDateOfHarvest = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Planting data monitoring"),
          elevation: 1,
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text('Land preparation date:'),
                    Text(_landPreparationDate == ''? 'Please pick a date' : _landPreparationDate),
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
                              _landPreparationDate = DateFormat('MM/dd/yyyy').format(date);
                            });
                          });
                        },
                      ),
                    ),
                    Text('Seedling preparation date:'),
                    Text(_seedlingPreparationDate == ''? 'Please pick a date' : _seedlingPreparationDate),
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
                              _seedlingPreparationDate = DateFormat('MM/dd/yyyy').format(date);
                            });
                          });
                        },
                      ),
                    ),
                    Text('Planted/Transplanted date:'),
                    Text(_plantedDate == ''? 'Please pick a date' : _plantedDate),
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
                              _plantedDate = DateFormat('MM/dd/yyyy').format(date);
                            });
                          });
                        },
                      ),
                    ),
                    Text('Target date of harvest:'),
                    Text(_targetDateOfHarvest == ''? 'Please pick a date' : _targetDateOfHarvest),
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
                              _targetDateOfHarvest = DateFormat('MM/dd/yyyy').format(date);
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
                        controller: _qtyOfHarvest
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
