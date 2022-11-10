import 'package:flutter/material.dart';
import 'package:bantay_sarai/widgets/provider_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';

import 'package:uuid/uuid.dart';

class AddItem extends StatefulWidget {
  const AddItem({ Key key }) : super(key: key);

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  String category, unit;
  final db = FirebaseFirestore.instance;
  TextEditingController _itemNameController = new TextEditingController();
  TextEditingController _itemDescController = new TextEditingController();
  TextEditingController _itemStockController = new TextEditingController();
  TextEditingController _itemPriceController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  File image;
  Future pickImage(context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 20);
    if(image == null) return;
    final imageTemp = File(image.path);
    setState(() => this.image = imageTemp);
    Navigator.of(context).pop();
  }

  Future <String> _uploadphotofile() async {
    String fileID = Uuid().v4();
    final  Reference storageReference = FirebaseStorage.instance.ref().child("products");
    UploadTask uploadTask = storageReference.child("product_$fileID.jpg").putFile(image);

    String url = await (await uploadTask).ref.getDownloadURL();
    return url;
  }


  buildAddRecordDialog(BuildContext context){
    return showDialog<String>(
      context: context,
      barrierDismissible: true, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState){
              return AlertDialog(
                //title: Text('Weather Forecast'),
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(8.0)),
                content: Container(
                    child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
//                            Align(
//                              alignment: Alignment(1, 0),
//                              child: InkWell(
//                                onTap: () {
//                                  Navigator.pop(context);
//                                },
//                                child: Container(
//                                  child: Icon(
//                                    Icons.close,
//                                    color: Colors.grey[300],
//                                  ),
//                                ),
//                              ),
//                            ),
//                            SizedBox(height: 10),
                            Center(
                              child: Text(
                                'Choose source of image',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal:20.0),
                              child: SizedBox(
                                width: double.infinity,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side: BorderSide(color: Colors.blue[600])
                                  ),
                                  color: Colors.blue[400],
                                  onPressed: () {
                                    // Navigator.pop(context);
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(builder: (context) => AddPlantingDataInner(farmName: farmName,cropPlanted: cropPlanted, farmID: farmId , record: null)),
                                    // );
                                  },
                                  textColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical:15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width:10),
                                      Text('Camera',style:TextStyle(fontSize:15)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal:20.0),
                              child: SizedBox(
                                width: double.infinity,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side: BorderSide(color: Colors.green[600])
                                  ),
                                  color: Colors.green[400],
                                  onPressed: () async {
                                    // Navigator.pop(context);
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(builder: (context) => AddHarvestingDataInner(farmName: farmName,cropPlanted: cropPlanted, farmID: farmId , record: null)),
                                    // );
                                    await pickImage(context);
                                  },
                                  textColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical:15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.collections,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width:10),
                                      Text('Gallery',style:TextStyle(fontSize:15)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                    )
                ),
//                actions: <Widget>[
//                  FlatButton(
//                    child: Text('Close',
//                      style: TextStyle(color: Colors.grey),
//                    ),
//                    onPressed: () {
//                      Navigator.of(context).pop();
//                    },
//                  ),
//                ],
              );
            }
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Item"),
          centerTitle: true,
          elevation: 1,
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/10, vertical:20),
            child: Form(
                key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (val) => val.isEmpty ? 'field required' : null,
                    //autofocus: true,
                    decoration: new InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Item name'),
                    controller: _itemNameController,
                  ),
                  SizedBox(height:10),
                  TextFormField(
                    validator: (val) => val.isEmpty ? 'field required' : null,
                    //autofocus: true,
                    decoration: new InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Item description'),
                    controller: _itemDescController,
                  ),
                  SizedBox(height:10),
                  TextFormField(
                    validator: (val) => val.isEmpty ? 'field required' : null,
                    keyboardType: TextInputType.number,
                    //autofocus: true,
                    decoration: new InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Stock'),
                    controller: _itemStockController,
                  ),
                  SizedBox(height:10),
                  DropdownButtonFormField<String>(
                    validator: (value) => value == null ? 'field required' : null,
                    value: category,
                    decoration: new InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Category'),
                    onChanged: (String newValue) {
                      setState(() {
                        category = newValue;
                      });
                    },
                    items: <String>[
                      'Banana',
                      'Cacao',
                      'Coconut',
                      'Coffee',
                      'Corn',
                      'Rice',
                      'Soybean',
                      'Sugarcane',
                      'Tomato',
                      'Other Crop'
                    ]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height:10),
                  TextFormField(
                    validator: (val) => val.isEmpty ? 'field required' : null,
                    keyboardType: TextInputType.number,
                    //autofocus: true,
                    decoration: new InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Price'),
                    controller: _itemPriceController,
                  ),
                  SizedBox(height:10),
                  DropdownButtonFormField<String>(
                    validator: (value) => value == null ? 'field required' : null,
                    value: unit,
                    decoration: new InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Unit'),
                    onChanged: (String newValue) {
                      setState(() {
                        unit = newValue;
                      });
                    },
                    items: <String>[
                      'kg',
                      'cavan'
                    ]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height:10),
                  TextFormField(
                    validator: (val) => val.isEmpty ? 'field required' : null,
                    keyboardType: TextInputType.number,
                    //autofocus: true,
                    decoration: new InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Address'),
                    controller: _addressController,
                  ),
                  SizedBox(height:10),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                        onPressed: () {
                          buildAddRecordDialog(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image,
                                color: Colors.blue,
                              ),
                              SizedBox(width:10),
                              Text('Upload image'),
                            ],
                          ),
                        ), style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                        ),),
                      ),
                    ],
                  ),
                  (image == null)
                              ? Container()
                              : Image.file(image),
                  SizedBox(height:10),
                  Row(
                    children: [
                      Expanded(
                        child:
                        ElevatedButton(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text('Add'),
                          ),
                          onPressed: () async {
                            if(_formKey.currentState.validate()){
                              // save data to firebase
                              String fileUrl = await _uploadphotofile();
                              await db.collection("storeItems").add({
                                'name':_itemNameController.text,
                                'description':_itemDescController.text,
                                'category': category,
                                'stock':_itemStockController.text,
                                'price':_itemPriceController.text,
                                'unit': unit,
                                'address':_addressController.text,
                                'sold':0,
                                'imageUrl': fileUrl,
                                'createdAt': FieldValue.serverTimestamp(),
                                'updatedAt': FieldValue.serverTimestamp()
                              });
                              final snackBar = SnackBar(
                                content: const Text('Added to items list successfully!'),
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
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ]
              )
            )
        )
    );
  }
}