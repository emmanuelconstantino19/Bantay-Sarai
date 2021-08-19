import 'package:flutter/material.dart';

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
                ],
              ),
            )
        )
    );;
  }
}
