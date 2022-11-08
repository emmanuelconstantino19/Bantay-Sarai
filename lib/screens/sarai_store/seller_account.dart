import 'package:bantay_sarai/screens/sarai_store/transaction_screen.dart';
import 'package:flutter/material.dart';
import 'section_title.dart';
import '../../../constants.dart';
import 'package:bantay_sarai/models/ethereum_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class _ArticleDescription extends StatelessWidget {
  const _ArticleDescription({
    Key key,
    @required this.title,
    @required this.subtitle,
    @required this.author,
    @required this.publishDate,
    @required this.readDuration,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String readDuration;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: (title=="Unavailable" || title=="Order Declined") ? Colors.red : Colors.green,
                ),
              ),
              (title=="Order Declined") ? Text("Please contact admin to resolve issue", style: TextStyle(color: Colors.red)) : Container(),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
              Text(
                publishDate,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
              Text(
                author,
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
        // Expanded(
        //   flex: 1,
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: <Widget>[
        //       Text(
        //         author,
        //         style: const TextStyle(
        //           fontSize: 12.0,
        //           color: Colors.black87,
        //         ),
        //       ),
        //       // Text(
        //       //   '$readDuration',
        //       //   style: const TextStyle(
        //       //     fontSize: 12.0,
        //       //     color: Colors.black54,
        //       //   ),
        //       // ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}

class CustomListItemTwo extends StatelessWidget {
  const CustomListItemTwo({
    Key key,
    @required this.thumbnail,
    @required this.title,
    @required this.subtitle,
    @required this.author,
    @required this.publishDate,
    @required this.readDuration,
  }) : super(key: key);

  final Widget thumbnail;
  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String readDuration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.0,
              child: thumbnail,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                child: _ArticleDescription(
                  title: title,
                  subtitle: subtitle,
                  author: author,
                  publishDate: publishDate,
                  readDuration: readDuration,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SellerAccount extends StatefulWidget {
  const SellerAccount({ Key key }) : super(key: key);

  @override
  _SellerAccountState createState() => _SellerAccountState();
}

class _SellerAccountState extends State<SellerAccount> {
  EthereumUtils ethUtils = EthereumUtils();
  var _data;
  @override
  void initState() {
    ethUtils.initial();
    ethUtils.getBalanceSeller().then((value) {
      setState(() {
        _data = value;
      });
    });
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
                  margin: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 5.0),
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
                          )
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
                  margin: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 5.0),
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
                            "Transactions",
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
                              stream: getReportsStreamSnapshots(context),
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
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => TransactionScreen(transaction: snapshot.data.docs[index])),
                                        );
                                      },
                                      child: CustomListItemTwo(
                                          //thumbnail: Image.network(snapshot.data.docs[index]['urls'][0]),
                                          thumbnail: null,
                                          title: snapshot.data.docs[index]['status'],
                                          subtitle: "Total: " + snapshot.data.docs[index]['total'].toString() + " SRB",
                                          author: snapshot.data.docs[index]['items'].length.toString() + " items",
                                          publishDate: "Purchased: " + DateFormat('MMMM dd, yyyy').format(snapshot.data.docs[index]['createdAt'].toDate()),
                                          // readDuration: DateFormat('MMMM dd, yyyy').format(snapshot.data.docs[index]['updatedAt'].toDate()),
                                          //readDuration: snapshot.data.docs[index]['price'],
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