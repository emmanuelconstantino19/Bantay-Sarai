import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:bantay_sarai/screens/damage_reporting/get_coordinates.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:badges/badges.dart';

class DamageDetails extends StatefulWidget {
  final List<String> selectedCrops;
  final details;
  DamageDetails({Key key, @required this.selectedCrops, this.details}) : super(key: key);

  @override
  _DamageDetailsState createState() => _DamageDetailsState();
}

class _DamageDetailsState extends State<DamageDetails> {
  String cause, otherCause, sizeUnit = 'sqm';
  DateTime _lossDate, _estimatedHarvestDate;
  TextEditingController _extentOfLossController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if(widget.details!=null) {
      cause = widget.details['causeOfLoss'];

      _lossDate = widget.details['dateOfLoss'].toDate();

      var extent = widget.details['extentOfLoss'].split(' ');
      _extentOfLossController.text = extent[0];
      sizeUnit = extent[1];

      _estimatedHarvestDate = widget.details['estimatedDOH'].toDate();

    }
  }

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
          title: Text('Details'),
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/10, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("Selected crops of damage farm", style: TextStyle(fontSize:18)),
                  Text(widget.selectedCrops.toString().substring(1,widget.selectedCrops.toString().length-1)),
                  SizedBox(height:20),
                  Text("Cause of loss", style: TextStyle(fontSize:18)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal:5, vertical: 5),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                cause = 'Typhoon (pagbagyo)';
                              });
                            },
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: Image(image: AssetImage('assets/damage_reporting/typhoon.png')),
                                      ),
                                    ),

                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Badge(
                                          badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: cause=='Typhoon (pagbagyo)',)
                                    )
                                  ],
                                ),
                                Text('Typhoon', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:18), textAlign: TextAlign.center,),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal:5, vertical: 5),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                cause = 'Localized wind damage (sira dulot ng malakas na hangin)';
                              });
                            },
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: Image(image: AssetImage('assets/damage_reporting/wind damage.png')),
                                      ),
                                    ),

                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Badge(
                                          badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: cause=="Localized wind damage (sira dulot ng malakas na hangin)",)
                                    )
                                  ],
                                ),
                                Text('Wind Damage', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:18), textAlign: TextAlign.center,),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal:5, vertical: 5),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                cause = 'Fire (pagkasunog)';
                              });
                            },
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: Image(image: AssetImage('assets/damage_reporting/fire.png')),
                                      ),
                                    ),

                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Badge(
                                          badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: cause=='Fire (pagkasunog)',)
                                    )
                                  ],
                                ),
                                Text('Fire', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:18), textAlign: TextAlign.center,),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal:5, vertical: 5),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                cause = 'Pest & Diseases (mga peste at sakit)';
                              });
                            },
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: Image(image: AssetImage('assets/damage_reporting/pest and disease.png')),
                                      ),
                                    ),

                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Badge(
                                          badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: cause=='Pest & Diseases (mga peste at sakit)',)
                                    )
                                  ],
                                ),
                                Text('Pest & Disease', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:18), textAlign: TextAlign.center,),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal:5, vertical: 5),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                cause = 'Flood / flashfloods (matinding pagbaha)';
                              });
                            },
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: Image(image: AssetImage('assets/damage_reporting/flood_too much rain.png')),
                                      ),
                                    ),

                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Badge(
                                          badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: cause == 'Flood / flashfloods (matinding pagbaha)',)
                                    )
                                  ],
                                ),
                                Text('Flood', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:18), textAlign: TextAlign.center,),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal:5, vertical: 5),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                cause = 'Ashfall / volcanic eruption (pagputok ng bulkan)';
                              });
                            },
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: Image(image: AssetImage('assets/damage_reporting/Ashfall Volcanic Eruption.png')),
                                      ),
                                    ),

                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Badge(
                                          badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: cause == 'Ashfall / volcanic eruption (pagputok ng bulkan)',)
                                    )
                                  ],
                                ),
                                Text('Ashfall / Volcanic Eruption', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:18), textAlign: TextAlign.center,),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal:5, vertical: 5),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                cause = 'Drought (matinding tagtuyot)';
                              });
                            },
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: Image(image: AssetImage('assets/damage_reporting/Drought.png')),
                                      ),
                                    ),

                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Badge(
                                          badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: cause == 'Drought (matinding tagtuyot)',)
                                    )
                                  ],
                                ),
                                Text('Drought', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:18), textAlign: TextAlign.center,),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal:5, vertical: 5),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                cause = 'Landslide (pagguho ng lupa)';
                              });
                            },
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: Image(image: AssetImage('assets/damage_reporting/landslide.png')),
                                      ),
                                    ),

                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Badge(
                                          badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: cause == 'Landslide (pagguho ng lupa)',)
                                    )
                                  ],
                                ),
                                Text('Landslide', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:15), textAlign: TextAlign.center,),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal:5, vertical: 5),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                cause = 'Other rare meteorological phenomena (e.g. lightning strikes, hail, etc.)';
                              });
                            },
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: Image(image: AssetImage('assets/damage_reporting/Rare meteorological phe.png')),
                                      ),
                                    ),

                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Badge(
                                          badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: cause == 'Other rare meteorological phenomena (e.g. lightning strikes, hail, etc.)',)
                                    )
                                  ],
                                ),
                                Text('Rare meteorological phenomena', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:15), textAlign: TextAlign.center,),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height:20),
                  Card(
                    clipBehavior: Clip.antiAlias,
                    child: ListTile(
//                            leading: Icon(Icons.arrow_drop_down_circle),
                      title: const Text('Date of Loss'),
                      subtitle: _lossDate == null ? Row(
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
                          DateFormat('MMMM dd, yyyy').format(_lossDate)
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
//                            errorInvalidText:'haha',
//                            errorFormatText: 'hehe'
                          ).then((date) {
                            setState((){
                              _lossDate = date;
                            });
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height:20),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                            validator: (val) => val.isEmpty ? 'field required' : null,
                            keyboardType: TextInputType.number,
                            decoration: new InputDecoration(
                                border: OutlineInputBorder(),
                                fillColor: Colors.white,
                                filled: true,
                                labelText: 'Estimated extent of Loss / Damage'),
                            controller: _extentOfLossController
                        ),
                      ),
                      SizedBox(width:10),
                      DropdownButton<String>(
                        value: sizeUnit,
//                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
//                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 0,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            sizeUnit = newValue;
                          });
                         },
                        items: <String>['sqm', 'ha']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    ],
                  ),

                  SizedBox(height:20),
                  Card(
                    clipBehavior: Clip.antiAlias,
                    child: ListTile(
//                            leading: Icon(Icons.arrow_drop_down_circle),
                      title: const Text('Estimated date of harvest'),
                      subtitle: _estimatedHarvestDate == null ? Row(
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
                          DateFormat('MMMM dd, yyyy').format(_estimatedHarvestDate)
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
                  SizedBox(height:20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text('Proceed'),
                          ),
                          onPressed: () {
                            if(_formKey.currentState.validate() && _estimatedHarvestDate!=null && _lossDate!=null){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => GetCoordinates(selectedCrops: widget.selectedCrops, causeOL: (cause=='Others') ? otherCause : cause,dateOL: _lossDate,extentOL: '${_extentOfLossController.text} ${sizeUnit}',estimatedDOH: _estimatedHarvestDate, details: widget.details)),
                              );
                            } else{
                              showToast('Please complete the form.', Colors.red);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
