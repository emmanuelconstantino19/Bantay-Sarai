import 'package:flutter/material.dart';
import 'package:bantay_sarai/widgets/provider_widget.dart';
import 'package:bantay_sarai/screens/damage_reporting/choose_crop.dart';
import 'package:bantay_sarai/screens/damage_reporting/damage_reporting_item.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:bantay_sarai/widgets/provider_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
                author,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black87,
                ),
              ),
              Text(
                '$publishDate',
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


class DamageReporting extends StatefulWidget {
  @override
  _DamageReportingState createState() => _DamageReportingState();
}

class _DamageReportingState extends State<DamageReporting> {
  Stream<QuerySnapshot> getReportsStreamSnapshots(BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance.collection('userData').document(uid).collection('damageReporting').orderBy('createdAt',descending: true).snapshots();
  }

  deleteReport(report) async {
    final uid = await Provider.of(context).auth.getCurrentUID();
    for(var index = 0 ; index < report['urls'].length; index++){
      var imageRef = await FirebaseStorage.instance.getReferenceFromUrl(report['urls'][index]);
      imageRef.delete();
    }
    await Provider.of(context).db.collection('userData').document(uid).collection('damageReporting').document(report.documentID).delete();
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
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Damage Reporting'),
          centerTitle: true,
          elevation: 0,
        ),
        body: StreamBuilder(
          stream: getReportsStreamSnapshots(context),
          builder: (content, snapshot){
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.data.documents.length == 0){
              return Center(child: Text("No reports uploaded yet", style: TextStyle(fontSize: 18),),);
            }
            return ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(snapshot.data.documents[index].documentID),
                  onDismissed: (direction) {
                    deleteReport(snapshot.data.documents[index]);
                    showToast('Successfully deleted report.', Colors.green);
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DamageReportingItem(details: snapshot.data.documents[index])),
                        );
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
                                      Navigator.of(context).pop();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => ChooseCrop(details: snapshot.data.documents[index])),
                                      );
                                    },
                                  )
                              );
                            },
                          );
                      },
                      child: CustomListItemTwo(
                        thumbnail: Image.network(snapshot.data.documents[index]['urls'][0]),
                        title: snapshot.data.documents[index]['causeOfLoss'],
                        subtitle: 'Extent of loss is ${snapshot.data.documents[index]['extentOfLoss']}.\n'
                            'Estimated date of harvest is ${DateFormat('MMMM dd, yyyy').format(snapshot.data.documents[index]['estimatedDOH'].toDate())}',
                        author: 'Crops: ${snapshot.data.documents[index]['crops'].join(', ')}',
                        publishDate: DateFormat('MMMM dd, yyyy').format(snapshot.data.documents[index]['dateOfLoss'].toDate()),
//                        readDuration: DateFormat('MMMM dd, yyyy').format(snapshot.data.documents[index]['updatedAt'].toDate()),
                        readDuration: '',
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
            MaterialPageRoute(builder: (context) => ChooseCrop()),
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
