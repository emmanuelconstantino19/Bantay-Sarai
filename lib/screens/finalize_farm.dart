import 'package:flutter/material.dart';
import 'package:bantay_sarai/models/Farm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bantay_sarai/widgets/provider_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FinalizeFarm extends StatelessWidget {
  final db = Firestore.instance;

  final Farm farm;
  FinalizeFarm({Key key, @required this.farm}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Finalize Farm Profile'),
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Farm name: ${farm.farmName}"),
                Text("Crops Planted: ${farm.cropsPlanted}"),
                Text("Gross Annual Income Last Year: ${farm.annualIncome}"),
                Text("Location: ${farm.location}"),
                Text("Farm Size: ${farm.farmSize}"),
                Text("Farm Type: ${farm.farmType}"),
                Text("Organic Practitioner: ${farm.organicPractitioner}"),
                Text("Farm Ownership: ${farm.farmOwnership}"),

                RaisedButton(
                  child: Text("Finish"),
                  onPressed: () async {
                    // save data to firebase
                    final uid = await Provider.of(context).auth.getCurrentUID();
                    await db.collection("userData").document(uid).collection("farms").add(farm.toJson());
                    showToast('Successfully Added Farm!', Colors.grey[700]);
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                ),
              ],
            )
        )
    );
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
}