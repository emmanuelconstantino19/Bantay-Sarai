import 'package:flutter/material.dart';

import 'package:bantay_sarai/screens/damage_reporting/damage_details.dart';

class ChooseCrop extends StatefulWidget {
  @override
  _ChooseCropState createState() => _ChooseCropState();
}

class _ChooseCropState extends State<ChooseCrop> {
//  bool checkedValue = true;
  var checkedValues = {
    'saging': false,
    'kakaw': false,
  };
  List<String> selectedCrops = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Damage Reporting'),
          centerTitle: true,
          elevation: 0,
        ),
        body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Pumili ng pananim na napinsala"),
                  CheckboxListTile(
                    title: Text("Saging"),
                    value: checkedValues['saging'],
                    onChanged: (newValue) {
                      setState(() {
                        checkedValues['saging'] = newValue;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                  ),
                  CheckboxListTile(
                    title: Text("Kakaw"),
                    value: checkedValues['kakaw'],
                    onChanged: (newValue) {
                      setState(() {
                        checkedValues['kakaw'] = newValue;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                  ),
                  ElevatedButton(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Proceed'),
                    ),
                    onPressed: () {
                      selectedCrops = [];
                      checkedValues.keys.forEach((key) {
                        if(checkedValues[key]){
                          selectedCrops.add(key);
                        }
                      });

                      print(selectedCrops);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DamageDetails(selectedCrops: selectedCrops)),
                      );
//                      if(_formKey.currentState.validate()){
//                        Record record = new Record(_landPreparationDate, _seedlingPreparationDate, _plantedDate, _targetDateOfHarvest, _targetMarketController.text, _expectedQtyOfHarvest.text,null,null,null,null,null,null);
//                        final uid = await Provider.of(context).auth.getCurrentUID();
//                        await db.collection("userData").document(uid).collection("farms").document(farmChosen).collection("records").add(record.toJson());
//                        Navigator.of(context).popUntil((route) => route.isFirst);
//                      }

                    },
                  ),
                ],
              ),
            )
        )
    );
  }
}
