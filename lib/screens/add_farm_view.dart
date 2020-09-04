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
  TextEditingController _farmNameController = new TextEditingController();
  TextEditingController _cropsPlantedController = new TextEditingController();
  TextEditingController _annualIncomeController = new TextEditingController();
  TextEditingController _locationController = new TextEditingController();
  TextEditingController _farmSizeController = new TextEditingController();
  TextEditingController _farmTypeController = new TextEditingController();
  TextEditingController _organicPractitionerController = new TextEditingController();
  TextEditingController _farmOwnershipController = new TextEditingController();

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
                  autofocus: true,
                  decoration: new InputDecoration(
                      labelText: 'Farm name'),
                  controller: _farmNameController,
                ),
                TextField(
                  autofocus: true,
                  decoration: new InputDecoration(
                      labelText: 'Crops Planted'),
                  controller: _cropsPlantedController,
                ),
                TextField(
                  autofocus: true,
                  decoration: new InputDecoration(
                      labelText: 'Gross Annual Income Last Year'),
                  controller: _annualIncomeController
                ),
                TextField(
                  autofocus: true,
                  decoration: new InputDecoration(
                      labelText: 'Location(Barangay & Municipality)'),
                    controller: _locationController
                ),
                TextField(
                  autofocus: true,
                  decoration: new InputDecoration(
                      labelText: 'Farm Size (ha)'),
                  controller: _farmSizeController
                ),
                TextField(
                  autofocus: true,
                  decoration: new InputDecoration(
                      labelText: 'Farm Type (Irrigated, Rainfed Upland, Rainfed Lownland)'),
                  controller: _farmTypeController
                ),
                TextField(
                  autofocus: true,
                  decoration: new InputDecoration(
                      labelText: 'Organic Practitioner [Y/N]'),
                  controller: _organicPractitionerController
                ),
                TextField(
                  autofocus: true,
                  decoration: new InputDecoration(
                      labelText: 'Farm Ownership [Registered Owner, Tenant, Lessee]'),
                  controller: _farmOwnershipController
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
                        widget.farm.farmName = _farmNameController.text;
                        widget.farm.cropsPlanted = _cropsPlantedController.text;
                        widget.farm.annualIncome = _annualIncomeController.text;
                        widget.farm.location = _locationController.text;
                        widget.farm.farmSize = _farmSizeController.text;
                        widget.farm.farmType = _farmTypeController.text;
                        widget.farm.organicPractitioner = _organicPractitionerController.text;
                        widget.farm.farmOwnership = _farmOwnershipController.text;
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FinalizeFarm(farm: widget.farm)),
                        );
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
