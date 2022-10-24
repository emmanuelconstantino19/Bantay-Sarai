import 'package:flutter/material.dart';
import 'package:bantay_sarai/models/ethereum_utils.dart';

class BuyerScreen extends StatefulWidget {
  const BuyerScreen({Key key}) : super(key: key);

  @override
  _BuyerScreenState createState() => _BuyerScreenState();
}

class _BuyerScreenState extends State<BuyerScreen> {

  EthereumUtils ethUtils = EthereumUtils();

  @override
  void initState() {
    ethUtils.initial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("SARAI Store"),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          child: ElevatedButton(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Transfer Tokens'),
                  ),
                  onPressed: () async {
                    await ethUtils.sendEth(7);
                    print("Successful!");
                  },
                ),
        ),
    );
  }
}