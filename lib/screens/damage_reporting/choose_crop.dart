import 'package:flutter/material.dart';

import 'package:bantay_sarai/screens/damage_reporting/damage_details.dart';

import 'package:badges/badges.dart';


class ChooseCrop extends StatefulWidget {
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
  };
  List<String> selectedCrops = [];

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height:20),
                  Text("Pumili ng pananim na napinsala", style: TextStyle(fontSize:18)),
                  Row(
                    children: [
                      Expanded(
                      child: Container(
                        padding: EdgeInsets.all(20),
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
                              Text('Saging', style: TextStyle(color:Colors.yellow[800], fontWeight: FontWeight.w700, fontSize:18),),
                            ],
                          ),
                        ),
                        ),
                       ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(20),
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
                                Text('Kakaw', style: TextStyle(color:Colors.brown, fontWeight: FontWeight.w700, fontSize:18),),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(20),
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
                                Text('Niyog', style: TextStyle(color:Colors.brown, fontWeight: FontWeight.w700, fontSize:18),),
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
                          padding: EdgeInsets.all(20),
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
                                Text('Kape', style: TextStyle(color:Colors.brown, fontWeight: FontWeight.w700, fontSize:18),),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(20),
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
                                Text('Mais', style: TextStyle(color:Colors.yellow[800], fontWeight: FontWeight.w700, fontSize:18),),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(20),
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
                                Text('Palay', style: TextStyle(color:Colors.green, fontWeight: FontWeight.w700, fontSize:18),),
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
                          padding: EdgeInsets.all(20),
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
                                Text('Utaw', style: TextStyle(color:Colors.green, fontWeight: FontWeight.w700, fontSize:18),),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(20),
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
                                Text('Tubo', style: TextStyle(color:Colors.green, fontWeight: FontWeight.w700, fontSize:18),),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(20),
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
                                Text('Kamatis', style: TextStyle(color:Colors.red, fontWeight: FontWeight.w700, fontSize:18),),
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
                  Text("High value crop (HVC)", style: TextStyle(fontSize:18)),
                  SizedBox(height:20),
                  Row(
                    children: [
                      Expanded(
                        child:CheckboxListTile(
                          title: Text("Ampalaya"),
                          value: checkedValues['ampalaya'],
                          onChanged: (newValue) {
                            setState(() {
                              checkedValues['ampalaya'] = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                          contentPadding: EdgeInsets.all(0),
                          dense: true,
                        ),
                      ),
                      Expanded(
                        child: CheckboxListTile(
                          title: Text("Assorted Beans"),
                          value: checkedValues['assorted beans'],
                          onChanged: (newValue) {
                            setState(() {
                              checkedValues['assorted beans'] = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.all(0),
                          dense: true,//  <-- leading Checkbox
                        ),
                      ),
                      Expanded(
                        child: CheckboxListTile(
                          title: Text("Avocado"),
                          value: checkedValues['avocado'],
                          onChanged: (newValue) {
                            setState(() {
                              checkedValues['avocado'] = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.all(0),
                          dense: true,//  <-- leading Checkbox
                        ),
                      ),

                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          title: Text("Carrots"),
                          value: checkedValues['carrots'],
                          onChanged: (newValue) {
                            setState(() {
                              checkedValues['carrots'] = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.all(0),
                          dense: true,//  <-- leading Checkbox
                        ),
                      ),
                      Expanded(
                        child: CheckboxListTile(
                          title: Text("Rambutan"),
                          value: checkedValues['rambutan'],
                          onChanged: (newValue) {
                            setState(() {
                              checkedValues['rambutan'] = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.all(0),
                          dense: true,//  <-- leading Checkbox
                        ),
                      ),
                      Expanded(
                        child: CheckboxListTile(
                          title: Text("Lanzones"),
                          value: checkedValues['lanzones'],
                          onChanged: (newValue) {
                            setState(() {
                              checkedValues['lanzones'] = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.all(0),
                          dense: true,//  <-- leading Checkbox
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          title: Text("Pechay"),
                          value: checkedValues['pechay'],
                          onChanged: (newValue) {
                            setState(() {
                              checkedValues['pechay'] = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.all(0),
                          dense: true,//  <-- leading Checkbox
                        ),
                      ),
                      Expanded(
                        child: CheckboxListTile(
                          title: Text("Cucumber"),
                          value: checkedValues['cucumber'],
                          onChanged: (newValue) {
                            setState(() {
                              checkedValues['cucumber'] = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.all(0),
                          dense: true,//  <-- leading Checkbox
                        ),
                      ),
                      Expanded(
                        child: CheckboxListTile(
                          title: Text("Gabi"),
                          value: checkedValues['gabi'],
                          onChanged: (newValue) {
                            setState(() {
                              checkedValues['gabi'] = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.all(0),
                          dense: true,//  <-- leading Checkbox
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          title: Text("Papaya"),
                          value: checkedValues['papaya'],
                          onChanged: (newValue) {
                            setState(() {
                              checkedValues['papaya'] = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.all(0),
                          dense: true,//  <-- leading Checkbox
                        ),
                      ),
                      Expanded(
                        child: CheckboxListTile(
                          title: Text("Okra"),
                          value: checkedValues['okra'],
                          onChanged: (newValue) {
                            setState(() {
                              checkedValues['okra'] = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.all(0),
                          dense: true,//  <-- leading Checkbox
                        ),
                      ),
                      Expanded(
                        child: CheckboxListTile(
                          title: Text("Mustasa"),
                          value: checkedValues['mustasa'],
                          onChanged: (newValue) {
                            setState(() {
                              checkedValues['mustasa'] = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.all(0),
                          dense: true,//  <-- leading Checkbox
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          title: Text("Mango"),
                          value: checkedValues['mango'],
                          onChanged: (newValue) {
                            setState(() {
                              checkedValues['mango'] = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.all(0),
                          dense: true,//  <-- leading Checkbox
                        ),
                      ),
                      Expanded(
                        child: CheckboxListTile(
                          title: Text("Kamote"),
                          value: checkedValues['kamote'],
                          onChanged: (newValue) {
                            setState(() {
                              checkedValues['kamote'] = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.all(0),
                          dense: true,//  <-- leading Checkbox
                        ),
                      ),
                      Expanded(
                        child: CheckboxListTile(
                          title: Text("Labanos"),
                          value: checkedValues['labanos'],
                          onChanged: (newValue) {
                            setState(() {
                              checkedValues['labanos'] = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.all(0),
                          dense: true,//  <-- leading Checkbox
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          title: Text("Repolyo"),
                          value: checkedValues['repolyo'],
                          onChanged: (newValue) {
                            setState(() {
                              checkedValues['repolyo'] = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.all(0),
                          dense: true,//  <-- leading Checkbox
                        ),
                      ),
                      Expanded(
                        child: CheckboxListTile(
                          title: Text("Chinese Cabbage"),
                          value: checkedValues['chinese cabbage'],
                          onChanged: (newValue) {
                            setState(() {
                              checkedValues['chinese cabbage'] = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.all(0),
                          dense: true,//  <-- leading Checkbox
                        ),
                      ),
                      Expanded(
                        child: CheckboxListTile(
                          title: Text("Eggplant"),
                          value: checkedValues['eggplant'],
                          onChanged: (newValue) {
                            setState(() {
                              checkedValues['eggplant'] = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.all(0),
                          dense: true,//  <-- leading Checkbox
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          title: Text("Kangkong"),
                          value: checkedValues['kangkong'],
                          onChanged: (newValue) {
                            setState(() {
                              checkedValues['kangkong'] = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.all(0),
                          dense: true,//  <-- leading Checkbox
                        ),
                      ),
                      Expanded(
                        child: CheckboxListTile(
                          title: Text("Honeydew"),
                          value: checkedValues['honeydew'],
                          onChanged: (newValue) {
                            setState(() {
                              checkedValues['honeydew'] = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.all(0),
                          dense: true,//  <-- leading Checkbox
                        ),
                      ),
                      Expanded(
                        child: CheckboxListTile(
                          title: Text("Santol"),
                          value: checkedValues['santol'],
                          onChanged: (newValue) {
                            setState(() {
                              checkedValues['santol'] = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.all(0),
                          dense: true,//  <-- leading Checkbox
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          title: Text("Sayote"),
                          value: checkedValues['sayote'],
                          onChanged: (newValue) {
                            setState(() {
                              checkedValues['sayote'] = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.all(0),
                          dense: true,//  <-- leading Checkbox
                        ),
                      ),
                      Expanded(
                        child: CheckboxListTile(
                          title: Text("Sitaw"),
                          value: checkedValues['sitaw'],
                          onChanged: (newValue) {
                            setState(() {
                              checkedValues['sitaw'] = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.all(0),
                          dense: true,//  <-- leading Checkbox
                        ),
                      ),
                      Expanded(
                        child: CheckboxListTile(
                          title: Text("Potato"),
                          value: checkedValues['potato'],
                          onChanged: (newValue) {
                            setState(() {
                              checkedValues['potato'] = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.all(0),
                          dense: true,//  <-- leading Checkbox
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          title: Text("Calamansi"),
                          value: checkedValues['calamansi'],
                          onChanged: (newValue) {
                            setState(() {
                              checkedValues['calamansi'] = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.all(0),
                          dense: true,//  <-- leading Checkbox
                        ),
                      ),
                      Expanded(
                        child: CheckboxListTile(
                          title: Text("Cassava"),
                          value: checkedValues['cassava'],
                          onChanged: (newValue) {
                            setState(() {
                              checkedValues['cassava'] = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.all(0),
                          dense: true,//  <-- leading Checkbox
                        ),
                      ),
                      Expanded(
                        child: CheckboxListTile(
                          title: Text("Dalanghita/Sintunis"),
                          value: checkedValues['dalanghita/sintunis'],
                          onChanged: (newValue) {
                            setState(() {
                              checkedValues['dalanghita/sintunis'] = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.all(0),
                          dense: true,//  <-- leading Checkbox
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          title: Text("Star Apple"),
                          value: checkedValues['star apple'],
                          onChanged: (newValue) {
                            setState(() {
                              checkedValues['star apple'] = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.all(0),
                          dense: true,//  <-- leading Checkbox
                        ),
                      ),
                      Expanded(
                        child: CheckboxListTile(
                          title: Text("Melon"),
                          value: checkedValues['melon'],
                          onChanged: (newValue) {
                            setState(() {
                              checkedValues['melon'] = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.all(0),
                          dense: true,//  <-- leading Checkbox
                        ),
                      ),
                      Expanded(
                        child: CheckboxListTile(
                          title: Text("Kalabasa"),
                          value: checkedValues['kalabasa'],
                          onChanged: (newValue) {
                            setState(() {
                              checkedValues['kalabasa'] = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.all(0),
                          dense: true,//  <-- leading Checkbox
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          title: Text("Watermelon"),
                          value: checkedValues['watermelon'],
                          onChanged: (newValue) {
                            setState(() {
                              checkedValues['watermelon'] = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.all(0),
                          dense: true,//  <-- leading Checkbox
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width:20),
                      Expanded(
                        child: ElevatedButton(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text('Proceed'),
                          ),
                          onPressed: () {
                            selectedCrops = [];
                            checkedValues.keys.forEach((key) {
                              if(checkedValues[key]){
                                selectedCrops.add(key);
                              }
                            });

                            print(selectedCrops);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DamageDetails(selectedCrops: selectedCrops)),
                            );
//                      if(_formKey.currentState.validate()){
//                        Record record = new Record(_landPreparationDate, _seedlingPreparationDate, _plantedDate, _targetDateOfHarvest, _targetMarketController.text, _expectedQtyOfHarvest.text,null,null,null,null,null,null);
//                        final uid = await Provider.of(context).auth.getCurrentUID();
//                        await db.collection("userData").document(uid).collection("farms").document(farmChosen).collection("records").add(record.toJson());
//                        Navigator.of(context).popUntil((route) => route.isFirst);
//                      }

                          },
                        ),
                      ),
                      SizedBox(width:20),
                    ],
                  ),
                  SizedBox(height:20)
                ],
              ),
            )
        )
    );
  }
}
