import 'package:flutter/material.dart';

import 'package:bantay_sarai/screens/damage_reporting/damage_details.dart';

import 'package:badges/badges.dart';

import 'package:fluttertoast/fluttertoast.dart';


class ChooseCrop extends StatefulWidget {
  final details;
  ChooseCrop({Key key, @required this.details}) : super(key: key);

  @override
  _ChooseCropState createState() => _ChooseCropState();
}

class _ChooseCropState extends State<ChooseCrop> {
//  bool checkedValue = true;
  var checkedValues = {
    'saging': false,
    'kakaw': false,
    'niyog': false,
    'kape': false,
    'mais': false,
    'palay': false,
    'utaw': false,
    'tubo': false,
    'kamatis': false,
    'ampalaya': false,
    'assorted beans': false,
    'avocado': false,
    'carrots': false,
    'rambutan': false,
    'lanzones': false,
    'pechay': false,
    'cucumber': false,
    'gabi': false,
    'papaya': false,
    'okra': false,
    'mustasa': false,
    'mango': false,
    'kamote': false,
    'labanos': false,
    'repolyo': false,
    'chinese cabbage': false,
    'eggplant': false,
    'kangkong': false,
    'honeydew': false,
    'santol': false,
    'sayote': false,
    'sitaw': false,
    'potato': false,
    'calamansi': false,
    'cassava': false,
    'dalanghita/sintunis': false,
    'star apple': false,
    'melon': false,
    'kalabasa': false,
    'watermelon': false,
    'cabbage': false,
  };
  List<String> selectedCrops = [];

  @override
  void initState() {
    super.initState();
    if(widget.details!=null) {
      for (var i = 0; i < widget.details['crops'].length; i++) {
        checkedValues[widget.details['crops'][i]] = true;
      }
    }
  }

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

  Widget makeDismissible({Widget child}) => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () => Navigator.of(context).pop(),
    child: GestureDetector(onTap: () {}, child: child,),
  );

  Widget buildSheet(context,updateState) => makeDismissible(
    child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 1,
        minChildSize: 0.5,
        builder: (_, controller) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: EdgeInsets.all(16),
          child: ListView(
            controller: controller,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          updateState(() {
                            checkedValues['ampalaya'] = !checkedValues['ampalaya'];
                          });
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.lightBlueAccent,
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image(image: AssetImage('assets/hvc/ampalaya.png')),
                                  ),
                                ),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Badge(
                                      badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: checkedValues['ampalaya'],)
                                )
                              ],
                            ),
                            SizedBox(height:5),
                            Text('ampalaya', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:18), textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          updateState(() {
                            checkedValues['assorted beans'] = !checkedValues['assorted beans'];
                          });
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.lightBlueAccent,
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image(image: AssetImage('assets/hvc/assorted beans.png')),
                                  ),
                                ),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Badge(
                                      badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: checkedValues['assorted beans'],)
                                )
                              ],
                            ),
                            SizedBox(height:5),
                            Text('assorted beans', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:18), textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          updateState(() {
                            checkedValues['avocado'] = !checkedValues['avocado'];
                          });
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.lightBlueAccent,
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image(image: AssetImage('assets/hvc/avocado_1.png')),
                                  ),
                                ),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Badge(
                                      badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: checkedValues['avocado'],)
                                )
                              ],
                            ),
                            SizedBox(height:5),
                            Text('avocado', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:18), textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          updateState(() {
                            checkedValues['cabbage'] = !checkedValues['cabbage'];
                          });
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.lightBlueAccent,
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image(image: AssetImage('assets/hvc/cabbage.png')),
                                  ),
                                ),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Badge(
                                      badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: checkedValues['cabbage'],)
                                )
                              ],
                            ),
                            SizedBox(height:5),
                            Text('cabbage', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:18), textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          updateState(() {
                            checkedValues['calamansi'] = !checkedValues['calamansi'];
                          });
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.lightBlueAccent,
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image(image: AssetImage('assets/hvc/calamansi.png')),
                                  ),
                                ),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Badge(
                                      badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: checkedValues['calamansi'],)
                                )
                              ],
                            ),
                            SizedBox(height:5),
                            Text('calamansi', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:18), textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          updateState(() {
                            checkedValues['carrots'] = !checkedValues['carrots'];
                          });
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.lightBlueAccent,
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image(image: AssetImage('assets/hvc/carrots.png')),
                                  ),
                                ),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Badge(
                                      badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: checkedValues['carrots'],)
                                )
                              ],
                            ),
                            SizedBox(height:5),
                            Text('carrots', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:18), textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          updateState(() {
                            checkedValues['cassava'] = !checkedValues['cassava'];
                          });
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.lightBlueAccent,
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image(image: AssetImage('assets/hvc/cassava.png')),
                                  ),
                                ),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Badge(
                                      badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: checkedValues['cassava'],)
                                )
                              ],
                            ),
                            SizedBox(height:5),
                            Text('cassava', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:18), textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          updateState(() {
                            checkedValues['chinese cabbage'] = !checkedValues['chinese cabbage'];
                          });
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.lightBlueAccent,
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image(image: AssetImage('assets/hvc/chinese cabbage.png')),
                                  ),
                                ),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Badge(
                                      badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: checkedValues['chinese cabbage'],)
                                )
                              ],
                            ),
                            SizedBox(height:5),
                            Text('chinese cabbage', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:18), textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          updateState(() {
                            checkedValues['cucumber'] = !checkedValues['cucumber'];
                          });
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.lightBlueAccent,
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image(image: AssetImage('assets/hvc/cucumber.png')),
                                  ),
                                ),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Badge(
                                      badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: checkedValues['cucumber'],)
                                )
                              ],
                            ),
                            SizedBox(height:5),
                            Text('cucumber', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:18), textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          updateState(() {
                            checkedValues['dalanghita/sintunis'] = !checkedValues['dalanghita/sintunis'];
                          });
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.lightBlueAccent,
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image(image: AssetImage('assets/hvc/dalanghita.png')),
                                  ),
                                ),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Badge(
                                      badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: checkedValues['dalanghita/sintunis'],)
                                )
                              ],
                            ),
                            SizedBox(height:5),
                            Text('dalanghita/sintunis', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:18), textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          updateState(() {
                            checkedValues['eggplant'] = !checkedValues['eggplant'];
                          });
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.lightBlueAccent,
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image(image: AssetImage('assets/hvc/eggplant.png')),
                                  ),
                                ),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Badge(
                                      badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: checkedValues['eggplant'],)
                                )
                              ],
                            ),
                            SizedBox(height:5),
                            Text('eggplant', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:18), textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          updateState(() {
                            checkedValues['gabi'] = !checkedValues['gabi'];
                          });
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.lightBlueAccent,
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image(image: AssetImage('assets/hvc/gabi.png')),
                                  ),
                                ),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Badge(
                                      badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: checkedValues['gabi'],)
                                )
                              ],
                            ),
                            SizedBox(height:5),
                            Text('gabi', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:18), textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          updateState(() {
                            checkedValues['honeydew'] = !checkedValues['honeydew'];
                          });
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.lightBlueAccent,
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image(image: AssetImage('assets/hvc/honeydew.png')),
                                  ),
                                ),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Badge(
                                      badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: checkedValues['honeydew'],)
                                )
                              ],
                            ),
                            SizedBox(height:5),
                            Text('honeydew', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:18), textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          updateState(() {
                            checkedValues['kalabasa'] = !checkedValues['kalabasa'];
                          });
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.lightBlueAccent,
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image(image: AssetImage('assets/hvc/squash.png')),
                                  ),
                                ),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Badge(
                                      badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: checkedValues['kalabasa'],)
                                )
                              ],
                            ),
                            SizedBox(height:5),
                            Text('kalabasa', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:18), textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          updateState(() {
                            checkedValues['kamote'] = !checkedValues['kamote'];
                          });
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.lightBlueAccent,
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image(image: AssetImage('assets/hvc/kamote.png')),
                                  ),
                                ),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Badge(
                                      badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: checkedValues['kamote'],)
                                )
                              ],
                            ),
                            SizedBox(height:5),
                            Text('kamote', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:18), textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          updateState(() {
                            checkedValues['kangkong'] = !checkedValues['kangkong'];
                          });
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.lightBlueAccent,
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image(image: AssetImage('assets/hvc/kangkong.png')),
                                  ),
                                ),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Badge(
                                      badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: checkedValues['kangkong'],)
                                )
                              ],
                            ),
                            SizedBox(height:5),
                            Text('kangkong', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:18), textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          updateState(() {
                            checkedValues['labanos'] = !checkedValues['labanos'];
                          });
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.lightBlueAccent,
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image(image: AssetImage('assets/hvc/raddish.png')),
                                  ),
                                ),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Badge(
                                      badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: checkedValues['labanos'],)
                                )
                              ],
                            ),
                            SizedBox(height:5),
                            Text('labanos', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:18), textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          updateState(() {
                            checkedValues['lanzones'] = !checkedValues['lanzones'];
                          });
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.lightBlueAccent,
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image(image: AssetImage('assets/hvc/lanzones.png')),
                                  ),
                                ),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Badge(
                                      badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: checkedValues['lanzones'],)
                                )
                              ],
                            ),
                            SizedBox(height:5),
                            Text('lanzones', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:18), textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          updateState(() {
                            checkedValues['mango'] = !checkedValues['mango'];
                          });
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.lightBlueAccent,
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image(image: AssetImage('assets/hvc/mangga.png')),
                                  ),
                                ),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Badge(
                                      badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: checkedValues['mango'],)
                                )
                              ],
                            ),
                            SizedBox(height:5),
                            Text('mango', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:18), textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          updateState(() {
                            checkedValues['melon'] = !checkedValues['melon'];
                          });
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.lightBlueAccent,
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image(image: AssetImage('assets/hvc/melon.png')),
                                  ),
                                ),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Badge(
                                      badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: checkedValues['melon'],)
                                )
                              ],
                            ),
                            SizedBox(height:5),
                            Text('melon', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:18), textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          updateState(() {
                            checkedValues['mustasa'] = !checkedValues['mustasa'];
                          });
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.lightBlueAccent,
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
//                                    child: Image(image: AssetImage('assets/hvc/mustasa.png')),
                                  ),
                                ),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Badge(
                                      badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: checkedValues['mustasa'],)
                                )
                              ],
                            ),
                            SizedBox(height:5),
                            Text('mustasa', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:18), textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          updateState(() {
                            checkedValues['okra'] = !checkedValues['okra'];
                          });
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.lightBlueAccent,
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image(image: AssetImage('assets/hvc/okra.png')),
                                  ),
                                ),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Badge(
                                      badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: checkedValues['okra'],)
                                )
                              ],
                            ),
                            SizedBox(height:5),
                            Text('okra', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:18), textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          updateState(() {
                            checkedValues['papaya'] = !checkedValues['papaya'];
                          });
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.lightBlueAccent,
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image(image: AssetImage('assets/hvc/papaya.png')),
                                  ),
                                ),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Badge(
                                      badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: checkedValues['papaya'],)
                                )
                              ],
                            ),
                            SizedBox(height:5),
                            Text('papaya', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:18), textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          updateState(() {
                            checkedValues['pechay'] = !checkedValues['pechay'];
                          });
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.lightBlueAccent,
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image(image: AssetImage('assets/hvc/pechay.png')),
                                  ),
                                ),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Badge(
                                      badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: checkedValues['pechay'],)
                                )
                              ],
                            ),
                            SizedBox(height:5),
                            Text('pechay', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:18), textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          updateState(() {
                            checkedValues['potato'] = !checkedValues['potato'];
                          });
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.lightBlueAccent,
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image(image: AssetImage('assets/hvc/potato.png')),
                                  ),
                                ),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Badge(
                                      badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: checkedValues['potato'],)
                                )
                              ],
                            ),
                            SizedBox(height:5),
                            Text('potato', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:18), textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          updateState(() {
                            checkedValues['rambutan'] = !checkedValues['rambutan'];
                          });
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.lightBlueAccent,
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image(image: AssetImage('assets/hvc/rambutan.png')),
                                  ),
                                ),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Badge(
                                      badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: checkedValues['rambutan'],)
                                )
                              ],
                            ),
                            SizedBox(height:5),
                            Text('rambutan', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:18), textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          updateState(() {
                            checkedValues['santol'] = !checkedValues['santol'];
                          });
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.lightBlueAccent,
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image(image: AssetImage('assets/hvc/santol.png')),
                                  ),
                                ),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Badge(
                                      badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: checkedValues['santol'],)
                                )
                              ],
                            ),
                            SizedBox(height:5),
                            Text('santol', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:18), textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          updateState(() {
                            checkedValues['sayote'] = !checkedValues['sayote'];
                          });
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.lightBlueAccent,
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image(image: AssetImage('assets/hvc/sayote.png')),
                                  ),
                                ),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Badge(
                                      badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: checkedValues['sayote'],)
                                )
                              ],
                            ),
                            SizedBox(height:5),
                            Text('sayote', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:18), textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          updateState(() {
                            checkedValues['sitaw'] = !checkedValues['sitaw'];
                          });
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.lightBlueAccent,
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image(image: AssetImage('assets/hvc/sitaw.png')),
                                  ),
                                ),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Badge(
                                      badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: checkedValues['sitaw'],)
                                )
                              ],
                            ),
                            SizedBox(height:5),
                            Text('sitaw', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:18), textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          updateState(() {
                            checkedValues['star apple'] = !checkedValues['star apple'];
                          });
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.lightBlueAccent,
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image(image: AssetImage('assets/hvc/starfruit.png')),
                                  ),
                                ),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Badge(
                                      badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: checkedValues['star apple'],)
                                )
                              ],
                            ),
                            SizedBox(height:5),
                            Text('star apple', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:18), textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          updateState(() {
                            checkedValues['watermelon'] = !checkedValues['watermelon'];
                          });
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.lightBlueAccent,
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image(image: AssetImage('assets/hvc/watermelon.png')),
                                  ),
                                ),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Badge(
                                      badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: checkedValues['watermelon'],)
                                )
                              ],
                            ),
                            SizedBox(height:5),
                            Text('watermelon', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:18), textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  Expanded(child: Container()),
                ],
              ),
            ],
          ),
        )
    )
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Damage Reporting'),
          centerTitle: true,
          elevation: 0,
        ),
        body: Center(
            child: SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(maxWidth: 700),
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: <Widget>[
                    SizedBox(height:20),
                    Text("Pumili ng pananim na napinsala", style: TextStyle(fontSize:18)),
                    SizedBox(height:10),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  checkedValues['saging'] = !checkedValues['saging'];
                                });
                              },
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Image(image: AssetImage('assets/images/banana1_light.png')),
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child: Badge(
                                            badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: checkedValues['saging'],)
                                      )
                                    ],
                                  ),
                                  SizedBox(height:5),
                                  Text('saging', style: TextStyle(color:Colors.yellow[800], fontWeight: FontWeight.w700, fontSize:18),),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  checkedValues['kakaw'] = !checkedValues['kakaw'];
                                });
                              },
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Image(image: AssetImage('assets/images/cacao1_light.png')),
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child: Badge(
                                            badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: checkedValues['kakaw'],)
                                      )
                                    ],
                                  ),
                                  SizedBox(height:5),
                                  Text('kakaw', style: TextStyle(color:Colors.brown, fontWeight: FontWeight.w700, fontSize:18),),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  checkedValues['niyog'] = !checkedValues['niyog'];
                                });
                              },
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Image(image: AssetImage('assets/images/coconut1_light.png')),
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child: Badge(
                                            badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: checkedValues['niyog'],)
                                      )
                                    ],
                                  ),
                                  SizedBox(height:5),
                                  Text('niyog', style: TextStyle(color:Colors.brown, fontWeight: FontWeight.w700, fontSize:18),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  checkedValues['kape'] = !checkedValues['kape'];
                                });
                              },
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Image(image: AssetImage('assets/images/coffee1_light.png')),
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child: Badge(
                                            badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: checkedValues['kape'],)
                                      )
                                    ],
                                  ),
                                  SizedBox(height:5),
                                  Text('kape', style: TextStyle(color:Colors.brown, fontWeight: FontWeight.w700, fontSize:18),),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  checkedValues['mais'] = !checkedValues['mais'];
                                });
                              },
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Image(image: AssetImage('assets/images/corn1_light.png')),
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child: Badge(
                                            badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: checkedValues['mais'],)
                                      )
                                    ],
                                  ),
                                  SizedBox(height:5),
                                  Text('mais', style: TextStyle(color:Colors.yellow[800], fontWeight: FontWeight.w700, fontSize:18),),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  checkedValues['palay'] = !checkedValues['palay'];
                                });
                              },
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Image(image: AssetImage('assets/images/rice1_light.png')),
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child: Badge(
                                            badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: checkedValues['palay'],)
                                      )
                                    ],
                                  ),
                                  SizedBox(height:5),
                                  Text('palay', style: TextStyle(color:Colors.green, fontWeight: FontWeight.w700, fontSize:18),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  checkedValues['utaw'] = !checkedValues['utaw'];
                                });
                              },
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Image(image: AssetImage('assets/images/soybean1_light.png')),
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child: Badge(
                                            badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: checkedValues['utaw'],)
                                      )
                                    ],
                                  ),
                                  SizedBox(height:5),
                                  Text('utaw', style: TextStyle(color:Colors.green, fontWeight: FontWeight.w700, fontSize:18),),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  checkedValues['tubo'] = !checkedValues['tubo'];
                                });
                              },
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Image(image: AssetImage('assets/images/sugarcane1_light.png')),
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child: Badge(
                                            badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: checkedValues['tubo'],)
                                      )
                                    ],
                                  ),
                                  SizedBox(height:5),
                                  Text('tubo', style: TextStyle(color:Colors.green, fontWeight: FontWeight.w700, fontSize:18),),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  checkedValues['kamatis'] = !checkedValues['kamatis'];
                                });
                              },
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Image(image: AssetImage('assets/images/tomato1_light.png')),
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child: Badge(
                                            badgeContent: Icon(Icons.check, color: Colors.white, size: 16), showBadge: checkedValues['kamatis'],)
                                      )
                                    ],
                                  ),
                                  SizedBox(height:5),
                                  Text('kamatis', style: TextStyle(color:Colors.red, fontWeight: FontWeight.w700, fontSize:18),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
//                  Row(
//                    children: [
//                      Expanded(
//                        child:CheckboxListTile(
//                          title: Text("Saging"),
//                          value: checkedValues['saging'],
//                          onChanged: (newValue) {
//                            setState(() {
//                              checkedValues['saging'] = newValue;
//                            });
//                          },
//                          controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
//                        ),
//                      ),
//                      Expanded(
//                        child: CheckboxListTile(
//                          title: Text("Kakaw"),
//                          value: checkedValues['kakaw'],
//                          onChanged: (newValue) {
//                            setState(() {
//                              checkedValues['kakaw'] = newValue;
//                            });
//                          },
//                          controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
//                        ),
//                      ),
//                    ],
//                  ),

                    SizedBox(height:10),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                            child: GestureDetector(
                              onTap: () => showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context){
                                  return StatefulBuilder (builder: (context,updateState){
                                    return buildSheet(context,updateState);
                                  });
                                },
                              ),
                              child: Column(
                                children: [
                                  Image(image: AssetImage('assets/hvc/high value crops.png')),
                                  SizedBox(height:5),
                                  Text('high value crops (HVC)', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.w700, fontSize:18),textAlign: TextAlign.center,),
                                ],
                              ),
                            ),
                          ),
                        ),
//                        Expanded(
//                          child: Container(),
//                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/18, vertical: 20),
                            child: GestureDetector(
                              onTap: () {
                                selectedCrops = [];
                                checkedValues.keys.forEach((key) {
                                  if(checkedValues[key]){
                                    selectedCrops.add(key);
                                  }
                                });

                                print(selectedCrops);
                                if(selectedCrops.length==0){
                                  showToast('Please choose atleast 1 crop.', Colors.red);
                                }
                                else{
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => DamageDetails(selectedCrops: selectedCrops, details: widget.details)),
                                  );
                                }
                              },
                              child: Column(
                                children: [
                                  Image(image: AssetImage('assets/hvc/submit crop.png')),
                                  SizedBox(height:5),
                                  Text('submit crop', style: TextStyle(color:Colors.green, fontWeight: FontWeight.w700, fontSize:18),textAlign: TextAlign.center,),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height:20)
                  ],
                ),
              ),
            )
        )
    );
  }
}
