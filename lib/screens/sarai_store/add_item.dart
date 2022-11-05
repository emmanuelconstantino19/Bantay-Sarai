import 'package:flutter/material.dart';
import 'package:bantay_sarai/widgets/provider_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddItem extends StatefulWidget {
  const AddItem({ Key key }) : super(key: key);

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final db = FirebaseFirestore.instance;
  TextEditingController _itemNameController = new TextEditingController();
  TextEditingController _itemDescController = new TextEditingController();
  TextEditingController _itemStockController = new TextEditingController();
  TextEditingController _itemPriceController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                              await db.collection("storeItems").add({
                                'name':_itemNameController.text,
                                'description':_itemDescController.text,
                                'stock':_itemStockController.text,
                                'price':_itemPriceController.text,
                                'createdAt': FieldValue.serverTimestamp(),
                                'updatedAt': FieldValue.serverTimestamp()
                              });
                              Navigator.of(context).popUntil((route) => route.isFirst);
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