import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:bantay_sarai/screens/damage_reporting/get_coordinates.dart';

class DamageDetails extends StatefulWidget {
  final List<String> selectedCrops;
  DamageDetails({Key key, @required this.selectedCrops}) : super(key: key);

  @override
  _DamageDetailsState createState() => _DamageDetailsState();
}

class _DamageDetailsState extends State<DamageDetails> {
  String cause;
  DateTime _lossDate, _estimatedHarvestDate;
  TextEditingController _extentOfLossController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Details'),
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text("Selected crops of damage farm", style: TextStyle(fontSize:18)),
                Text(widget.selectedCrops.toString().substring(1,widget.selectedCrops.toString().length-1)),
                SizedBox(height:10),
                DropdownButtonFormField<String>(
                  validator: (value) => value == null ? 'field required' : null,
                  value: cause,
                  decoration: new InputDecoration(
                      border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                      labelText: 'Cause of loss'),
                  onChanged: (String newValue) {
                    setState(() {
                      cause = newValue;
                    });
                  },
                  items: <String>[
                    'Typhoon',
                    'Earthquake',
                  ]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height:10),
                Card(
                  clipBehavior: Clip.antiAlias,
                  child: ListTile(
//                            leading: Icon(Icons.arrow_drop_down_circle),
                    title: const Text('Date of Loss'),
                    subtitle: Text(
                      _lossDate == null? 'Please pick a date' : DateFormat('MMMM dd, yyyy').format(_lossDate),
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
                            _lossDate = date;
                          });
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height:10),
                TextFormField(
                    validator: (val) => val.isEmpty ? 'field required' : null,
//                      keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Extent of Loss / Damage'),
                    controller: _extentOfLossController
                ),
                SizedBox(height:10),
                Card(
                  clipBehavior: Clip.antiAlias,
                  child: ListTile(
//                            leading: Icon(Icons.arrow_drop_down_circle),
                    title: const Text('Estimated date of harvest'),
                    subtitle: Text(
                      _estimatedHarvestDate == null? 'Please pick a date' : DateFormat('MMMM dd, yyyy').format(_estimatedHarvestDate),
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
                            _estimatedHarvestDate = date;
                          });
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height:10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text('Proceed'),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => GetCoordinates(selectedCrops: widget.selectedCrops, causeOL: cause,dateOL: _lossDate,extentOL: _extentOfLossController.text,estimatedDOH: _estimatedHarvestDate)),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }
}
