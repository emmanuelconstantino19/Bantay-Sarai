import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OtherApps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SARAi Applications'),
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
//              Padding(
//                padding: const EdgeInsets.all(16.0),
//                child: Text("Download and discover other apps of Project SARAi"),
//              ),

              Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.mobile_friendly),
                      title: const Text('BanaTech'),
                      subtitle: Text(
                        'SARAi Web and Mobile Application',
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Banana Harvest Date Calculator. Know when to harvest Lakatan and Saba bananas based on local weather',
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                          ),
                          onPressed: () async {
                            await launch('https://saraiapps.xyz/banana/');
                          },
                          child: const Text('DOWNLOAD'),
                        ),
//                          TextButton(
//                            style: ButtonStyle(
//                              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
//                            ),
//                            onPressed: () {
//                              // Perform some action
//                            },
//                            child: const Text('ACTION 2'),
//                          ),
                      ],
                    ),
                    Image.asset('assets/screenshots/Banatech.png'),
//                      Image.asset('assets/card-sample-image-2.jpg'),
                  ],
                ),
              ),
              Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.mobile_friendly),
                      title: const Text('CAPHE'),
                      subtitle: Text(
                        'SARAi Mobile Application',
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Coffee Application Harvest Estimator',
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                          ),
                          onPressed: () {
//                            await launch('https://saraiapps.xyz/banana/');
                          },
                          child: const Text('DOWNLOAD'),
                        ),
//                          TextButton(
//                            style: ButtonStyle(
//                              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
//                            ),
//                            onPressed: () {
//                              // Perform some action
//                            },
//                            child: const Text('ACTION 2'),
//                          ),
                      ],
                    ),
                    Image.asset('assets/screenshots/CAPHE.png'),
//                      Image.asset('assets/card-sample-image-2.jpg'),
                  ],
                ),
              ),
              Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.mobile_friendly),
                      title: const Text('Insect Pest and Disease Advisory System (IPDAS)'),
                      subtitle: Text(
                        'SARAi Web and Mobile Application',
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'SARAi Project 2.4 Insect Pest and Disease Advisory System (IPDAS)',
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                          ),
                          onPressed: () async {
                            await launch('https://saraiapps.xyz/pestlib/');
                          },
                          child: const Text('DOWNLOAD'),
                        ),
//                          TextButton(
//                            style: ButtonStyle(
//                              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
//                            ),
//                            onPressed: () {
//                              // Perform some action
//                            },
//                            child: const Text('ACTION 2'),
//                          ),
                      ],
                    ),
                    Image.asset('assets/screenshots/IPDAS.png'),
//                      Image.asset('assets/card-sample-image-2.jpg'),
                  ],
                ),
              ),
              Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.mobile_friendly),
                      title: const Text('SPIDTECH'),
                      subtitle: Text(
                        'SARAi Mobile Application',
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Smarter Pest Identification Technology (SPIDTECH) is a multipurpose android application for digital pest and disease identification. It provides a faster way of pest monitoring in different parts of the Philippines for different agricultural industries. It also helps to bridge the gap between farmers and experts in terms of pest and disease identification and consultation.',
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                          ),
                          onPressed: () async {
                            await launch('https://play.google.com/store/apps/details?id=ph.sarai.ipdas.spidtech&hl=en&gl=US');
                          },
                          child: const Text('DOWNLOAD'),
                        ),
//                          TextButton(
//                            style: ButtonStyle(
//                              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
//                            ),
//                            onPressed: () {
//                              // Perform some action
//                            },
//                            child: const Text('ACTION 2'),
//                          ),
                      ],
                    ),
                    Image.asset('assets/screenshots/SPIDTECH.png'),
//                      Image.asset('assets/card-sample-image-2.jpg'),
                  ],
                ),
              ),
//              Text("Download and discover other apps of Project SARAi"),
//              RaisedButton(
//                child: Text("BANATECH"),
//                onPressed: () async {
//                  await launch('https://saraiapps.xyz/banana/');
//                },
//              ),
//              RaisedButton(
//                child: Text("CAPHE"),
//                onPressed: () {
//                },
//              ),
//              RaisedButton(
//                child: Text("Insect Pest and Disease Advisory System (IPDAS)"),
//                onPressed: () async {
//                  await launch('https://saraiapps.xyz/pestlib/');
//                },
//              ),
//              RaisedButton(
//                child: Text("SPIDTECH"),
//                onPressed: () async {
//                  await launch('https://play.google.com/store/apps/details?id=ph.sarai.ipdas.spidtech&hl=en&gl=US');
//                },
//              ),
//              RaisedButton(
//                child: Text("NUTRIENT MANAGER FOR CORN"),
//                onPressed: () {
//                },
//              ),
            ],
          ),
        )
    );
  }
}
