import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OtherApps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Other Sarai Apps'),
          centerTitle: true,
          elevation: 0,
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Download and discover other apps of Project SARAi"),
                RaisedButton(
                  child: Text("BANATECH"),
                  onPressed: () async {
                    await launch('https://saraiapps.xyz/banana/');
                  },
                ),
                RaisedButton(
                  child: Text("CAPHE"),
                  onPressed: () {
                  },
                ),
                RaisedButton(
                  child: Text("Insect Pest and Disease Advisory System (IPDAS)"),
                  onPressed: () async {
                    await launch('https://saraiapps.xyz/pestlib/');
                  },
                ),
                RaisedButton(
                  child: Text("SPIDTECH"),
                  onPressed: () async {
                    await launch('https://play.google.com/store/apps/details?id=ph.sarai.ipdas.spidtech&hl=en&gl=US');
                  },
                ),
                RaisedButton(
                  child: Text("NUTRIENT MANAGER FOR CORN"),
                  onPressed: () {
                  },
                ),
              ],
            )
        )
    );
  }
}
