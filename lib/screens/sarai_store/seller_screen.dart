import 'package:bantay_sarai/screens/sarai_store/add_item.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bantay_sarai/widgets/provider_widget.dart';
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
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
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
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                "Stock: " + author,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black87,
                ),
              ),
              Text(
                'PHP $readDuration each',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
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

class SellerScreen extends StatefulWidget {
  @override
  _SellerScreenState createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  Stream<QuerySnapshot> getReportsStreamSnapshots(BuildContext context) async* {
    //final uid = await Provider.of(context).auth.getCurrentUID();
    yield* FirebaseFirestore.instance.collection('storeItems').orderBy('createdAt',descending: true).snapshots();
  }

  deleteReport(report) async {
    // final uid = await Provider.of(context).auth.getCurrentUID();
    // for(var index = 0 ; index < report['urls'].length; index++){
    //   var imageRef = await FirebaseStorage.instance.refFromURL(report['urls'][index]);
    //   imageRef.delete();
    // }
    // await Provider.of(context).db.collection('userData').doc(uid).collection('damageReporting').doc(report.id).delete();
  }

  Widget refreshBg() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
          Text('DELETE', style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }

  void showToast(message, Color color) {
    print(message);
    // Fluttertoast.showToast(
    //     msg: message,
    //     toastLength: Toast.LENGTH_LONG,
    //     gravity: ToastGravity.BOTTOM,
    //     backgroundColor: color,
    //     textColor: Colors.white,
    //     fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Seller Dashboard'),
          centerTitle: true,
          elevation: 0,
        ),
        body: StreamBuilder(
          stream: getReportsStreamSnapshots(context),
          builder: (content, snapshot){
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.data.docs.length == 0){
              return Center(child: Text("No items added yet", style: TextStyle(fontSize: 18),),);
            }
            return ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(snapshot.data.docs[index].id),
                  onDismissed: (direction) {
                    //deleteReport(snapshot.data.docs[index]);
                    //showToast('Successfully deleted report.', Colors.green);
                  },
                  confirmDismiss: (DismissDirection direction) async {
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Confirm"),
                          content: const Text("Are you sure you want to delete this item?"),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () => Navigator.of(context).pop(true),
                                child: const Text("DELETE", style:TextStyle(color:Colors.red))
                            ),
                            FlatButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text("CANCEL"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  direction: DismissDirection.endToStart,
                  background: refreshBg(),
                  child: InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => DamageReportingItem(details: snapshot.data.docs[index])),
                        // );
                      },
                      onLongPress: () {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                  height: 50,
                                  color: Colors.white,
                                  child: ElevatedButton(
                                    child: const Text('EDIT DAMAGE REPORT'),
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.zero,
                                            )
                                        )
                                    ),
                                    onPressed: () {
                                      // Navigator.of(context).pop();
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(builder: (context) => ChooseCrop(details: snapshot.data.docs[index])),
                                      // );
                                    },
                                  )
                              );
                            },
                          );
                      },
                      child: CustomListItemTwo(
                        //thumbnail: Image.network(snapshot.data.docs[index]['urls'][0]),
                        thumbnail: null,
                        title: snapshot.data.docs[index]['name'],
                        subtitle: snapshot.data.docs[index]['description'],
                        author: snapshot.data.docs[index]['stock'],
                        publishDate: DateFormat('MMMM dd, yyyy').format(snapshot.data.docs[index]['createdAt'].toDate()),
//                        readDuration: DateFormat('MMMM dd, yyyy').format(snapshot.data.docs[index]['updatedAt'].toDate()),
                        readDuration: snapshot.data.docs[index]['price'],
                      )
                  ),
                );
              },
            );
          }
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF369d34),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddItem()),
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}