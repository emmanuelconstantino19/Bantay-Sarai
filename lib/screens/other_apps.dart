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
          child: Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: 600),
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
                        Image.network('https://drive.google.com/uc?export=view&id=1BWKxxxHlMHohPAc_af8JZjWsQrOjej_Y', fit: BoxFit.fitWidth, height:300),
                        SizedBox(height:20),
//                      Image.asset('assets/card-sample-image-2.jpg'),
                      ],
                    ),
                  ),
//                  Card(
//                    clipBehavior: Clip.antiAlias,
//                    child: Column(
//                      children: [
//                        ListTile(
//                          leading: Icon(Icons.mobile_friendly),
//                          title: const Text('CAPHE'),
//                          subtitle: Text(
//                            'SARAi Mobile Application',
//                            style: TextStyle(color: Colors.black.withOpacity(0.6)),
//                          ),
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.all(16.0),
//                          child: Text(
//                            'A mobile application which can help extension workers to calculate and
//                              track the harvest dates of their coffee crops.',
//                            style: TextStyle(color: Colors.black.withOpacity(0.6)),
//                          ),
//                        ),
//                        ButtonBar(
//                          alignment: MainAxisAlignment.start,
//                          children: [
//                            TextButton(
//                              style: ButtonStyle(
//                                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
//                              ),
//                              onPressed: () {
////                            await launch('https://saraiapps.xyz/banana/');
//                              },
//                              child: const Text('DOWNLOAD'),
//                            ),
////                          TextButton(
////                            style: ButtonStyle(
////                              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
////                            ),
////                            onPressed: () {
////                              // Perform some action
////                            },
////                            child: const Text('ACTION 2'),
////                          ),
//                          ],
//                        ),
//                        Image.network('https://drive.google.com/uc?export=view&id=1FrIbrsAjtCSC6OCRsEJMjSkRNZwcbUFA', fit: BoxFit.fitWidth, height:300),
//                        SizedBox(height:20),
////                      Image.asset('assets/card-sample-image-2.jpg'),
//                      ],
//                    ),
//                  ),
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
                        Image.network('https://drive.google.com/uc?export=view&id=1IuT4oiKoNGFo9VVWNEbcdSRhgbvkMdlx', fit: BoxFit.fitWidth, height:300),
                        SizedBox(height:20),
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
                        Image.network('https://drive.google.com/uc?export=view&id=1hHhTV6MRaJc10yAeKX71axXPKO-R3mB2', fit: BoxFit.fitWidth, height:300),
                        SizedBox(height:20),
//                      Image.asset('assets/card-sample-image-2.jpg'),
                      ],
                    ),
                  ),
                  Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.web),
                          title: const Text('SARAi Knowledge Portal'),
                          subtitle: Text(
                            'SARAi Web Application',
                            style: TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'The SARAi Knowledge Portal offers a wide range of agricultural services on web and mobile platforms for its priority crops: rice, corn, banana, coconut, coffee, cacao, sugarcane, tomato, and soybean.',
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
                                await launch('https://sarai.ph/');
                              },
                              child: const Text('VISIT'),
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
                        Image.network('https://drive.google.com/uc?export=view&id=1n91Dkj8GkC9Fq17oQk3Y_i56wL_VY5nX', fit: BoxFit.fitWidth, height:300),
                        SizedBox(height:20),
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
            ),
          )
        )
    );
  }
}
