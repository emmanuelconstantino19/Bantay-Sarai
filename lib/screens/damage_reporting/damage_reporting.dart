import 'package:flutter/material.dart';

import 'package:bantay_sarai/screens/damage_reporting/choose_crop.dart';

class DamageReporting extends StatefulWidget {
  @override
  _DamageReportingState createState() => _DamageReportingState();
}

class _DamageReportingState extends State<DamageReporting> {
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
                  Text("Nothing to show")
//                  Text("Pumili ng pananim na napinsala"),
//                  CheckboxListTile(
//                    title: Text("Saging"),
//                    value: checkedValues['saging'],
//                    onChanged: (newValue) {
//                      setState(() {
//                        checkedValues['saging'] = newValue;
//                      });
//                    },
//                    controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
//                  ),
                ],
              ),
            )
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF369d34),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChooseCrop()),
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
