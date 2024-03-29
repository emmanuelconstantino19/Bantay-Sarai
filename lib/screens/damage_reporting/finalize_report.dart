import 'package:flutter/material.dart';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:bantay_sarai/widgets/provider_widget.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class FinalizeReport extends StatefulWidget {
  final List<String> selectedCrops;
  final String causeOL, extentOL;
  final DateTime dateOL, estimatedDOH;
  final List<File> images;
  final List<Position> coordinates;
  final details;
  FinalizeReport({Key key, @required this.selectedCrops, this.causeOL, this.dateOL, this.extentOL, this.estimatedDOH, this.coordinates, this.images, this.details}) : super(key: key);

  @override
  _FinalizeReportState createState() => _FinalizeReportState();
}

class _FinalizeReportState extends State<FinalizeReport> {
  final db = FirebaseFirestore.instance;
  int uploads = 0;
  bool isUploading = false;

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

  Future uploadPic(BuildContext context) async{
    List<String> downloadUrls = [];
    String downloadUrl;
    for(var i = 0 ; i < widget.images.length; i++){
      String fileName = basename(widget.images[i].path);
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = firebaseStorageRef.putFile(widget.images[i]);
      uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
        switch (taskSnapshot.state) {
          case TaskState.running:
            final progress =
                100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
            print("Upload is $progress% complete.");
            break;
          case TaskState.paused:
            print("Upload is paused.");
            break;
          case TaskState.canceled:
            print("Upload was canceled");
            break;
          case TaskState.error:
            // Handle unsuccessful uploads
            break;
          case TaskState.success:
            // Handle successful uploads on complete
            // ...
            downloadUrl = await taskSnapshot.ref.getDownloadURL();
            downloadUrls.add(downloadUrl);
            setState(() {
              uploads++;
            });
            break;
        }
      });
    }
    if(widget.details!=null){
      updateData(context,downloadUrls);
    }
    else{
      createData(context,downloadUrls);
    }
  }

  deleteReport() async {
    for(var index = 0 ; index < widget.details['urls'].length; index++){
      var imageRef = await FirebaseStorage.instance.refFromURL(widget.details['urls'][index]);
      imageRef.delete();
    }
  }

  void updateData(BuildContext context, List<String> downloadUrls) async {
    final uid = await Provider.of(context).auth.getCurrentUID();
    await db.collection("userData").doc(uid).collection("damageReporting").doc(widget.details.documentID).update({
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
      'createdAt': widget.details['createdAt'],
      'updatedAt': FieldValue.serverTimestamp()
    });
    showToast('Successfully Updated Report!', Colors.grey[700]);
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  void createData(BuildContext context, List<String> downloadUrls) async {
    final uid = await Provider.of(context).auth.getCurrentUID();
    await db.collection("userData").doc(uid).collection("damageReporting").add({
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
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp()
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
          padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/10, vertical: 20),
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
                              '[' + widget.coordinates[0].longitude.toStringAsFixed(3) + ', ' + widget.coordinates[0].latitude.toStringAsFixed(3) + ']',
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
                              '[' + widget.coordinates[1].longitude.toStringAsFixed(3) + ', ' + widget.coordinates[1].latitude.toStringAsFixed(3) + ']',
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
                              '[' + widget.coordinates[3].longitude.toStringAsFixed(3) + ', ' + widget.coordinates[3].latitude.toStringAsFixed(3) + ']',
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
                              '[' + widget.coordinates[2].longitude.toStringAsFixed(3) + ', ' + widget.coordinates[2].latitude.toStringAsFixed(3) + ']',
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
              Visibility(
                child: SizedBox(
                  height:200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.images.length,
                    itemBuilder: (context, index) {
                      return index > 3 ? Image.file(widget.images[index], height:100) : Container();
                    },
                  ),
                ),
                visible: widget.images.length > 4,
              ),
              SizedBox(height:20),
              Row(
                children: [
                  SizedBox(width:5),
                  Expanded(
                    child: ElevatedButton(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(isUploading ?
                          (widget.details==null ?
                          'Please wait... Uploading ${uploads/widget.images.length*100}%' : 'Please wait... Updating ${uploads/widget.images.length*100}%')
                            : 'Finish'),
                      ),
                      onPressed: () {
                        // save data to firebase
                        setState(() {
                          if(!isUploading){
                            if(widget.details!=null) {
                              deleteReport();
                            }
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
