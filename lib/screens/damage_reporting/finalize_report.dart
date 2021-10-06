import 'package:flutter/material.dart';

class FinalizeReport extends StatefulWidget {
  @override
  _FinalizeReportState createState() => _FinalizeReportState();
}

class _FinalizeReportState extends State<FinalizeReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Finalize Report'),
          centerTitle: true,
          elevation: 0,
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
                      DataCell(Text('haha')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text("Crops Planted")),
                      DataCell(Text('haha')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text("Gross Annual Income Last Year")),
                      DataCell(Text('haha')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text("Location")),
                      DataCell(Text('haha')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text("Farm Size")),
                      DataCell(Text('haha')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text("Farm Type")),
                      DataCell(Text('haha')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text("Organic Practitioner")),
                      DataCell(Text('haha')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text("Farm Ownership")),
                      DataCell(Text('haha')),
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
}
