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
          centerTitle: true,
        ),
        body: Center(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                DataTable(
//                  columnSpacing: 15,
                  columns: [
                    DataColumn(label: Text('Fields')),
                    DataColumn(label: Text('Values')),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text("Farm name")),
                      DataCell(Text(farm.farmName)),
                    ]),
                    DataRow(cells: [
                      DataCell(Text("Crops Planted")),
                      DataCell(Text(farm.cropsPlanted)),
                    ]),
                    DataRow(cells: [
                      DataCell(Text("Gross Annual Income Last Year")),
                      DataCell(Text(farm.annualIncome)),
                    ]),
                    DataRow(cells: [
                      DataCell(Text("Location")),
                      DataCell(Text(farm.location)),
                    ]),
                    DataRow(cells: [
                      DataCell(Text("Farm Size")),
                      DataCell(Text(farm.farmSize)),
                    ]),
                    DataRow(cells: [
                      DataCell(Text("Farm Type")),
                      DataCell(Text(farm.farmType)),
                    ]),
                    DataRow(cells: [
                      DataCell(Text("Organic Practitioner")),
                      DataCell(Text(farm.organicPractitioner)),
                    ]),
                    DataRow(cells: [
                      DataCell(Text("Farm Ownership")),
                      DataCell(Text(farm.farmOwnership)),
                    ]),
                  ],
                ),
                Expanded(
                  child: Container()
                ),
                ElevatedButton(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Finish'),
                  ),
                  onPressed: () async {
                    // save data to firebase
                    final uid = await Provider.of(context).auth.getCurrentUID();
                    await db.collection("userData").document(uid).collection("farms").add(farm.toJson());
                    showToast('Successfully Added Farm!', Colors.grey[700]);
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                ),
//                RaisedButton(
//                  child: Text("Finish"),
//                  onPressed: () async {
//                    // save data to firebase
//                    final uid = await Provider.of(context).auth.getCurrentUID();
//                    await db.collection("userData").document(uid).collection("farms").add(farm.toJson());
//                    showToast('Successfully Added Farm!', Colors.grey[700]);
//                    Navigator.of(context).popUntil((route) => route.isFirst);
//                  },
//                ),
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