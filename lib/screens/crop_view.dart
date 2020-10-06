import 'package:flutter/material.dart';
import 'package:bantay_sarai/widgets/provider_widget.dart';
import 'package:bantay_sarai/models/User.dart';
import 'package:bantay_sarai/models/Farm.dart';

class CropView extends StatefulWidget {
  final String crop, totalSize;
  CropView({Key key, @required this.crop, this.totalSize}) : super(key: key);

  @override
  _CropViewState createState() => _CropViewState();
}

class _CropViewState extends State<CropView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        appBar: AppBar(
//          //title: Text(""),
//          elevation: 1,
//        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height:40),
            Padding(
              padding: EdgeInsets.symmetric(horizontal:20),
              child: InkWell(
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.grey,
                ),
                onTap: () {Navigator.pop(context);},
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image(
                      image: AssetImage('assets/images/'+ widget.crop.toLowerCase() +'1_light.png'),
                      height: 170,
                      //width: double.infinity,
                      //fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height:20),
                  Text('${filipinoTerm(widget.crop)} (${widget.crop})', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0)),
                  SizedBox(height:20),
                  Divider(color:Colors.blue),
                  SizedBox(height:10),
                  Text(
                    'TOTAL: ${widget.totalSize} ha',
                    style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ],
              ),
            ),

            FutureBuilder(
                future: _getFarmData(),
                builder: (context, snapshot) {
                  if(!snapshot.hasData) return Center(child: CircularProgressIndicator());
                  return new Expanded(child: new ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index){
                      String key = snapshot.data.keys.elementAt(index);
                      return new Column(
                        children: [
                      Card(
                        child: ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            title:
                            Text('$key (${snapshot.data[key].farmSize} ha)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height:10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 30),
                                        decoration: BoxDecoration(
                                            color:Color(0xffE9F4F9), borderRadius: BorderRadius.circular(15)),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: Text(
                                                "Petsa ng \nPagtanim:",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xff5A6C64)),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Center(
                                              child: Text(
                                                "JUL 01, 2020",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xff5A6C64)),
                                              ),
                                            ),
                                        ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 30),
                                        decoration: BoxDecoration(
                                            color: Color(0xffEAFAF0), borderRadius: BorderRadius.circular(15)),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: Text(
                                                "Petsa ng \nPag-aani:",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xff5A6C64)),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Center(
                                              child: Text(
                                                "DEC 01, 2020",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xff5A6C64)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ))
                    ),
                        ],
                      );
                    },

                  ));
                }
            ),
          ],
        )
    );
  }

  filipinoTerm(crop) {
    Map cropTerms = {
      'Banana':'Saging',
      'Cacao':'Kakaw',
      'Coconut' : 'Niyog',
      'Coffee' : 'Kape',
      'Corn' : 'Mais',
      'Rice' : 'Palay',
      'Soybean' : 'Soybean',
      'Sugarcane' : 'Tubo',
      'Tomato' : 'Kamatis'
    };
    return cropTerms[crop];
  }

  _getFarmData() async {
    Map map1 = {};
    List<Farm> farms;
    final uid = await Provider.of(context).auth.getCurrentUID();
    await Provider.of(context)
        .db
        .collection('userData')
        .document(uid)
        .collection('farms').where('cropsPlanted', isEqualTo: widget.crop).getDocuments().then((result) {
      result.documents.forEach((f){
        map1[f.data['farmName']] = Farm(f.data['farmName'],f.data['cropsPlanted'],f.data['annualIncome'],f.data['location'],f.data['farmSize'],f.data['farmType'],f.data['organicPractitioner'],f.data['farmOwnership']);
      });
    });

//    var doc_ref = await Provider.of(context)
//        .db
//        .collection('userData')
//        .document(uid)
//        .collection('farms').getDocuments();
//
//    print(doc_ref.documents[1].documentID);
    //print(farms);

    return map1;
  }
}
