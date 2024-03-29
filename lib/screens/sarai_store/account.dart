import 'package:bantay_sarai/screens/sarai_store/add_tokens.dart';
import 'package:flutter/material.dart';
import 'section_title.dart';
import '../../../constants.dart';
import 'package:bantay_sarai/models/ethereum_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Account extends StatefulWidget {
  final bool isSeller;

  const Account({ Key key, @required this.isSeller }) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  EthereumUtils ethUtils = EthereumUtils();
  final db = FirebaseFirestore.instance;

  var _data;
  @override
  void initState() {
    ethUtils.initial();
    if(widget.isSeller){
      ethUtils.getBalanceSeller().then((value) {
        setState(() {
          _data = value;
        });
      });
    }
    else{
      ethUtils.getBalance().then((value) {
      setState(() {
        _data = value;
      });
    });
    }
    
    super.initState();
  }

  Stream<QuerySnapshot> getReportsStreamSnapshots(BuildContext context) async* {
    //final uid = await Provider.of(context).auth.getCurrentUID();
    yield* FirebaseFirestore.instance.collection('transactions').orderBy('createdAt',descending: true).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Account"),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          child: Column(children: [
            Card(
                  elevation: 4.0,
                  margin: EdgeInsets.only(top: 10.0, bottom: 5.0),
                  color: Color(0xffFFFFFF),
                  child: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Column(
                      children: [
                        Row(
                        children: [
                          const Icon(
                            Icons.account_balance_wallet,
                            color: Colors.green,
                          ),
                          SizedBox(width:15),
                          Text(
                            "Wallet",
                            style: Theme.of(context).textTheme.subtitle1.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          Expanded(child: Container(),),
                          IconButton(
                            icon: const Icon(Icons.refresh,color: Colors.green,),
                            tooltip: 'Refresh',
                            onPressed: () {
                              if(widget.isSeller){
                                ethUtils.getBalanceSeller().then((value) {
                                  setState(() {
                                    _data = value;
                                  });
                                });
                              }
                              else{
                                ethUtils.getBalance().then((value) {
                                setState(() {
                                  _data = value;
                                });
                              });
                              }
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.add,color: Colors.green,),
                            tooltip: 'Cash In',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AddTokens(isSeller : widget.isSeller),
                                ));
                            },
                          ),
                        ],
                      ),
                      SizedBox(height:20),
                      _data == null ? CircularProgressIndicator() : Text("${_data} SRB", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black),),
                      ],
                    )
                ),
                ),
                Card(
                  elevation: 4.0,
                  margin: EdgeInsets.only(top: 10.0,bottom:1.0),
                  color: Color(0xffFFFFFF),
                  child: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Column(
                      children: [
                        Row(
                        children: [
                          const Icon(
                            Icons.shopping_cart,
                            color: Colors.green,
                          ),
                          SizedBox(width:15),
                          Text(
                            "Purchases",
                            style: Theme.of(context).textTheme.subtitle1.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                      ]
                    )
                  )
                ),
                Expanded(
                  child: StreamBuilder(
                              stream: (widget.isSeller) ? null : getReportsStreamSnapshots(context),
                              builder: (content, snapshot){
                                if (!snapshot.hasData) {
                                  return Center(child: CircularProgressIndicator());
                                }
                                if (snapshot.data.docs.length == 0){
                                  return Center(child: Text("No transactions yet", style: TextStyle(fontSize: 18),),);
                                }
                                return ListView.builder(
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border(bottom: BorderSide(color: Colors.grey[300]))),
                                      child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                                      child: SizedBox(
                                        height: 120,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            AspectRatio(
                                              aspectRatio: 1.0,
                                              child: Image.network(snapshot.data.docs[index]['items'][0]['image']),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 1,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                          Text(
                                                            snapshot.data.docs[index]['status'],
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              color: (snapshot.data.docs[index]['status']=="Unavailable" || snapshot.data.docs[index]['status']=="Order Declined") ? Colors.red : Colors.green,
                                                            ),
                                                          ),
                                                          (snapshot.data.docs[index]['status']=="Order Declined") ? Text("Please contact admin to resolve issue", style: TextStyle(color: Colors.red)) : Container(),
                                                          const Padding(padding: EdgeInsets.only(bottom: 2.0)),
                                                          Text(
                                                            "Total: " + snapshot.data.docs[index]['total'].toString() + " SRB",
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: const TextStyle(
                                                              fontSize: 12.0,
                                                              color: Colors.black54,
                                                            ),
                                                          ),
                                                          Text(
                                                            "Purchased: " + DateFormat('MMMM dd, yyyy').format(snapshot.data.docs[index]['createdAt'].toDate()),
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: const TextStyle(
                                                              fontSize: 12.0,
                                                              color: Colors.black54,
                                                            ),
                                                          ),
                                                          Text(
                                                            snapshot.data.docs[index]['items'].length.toString() + " item/s",
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: const TextStyle(
                                                              fontSize: 12.0,
                                                              color: Colors.black54,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    (snapshot.data.docs[index]['status']=="Ready for pick up") ? Expanded(
                                                      child: Row(
                                                      children: [
                                                        ElevatedButton(
                                                                      child: Padding(
                                                                        padding: EdgeInsets.all(16.0),
                                                                        child: Text('Received'),
                                                                      ),
                                                                      onPressed: () async {
                                                                        // save data to firebase
                                                                          await db.collection("transactions").doc(snapshot.data.docs[index].id).update({
                                                                            'status': 'Order Completed'
                                                                          }).then((value) async {
                                                                            await ethUtils.sendEthTo('0xD8656D09eD56b632af530863838287a022103f5B',snapshot.data.docs[index]['total']);
                                                                              print("Successful!");
                                                                              final snackBar = SnackBar(
                                                                              content: const Text('Order Completed!'),
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
                                                                          });
                                                                        }
                                                                    ),
                                                                    SizedBox(width:20),
                                                                    OutlinedButton(
                                                                      child: Padding(
                                                                        padding: EdgeInsets.all(16.0),
                                                                        child: Text('Return'),
                                                                      ),
                                                                      onPressed: () async {
                                                                        // for(var item in snapshot.data.docs[index]['items']){
                                                                        //   print(item);
                                                                        //   var itemRecord = await db.collection("storeItems").doc(item['id']).get();
                                                                        //   print(item['stock']);
                                                                        //   await db.collection("storeItems").doc(itemRecord.id).update({
                                                                        //     'stock': (int.parse(itemRecord['stock']) + item['toBuy']).toString(),
                                                                        //     'sold' : itemRecord['sold'] - item['toBuy']
                                                                        //   });
                                                                        // }
                                                                        await db.collection("transactions").doc(snapshot.data.docs[index].id).update({
                                                                            'status': 'Order Declined'
                                                                          }).then((value) async {
                                                                            //await ethUtils.sendEthTo('0x117B981aDf15C784a671A863031154f8fbe84647',snapshot.data.docs[index]['total']);
                                                                              print("Order Declined!");
                                                                              final snackBar = SnackBar(
                                                                              content: const Text('Order Declined!'),
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
                                                                          });
                                                                      },
                                                                    ),
                                                      ],
                                                    ),
                                                    ) : Container(),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    );
                                  }
                                );
                              }
                            ),
                ),
          ],),
        )
    );
  }
}