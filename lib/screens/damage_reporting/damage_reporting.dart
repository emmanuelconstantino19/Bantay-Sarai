import 'package:flutter/material.dart';
import 'package:bantay_sarai/widgets/provider_widget.dart';
import 'package:bantay_sarai/screens/damage_reporting/choose_crop.dart';
import 'package:bantay_sarai/screens/damage_reporting/damage_reporting_item.dart';
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
  _getDamageReportingData() async {
    final uid = await Provider.of(context).auth.getCurrentUID();
    var result = await Provider.of(context)
        .db
        .collection('userData')
        .document(uid)
        .collection('damageReporting').getDocuments();

    return result.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Damage Reporting'),
          centerTitle: true,
          elevation: 0,
        ),
        body: FutureBuilder(
          future: _getDamageReportingData(),
          builder: (content, snapshot){
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.data.length == 0){
              return Center(child: Text("No reports uploaded yet", style: TextStyle(fontSize: 18),),);
            }
            return ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DamageReportingItem(details: snapshot.data[index])),
                    );
                  },
                  child: CustomListItemTwo(
                    thumbnail: Image.network(snapshot.data[index]['urls'][0]),
                    title: snapshot.data[index]['causeOfLoss'],
                    subtitle: 'Extent of loss is ${snapshot.data[index]['extentOfLoss']}.\n'
                        'Estimated date of harvest is ${DateFormat('MMMM dd, yyyy').format(snapshot.data[index]['estimatedDOH'].toDate())}',
                    author: 'Crops: ${snapshot.data[index]['crops'].join(', ')}',
                    publishDate: DateFormat('MMMM dd, yyyy').format(snapshot.data[index]['dateOfLoss'].toDate()),
                    readDuration: '',
                  )
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
