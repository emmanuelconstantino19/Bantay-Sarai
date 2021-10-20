import 'package:flutter/material.dart';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:bantay_sarai/widgets/provider_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class FinalizeReport extends StatefulWidget {
  final List<String> selectedCrops;
  final String causeOL, extentOL;
  final DateTime dateOL, estimatedDOH;
  final List<File> images;
  final List<Position> coordinates;
  FinalizeReport({Key key, @required this.selectedCrops, this.causeOL, this.dateOL, this.extentOL, this.estimatedDOH, this.coordinates, this.images}) : super(key: key);

  @override
  _FinalizeReportState createState() => _FinalizeReportState();
}

class _FinalizeReportState extends State<FinalizeReport> {
  final db = Firestore.instance;
  int uploads = 0;
  bool isUploading = false;

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

  Future uploadPic(BuildContext context) async{
    List<String> downloadUrls = [];
    String downloadUrl;
    for(var i = 0 ; i < 4; i++){
      String fileName = basename(widget.images[i].path);
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(widget.images[i]);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

      downloadUrl = await taskSnapshot.ref.getDownloadURL();
      downloadUrls.add(downloadUrl);
      setState(() {
        uploads++;
      });
    }

    createData(context,downloadUrls);
  }

  void createData(BuildContext context, List<String> downloadUrls) async {
    final uid = await Provider.of(context).auth.getCurrentUID();
    await db.collection("userData").document(uid).collection("damageReporting").add({
      'crops':widget.selectedCrops,
      'urls': downloadUrls,
      'coordinate1': [widget.coordinates[0].latitude,widget.coordinates[0].longitude],
      'coordinate2': [widget.coordinates[1].latitude,widget.coordinates[1].longitude],
      'coordinate3': [widget.coordinates[2].latitude,widget.coordinates[2].longitude],
      'coordinate4': [widget.coordinates[3].latitude,widget.coordinates[3].longitude],
      'causeOfLoss': widget.causeOL,
      'dateOfLoss' : widget.dateOL,
      'extentOfLoss': widget.extentOL,
      'estimatedDOH' : widget.estimatedDOH,
      'createdAt': FieldValue.serverTimestamp()
      });
    showToast('Successfully Added Report!', Colors.grey[700]);
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Finalize Report'),
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              DataTable(
//                  columnSpacing: 15,
                columns: [
                  DataColumn(label: Text('Fields')),
                  DataColumn(label: Text('Values')),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text("Selected Crops")),
                    DataCell(Text(widget.selectedCrops.join(', '))),
                  ]),
                  DataRow(cells: [
                    DataCell(Text("Cause of loss")),
                    DataCell(Text(widget.causeOL)),
                  ]),
                  DataRow(cells: [
                    DataCell(Text("Date of loss")),
                    DataCell(Text(DateFormat('MMMM dd, yyyy').format(widget.dateOL))),
                  ]),
                  DataRow(cells: [
                    DataCell(Text("Extent of Loss / Damage")),
                    DataCell(Text(widget.extentOL)),
                  ]),
                  DataRow(cells: [
                    DataCell(Text("Estimated date of harvest")),
                    DataCell(Text(DateFormat('MMMM dd, yyyy').format(widget.estimatedDOH))),
                  ]),
                ],
              ),
              SizedBox(height:20),
              Text('Images and Coordinates', style: TextStyle(fontWeight: FontWeight.bold,),),
              SizedBox(height:10),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          Image.file(widget.images[0], height:100),
                          ListTile(
//                                leading: Icon(Icons.mobile_friendly),
                            title: const Text('Image 1'),
                            subtitle: Text(
                              widget.coordinates[0].longitude.toString() + ',' + widget.coordinates[0].latitude.toString() + ']',
                              style: TextStyle(color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
//                      Image.asset('assets/card-sample-image-2.jpg'),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          Image.file(widget.images[1], height:100),
                          ListTile(
//                                leading: Icon(Icons.mobile_friendly),
                            title: const Text('Image 2'),
                            subtitle: Text(
                              widget.coordinates[1].longitude.toString() + ',' + widget.coordinates[1].latitude.toString() + ']',
                              style: TextStyle(color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
//                      Image.asset('assets/card-sample-image-2.jpg'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          Image.file(widget.images[3], height:100),
                          ListTile(
//                                leading: Icon(Icons.mobile_friendly),
                            title: const Text('Image 4'),
                            subtitle: Text(
                              widget.coordinates[3].longitude.toString() + ',' + widget.coordinates[3].latitude.toString() + ']',
                              style: TextStyle(color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
//                      Image.asset('assets/card-sample-image-2.jpg'),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          Image.file(widget.images[2], height:100),
                          ListTile(
//                                leading: Icon(Icons.mobile_friendly),
                            title: const Text('Image 3'),
                            subtitle: Text(
                              widget.coordinates[2].longitude.toString() + ',' + widget.coordinates[2].latitude.toString() + ']',
                              style: TextStyle(color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
//                      Image.asset('assets/card-sample-image-2.jpg'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(width:5),
                  Expanded(
                    child: ElevatedButton(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(isUploading ? 'Please wait... Uploading ${uploads.toString()}/4 images' : 'Finish'),
                      ),
                      onPressed: () {
                        // save data to firebase
                        setState(() {
                          if(!isUploading){
                            uploadPic(context);
                          }
                          isUploading = true;
                        });
                      },
                    ),
                  ),
                  SizedBox(width:5),
                ],
              ),
              SizedBox(height:10),

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
          ),
        )
    );
  }
}
