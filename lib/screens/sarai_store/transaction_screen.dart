import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionScreen extends StatefulWidget {
  final transaction;
  const TransactionScreen({ Key key, @required this.transaction }) : super(key: key);

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  String status;
  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    status = widget.transaction['status'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Transaction"),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            SizedBox(height:10),
            DropdownButtonFormField<String>(
              validator: (value) => value == null ? 'field required' : null,
              value: status,
              decoration: new InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                  labelText: 'Status'),
              onChanged: (String newValue) {
                setState(() {
                  status = newValue;
                });
              },
              items: <String>[
                'To Prepare',
                'Ready for pick up',
                'Unavailable',
              ]
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Text(
              "Sample sample sample"
            ),
            SizedBox(height:10),
                  Row(
                    children: [
                      Expanded(
                        child:
                        ElevatedButton(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text('Update'),
                          ),
                          onPressed: () async {
                              // save data to firebase
                              await db.collection("transactions").doc(widget.transaction.id).update({
                                'status': status
                              });
                              Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
          ])
      )
    );
  }
}