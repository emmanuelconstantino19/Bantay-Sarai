import 'package:flutter/material.dart';
import 'package:bantay_sarai/widgets/provider_widget.dart';

class NewUserProfile extends StatefulWidget {
  @override
  _NewUserProfileState createState() => _NewUserProfileState();
}

class _NewUserProfileState extends State<NewUserProfile> {
  final TextEditingController _fnameControl = new TextEditingController();
  final TextEditingController _lnameControl = new TextEditingController();
  final TextEditingController _mnameControl = new TextEditingController();
  final TextEditingController _mshipControl = new TextEditingController();
  final TextEditingController _bdayControl = new TextEditingController();
  final TextEditingController _placeControl = new TextEditingController();
  final TextEditingController _sexControl = new TextEditingController();
  final TextEditingController _isPWDControl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Farm"),
          elevation: 1,
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _fnameControl,
                  autofocus: true,
                  decoration: new InputDecoration(
                      labelText: 'First Name'),
                ),
                TextField(
                  controller: _lnameControl,
                  autofocus: true,
                  decoration: new InputDecoration(
                      labelText: 'Last Name'),
                ),
                TextField(
                  controller: _mnameControl,
                  autofocus: true,
                  decoration: new InputDecoration(
                      labelText: 'Middle Name'),
                ),
                TextField(
                  controller: _bdayControl,
                  autofocus: true,
                  decoration: new InputDecoration(
                      labelText: 'Date of birth'),
                ),
                TextField(
                  controller: _placeControl,
                  autofocus: true,
                  decoration: new InputDecoration(
                      labelText: 'Place of birth'),
                ),
                TextField(
                  controller: _sexControl,
                  autofocus: true,
                  decoration: new InputDecoration(
                      labelText: 'Sex'),
                ),
                TextField(
                  controller: _isPWDControl,
                  autofocus: true,
                  decoration: new InputDecoration(
                      labelText: 'Person with Disability [Y/N]'),
                ),
                TextField(
                  controller: _mshipControl,
                  autofocus: true,
                  decoration: new InputDecoration(
                      labelText: 'Membership'),
                ),
                SizedBox(height:10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                      color: Colors.blueGrey,
                      padding: EdgeInsets.all(10.0),
                      elevation: 3.0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      onPressed: () {
//                        widget.farm.farmName = _farmNameController.text;
//                        widget.farm.cropsPlanted = _cropsPlantedController.text;
//                        widget.farm.annualIncome = _annualIncomeController.text;
//                        widget.farm.location = _locationController.text;
//                        widget.farm.farmSize = _farmSizeController.text;
//                        widget.farm.farmType = _farmTypeController.text;
//                        widget.farm.organicPractitioner = _organicPractitionerController.text;
//                        widget.farm.farmOwnership = _farmOwnershipController.text;
//                        Navigator.push(
//                          context,
//                          MaterialPageRoute(builder: (context) => FinalizeFarm(farm: widget.farm)),
//                        );
                      },
                    ),
                  ],
                ),

              ],
            )
        )
    );
  }
}
