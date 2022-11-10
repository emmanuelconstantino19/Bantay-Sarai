import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bantay_sarai/models/ethereum_utils.dart';

class TransactionScreen extends StatefulWidget {
  final transaction;
  const TransactionScreen({ Key key, @required this.transaction }) : super(key: key);

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  String status;
  final db = FirebaseFirestore.instance;
  List<String> statuses;
  bool isDisabled;
  EthereumUtils ethUtils = EthereumUtils();

  @override
  void initState() {
    ethUtils.initial();
    isDisabled = false;
    status = widget.transaction['status'];
    statuses = [];
    if(status == "Order Declined" || status == "Order Completed"){
      statuses.add(status);
      isDisabled = true;
    }
    statuses.add('To Prepare');
    statuses.add('Ready for pick up');
    statuses.add('Unavailable');
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
              onChanged: (isDisabled) ? null : (String newValue) {
                setState(() {
                  status = newValue;
                });
              },
              items: statuses.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Expanded(
            child: ListView(
                children: <Widget>[
                  for(var i=0;i<widget.transaction['items'].length;i++) dummyDataOfListView(widget.transaction['items'][i]),
                  //for(var item in widget.cart) dummyDataOfListView(item),
                ],
              ),
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
                          onPressed: (isDisabled) ? null : () async {
                              // save data to firebase
                              await db.collection("transactions").doc(widget.transaction.id).update({
                                'status': status
                              });
                              if(status == "Unavailable"){
                                await ethUtils.sendEthTo('0x117B981aDf15C784a671A863031154f8fbe84647',widget.transaction['total']);
                              }
                              final snackBar = SnackBar(
                                content: const Text('Updated status successfully!'),
                                action: SnackBarAction(
                                  label: 'Close',
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                  },
                                ),
                              );

                              // Find the ScaffoldMessenger in the widget tree
                              // and use it to show a SnackBar.
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
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

  dummyDataOfListView(var item) {
    return Container(
        child: Card(
          elevation: 4.0,
          margin: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 5.0),
          color: Color(0xffFFFFFF),
          child: ListTile(
            // on ListItem clicked
            onTap: () {},

            //Image of ListItem
            leading: Container(
              child: Image.network(
                item['image'],
                fit: BoxFit.fitHeight,
              ),
            ),

            // Lists of titles
            title: Container(
              margin: EdgeInsets.only(top: 10.0),
              height: 80.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 2.0),
                    child: Text(
                      item['name'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(bottom: 3.0),
                    child: Text(
                      item['category'],
                      style: TextStyle(
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(bottom: 3.0),
                    child: Text(
                      (int.parse(item['price']) * item['toBuy']).toString() + " SRB",
                      style: TextStyle(
                          color: Color(0xff374ABE)
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}