import 'package:flutter/material.dart';
import 'package:bantay_sarai/models/ethereum_utils.dart';

class AddTokens extends StatefulWidget {
  final bool isSeller;

  const AddTokens({ Key key, @required this.isSeller}) : super(key: key);

  @override
  _AddTokensState createState() => _AddTokensState();
}

class _AddTokensState extends State<AddTokens> {
  EthereumUtils ethUtils = EthereumUtils();
  TextEditingController _tokenController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    ethUtils.initial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cash In"),
          centerTitle: true,
          elevation: 1,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/10, vertical:20),
          child: Form(
                key: _formKey,
                child: Column(children: [
                  TextFormField(
                    validator: (val) => val.isEmpty ? 'field required' : null,
                    keyboardType: TextInputType.number,
                    //autofocus: true,
                    decoration: new InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Enter amount'),
                    controller: _tokenController,
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
                              if(widget.isSeller){
                                await ethUtils.sendEthTo('0xD8656D09eD56b632af530863838287a022103f5B',int.parse(_tokenController.text));
                              }else{
                                await ethUtils.sendEthTo('0x117B981aDf15C784a671A863031154f8fbe84647',int.parse(_tokenController.text));
                              }
                              final snackBar = SnackBar(
                              content: const Text('Processing cash in. Please wait.'),
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
                ],)
              ),
        )
        
    );
  }
}