import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:intl/intl.dart';
import 'dart:async' show Future;
import 'package:bantay_sarai/widgets/provider_widget.dart';

class WeatherData {
  final List<dynamic> dayOfWeek, qpf, precipitationChance, tempMax, iconCode;
  String location;

  WeatherData({this.location,this.dayOfWeek, this.qpf, this.precipitationChance, this.tempMax, this.iconCode});

  factory WeatherData.fromJson(Map<String, dynamic> json, String location) {
    return WeatherData(
      location: location,
      dayOfWeek: json['dayOfWeek'],
      qpf: json['qpf'],
      precipitationChance: json['daypart'][0]['precipChance'],
      tempMax: json['daypart'][0]['temperature'],
      iconCode: json['daypart'][0]['iconCode'],
    );
  }
}

class SaraiAlerts extends StatefulWidget {
  @override
  _SaraiAlertsState createState() => _SaraiAlertsState();
}

class _SaraiAlertsState extends State<SaraiAlerts> {
  Future<WeatherData> futureWeatherData;
  Future<String> futureDate;
  String dropdownValue;
  var rainfallData, advisoriesData, subscription, dcafData;
  var allRainfallData, allDroughtData, allICMFData;

//  addStringToSP(String weatherData, String location) async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    prefs.setString('weatherData', weatherData);
//    prefs.setString('location', location);
//    prefs.setString('dateSaved', DateFormat.yMMMd().add_jm().format(new DateTime.now()));
//  }

  Future<String> getDate() async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //if(hasInternet){
    return DateFormat.yMMMd().add_jm().format(new DateTime.now());
    //}
    //return prefs.getString('dateSaved');
  }

  Future<String> getLocation() async {
    //Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    //final SharedPreferences prefs = await _prefs;
//    if(prefs.getString('location')!=null){
//      return prefs.getString('location');
//    }
    return 'IPB, UP Los Baños, Laguna';
  }



//  Future<WeatherData> fetchExistingData(String location) async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    //Return String
//    String stringValue = prefs.getString('weatherData');
//    return WeatherData.fromJson(json.decode(stringValue), location);
//  }

  Future<WeatherData> fetchWeatherData(String location) async {
    Map<String, String> apiData = {
      'BUCAF Guinobatan, Albay':'https://api.weather.com/v3/wx/forecast/daily/5day?geocode=13.192833,123.595327&units=m&language=en-US&format=json&apiKey=cff86fd9a5404fd3b86fd9a5407fd302',
      'CLSU Muñoz, Nueva Ecija':'https://api.weather.com/v3/wx/forecast/daily/5day?geocode=15.738165,120.928400&units=m&language=en-US&format=json&apiKey=f4664437a9f14d5ba64437a9f13d5b5a',
      'CMU Maramag, Bukidnon':'https://api.weather.com/v3/wx/forecast/daily/5day?geocode=7.855571,125.057929&units=m&language=en-US&format=json&apiKey=cff86fd9a5404fd3b86fd9a5407fd302',
      'CTU Barili, Cebu':'https://api.weather.com/v3/wx/forecast/daily/5day?geocode=10.132925,123.546750&units=m&language=en-US&format=json&apiKey=f4664437a9f14d5ba64437a9f13d5b5a',
      'DA-QAES Tiaong, Quezon':'https://api.weather.com/v3/wx/forecast/daily/5day?geocode=13.944936,121.369765&units=m&language=en-US&format=json&apiKey=d12105851d0e4c28a105851d0e8c2833',
      'IPB, UP Los Baños, Laguna':'https://api.weather.com/v3/wx/forecast/daily/5day?geocode=14.156233,121.262197&units=m&language=en-US&format=json&apiKey=d12105851d0e4c28a105851d0e8c2833',
      'ISU Cabagan, Isabela':'https://api.weather.com/v3/wx/forecast/daily/5day?geocode=17.410517,21.813614&units=m&language=en-US&format=json&apiKey=d12105851d0e4c28a105851d0e8c2833',
      'ISU Echague, Isabela':'https://api.weather.com/v3/wx/forecast/daily/5day?geocode=16.725611,121.698503&units=m&language=en-US&format=json&apiKey=f4664437a9f14d5ba64437a9f13d5b5a',
      'MinSCAT Alcate, Victoria, Oriental Mindoro':'https://api.weather.com/v3/wx/forecast/daily/5day?geocode=13.149028,121.187139&units=m&language=en-US&format=json&apiKey=ed7b5e2d0bca4c4bbb5e2d0bca0c4bf3',
      'MMSU Batac, Ilocos Norte':'https://api.weather.com/v3/wx/forecast/daily/5day?geocode=18.054028,120.545667&units=m&language=en-US&format=json&apiKey=d12105851d0e4c28a105851d0e8c2833',
      'PCA San Ramon, Zamboanga del Sur':'https://api.weather.com/v3/wx/forecast/daily/5day?geocode=6.996182,121.929624&units=m&language=en-US&format=json&apiKey=f4664437a9f14d5ba64437a9f13d5b5a',
      'PhilRice Sta Cruz, Occidental Mindoro':'https://api.weather.com/v3/wx/forecast/daily/5day?geocode=13.130432,120.704186&units=m&language=en-US&format=json&apiKey=ed7b5e2d0bca4c4bbb5e2d0bca0c4bf3',
      'SPAMAST Buhangin Campus, Malita, Davao Occidental':'https://api.weather.com/v3/wx/forecast/daily/5day?geocode=6.489740,125.545582&units=m&language=en-US&format=json&apiKey=ed7b5e2d0bca4c4bbb5e2d0bca0c4bf3',
      'SPAMAST Kapoc ,Matanao, Davao del Sur':'https://api.weather.com/v3/wx/forecast/daily/5day?geocode=6.691228,125.188743&units=m&language=en-US&format=json&apiKey=ed7b5e2d0bca4c4bbb5e2d0bca0c4bf3',
      'UPLB-CA La Carlota, Negros Occidental':'https://api.weather.com/v3/wx/forecast/daily/5day?geocode=10.404912,122.978921&units=m&language=en-US&format=json&apiKey=cff86fd9a5404fd3b86fd9a5407fd302',
      'USM Kabacan, Cotabato':'https://api.weather.com/v3/wx/forecast/daily/5day?geocode=7.110252,124.851728&units=m&language=en-US&format=json&apiKey=56afd53a907440ecafd53a9074f0ec97',
      'USTP Claveria, Misamis Oriental':'https://api.weather.com/v3/wx/forecast/daily/5day?geocode=8.610266,124.883303&units=m&language=en-US&format=json&apiKey=f4664437a9f14d5ba64437a9f13d5b5a',
      'WPU Aborlan, Palawan':'https://api.weather.com/v3/wx/forecast/daily/5day?geocode=9.443356,118.560378&units=m&language=en-US&format=json&apiKey=f4664437a9f14d5ba64437a9f13d5b5a',
      'WVSU Lambunao, Iloilo City':'https://api.weather.com/v3/wx/forecast/daily/5day?geocode=11.102263,122.414762&units=m&language=en-US&format=json&apiKey=cff86fd9a5404fd3b86fd9a5407fd302'
    };

    var response =
    await http.get(Uri.parse(apiData[location]));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //addStringToSP(response.body,location);
      return WeatherData.fromJson(json.decode(response.body),location);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load weather data');
    }
  }

  fetchRainfallOutlookData(String location){
      return allRainfallData[location];

  }

  fetchDCAFData(String location){
      return allDroughtData[location];
  }

  fetchAdvisories(String location){
    Map<String, dynamic> advisoriesData = {
      'BUCAF Guinobatan, Albay': [
        "Farmers may start planting rainfed rice in May 26, with late planting until mid-June. Water threshold will be consistently met throughout the growth period and the expected harvest is on September to November depending on the variety used. It is possible that early harvesting may happen since typical typhoon months are November to December.",
        "Corn farmers must have started planting in May. Some farmers can still plant until mid-June such that expected harvest will be on September-October.  Water required by the crop will be met throughout the growth period. Although the average typhoon months in Albay are November to December, start preparing alternative drying methods should early harvesting may be needed if typhoon season will start earlier this year."
      ],
      'CLSU Muñoz, Nueva Ecija': [
        "Farmers may start planting rainfed rice on June 7 until the start of July. Given this window, crops will enter flowering phase by August-September, and harvest period will be on October-November depending on the variety used. On the average, typhoon season starts on September and Northern Luzon is usually hit around October-November. Therefore, it is advised to use short-duration varieties to avoid damaging and/or totally destroying matured crops due to heavy rainfall and high wind speed. An alternative solution is to conduct early harvesting. Sun drying is not likely to be successful due to wet harvest season.",
        "Planting of corn in Nueva Ecija must have started last May 20. The allowable late planting must be until mid-June so that harvesting can be finished by September-October prior to significant typhoon months. Early harvesting is likely to be conducted as well. Sun drying is not likely to be successful due to wet harvest season."
      ],
      'CMU Maramag, Bukidnon': [
        "Planting	of	rainfed	rice	may	start	by	May	18	to	early	June	(acceptable	late	planting).	On	the	average,	rainfall	is	high starting	September	since	this	is	also	the	start	of	typhoon	months	in	the	country.	If	planted	by	May	to	early	June, crops	can	be	harvested	earlier	(latest	could	be	mid-September)	with very	minimal	grain	weight.",
        "Corn	may	be	planted	as	early	as	May.	Early	June	is	considered	as	late	but	still	acceptable.	Planting	later	than	June may	be	more	prone	to	crop	damage	due	to	flooding	and/or	high	wind	speed	brought	by	typhoons	that	are	likely	to occur	starting	September. Crops	planted	in	May	to	early	June	is	expected	to	be	harvested	by	August	to	early September. Prepare	alternative	drying	methods	because	sun	drying	may	be	challenging	during	this	time."
      ],
      'CTU Barili, Cebu': [
        "",
        "Farmers	may	plant	starting	June	14	when	water	requirement	is	expected	to	be	met.	Given	this	date,	corn	is	expected to	enter	reproductive	stage	by	August	8	and	kernel	development	will	begin.	An	average	115-day	variety	can	be harvested	by	October	7.	Prepare	for	probable	wet	harvesting	season.	"
      ]  ,
      'DA-QAES Tiaong, Quezon': ["",""],
      'IPB, UP Los Baños, Laguna': [
        "Water required by rainfed rice is expected to be met on June 17. It is also advised to start planting during this time, until early July. Given this planting period, crops will enter flowering phase by August to September, with expected harvest period on October to November depending on the variety used. Historically, CALABARZON experiences heavy rainfall and high wind speed around May-June and October-December due to monsoons and typhoons. It is advised to use short-duration varieties to lessen the risk of crop damage during harvest in the latter period of the year. Alternative drying methods should also be prepared in case early harvesting will be necessary.",
        "Corn farmers may start planting corn by June so that an average 115-day corn variety may be harvested by mid-September. Planting in June will maximize the use of likely high rainwater due to onset of rainy season. Damaging typhoons that typically occurs during October-December can also be avoided."
      ],
      'ISU Cabagan, Isabela': ["",""],
      'ISU Echague, Isabela': [
        "Planting of rainfed rice in Echague, Isabela is advised to start on July 28 when water required by soil to sufficiently support the growth of young crops is met. Flowering/reproductive phase will occur during the average typhoon months—September to October. During these months, construct bunds high enough to avoid overflowing/flooding (as per IRRI’s advise) to prevent flooding of field while maintaining the necessary water level during flowering stage. Harvest period is around November-December, until early January depending on the variety used.",
        "Corn farmers should start planting by May, so that water is still sufficient during flowering and harvesting can be done by September (as per average 120-day corn variety). Note that the typical months when typhoons hit Isabela are September and October; thus, farmers should be able to harvest before this period. Alternative drying methods must be considered."
      ],
      'MinSCAT Alcate, Victoria, Oriental Mindoro': ["",""],
      'MMSU Batac, Ilocos Norte': [
        "Planting of rainfed rice may start in May 31 until late planting by end of June. Given this planting period, crops are expected to be harvested by end of September until early November. However, typhoons that entered the country and passed through Ilocos Norte historically occurs in September. It is advised for farmers to sow short-duration crops so that early harvesting by mid-August will have minimal opportunity cost.",
        "Corn farmers may have already planted starting May. Planting later will put crops at risk for damage loss due to typhoons during harvest period (September). Flowering/reproductive period will start by mid-July with expected harvest at the end of August to early September."
      ],
      'PCA San Ramon, Zamboanga del Sur': ["",""],
      'PhilRice Sta Cruz, Occidental Mindoro': ["",""],
      'SPAMAST Buhangin Campus, Malita, Davao Occidental': ["",""],
      'SPAMAST Kapoc ,Matanao, Davao del Sur': ["",""],
      'UPLB-CA La Carlota, Negros Occidental':  [
        "Rainfed rice planting may begin since the required accumulated water to sustain crop growth is met. Planting in June will have an expected flowering phase on August-September and harvesting period on October-November. Accumulated rainwater is significantly high throughout the duration of crop growth. Consider alterations in management practices such as constructing bunds and fixing cracks/hole (as per IRRI’s advice) to prevent excessive flooding of the field especially during flowering/reproductive phase.",
        "Corn farmers are expected to be planting since May 15 with late planting period until mid-June. An average 115-day corn variety is expected to be harvested by September. Wet harvest season is expected and prepare alternative drying methods Farmers may proceed to another cropping after harvest to be concluded by December/January. Harvest season during the succeeding cropping season (i.e., December) is expected to be dry."
      ],
      'USM Kabacan, Cotabato': [
        "Rainfed	rice	planting	is	encouraged	to	start	by	June	26	when	soil	can	sustain	the	growth	of	young	crops	with sufficient	water	from	rainfall. Late	planting	may	be	until	mid-July.	Flowering/reproductive	stage	will	occur	on	midAugust	to	September;	crops	will	enter	maturity	by	October	to	November	and	then	it	will	be	ready	for	harvest	by	lateNovember	to	early	December.	On	the	average,	rainfall	in the	area	is	significantly	low	yet	manageable	for	rainfed	rice",
        "Corn	may	be	planted	starting	June	14	to	early	July.	Upon	entering	flowering	stage	during	August,	the	accumulated rainfall	is	expected	to	be	significantly	above	average	but	still	manageable	for	the	crop.	Expected	harvest	of	an average	115-day	corn	variety	is	on	October.	"
      ],
      'USTP Claveria, Misamis Oriental': ["",""],
      'WPU Aborlan, Palawan': ["",""],
      'WVSU Lambunao, Iloilo City': [
        "Soil	is	wet	enough	starting	May	28	to	sustain	rainfed	rice’s	early	growth	stage.	If	farmers	plant	during	this	time,	their crops	will	enter	flowering/reproductive	stage	by	August	and	then	will	be	ready	for	harvest	by	late	September	to	midOctober. Prepare	for	possible	early	harvesting	since	typhoons	usually	enter	the	country	during	these	months.",
        "Corn	farmers	may	start	planting	by	May	31.	Accumulated	rainfall	is	significantly	high	during	the	crop’s	early	stage, then	will	eventually	decrease	transitioning	to	flowering	(mid-July	to	August)	and	harvesting	period	(SeptemberOctober).	Prepare	for	probable	wet	harvesting	season."
      ]
    };

    return advisoriesData[location];
  }

  changeDropDown(String value){
    setState(() {
      dropdownValue = value;
      //futureDate = getDate();
      futureWeatherData = fetchWeatherData(dropdownValue);
      rainfallData = fetchRainfallOutlookData(dropdownValue);
      dcafData = fetchDCAFData(dropdownValue);
      advisoriesData = fetchAdvisories(dropdownValue);
    });
  }

  setColor(String rawValue){

    if(rawValue=='--') return Colors.grey;

    int val = int.parse(rawValue);

    if (val < 50)
      return Color(0xffe1e1e1);
    else if (val >= 50 && val < 100)
      return Color(0xffbee8ff);
    else if (val >= 100 && val < 200)
      return Color(0xff00c5ff);
    else if (val >= 200 && val < 300)
      return Color(0xff0070ff);
    else if (val >= 300 && val < 400)
      return Color(0xff004da8);
    else if (val >= 400 && val < 500)
      return Color(0xff002673);
    else if (val > 500)
      return Color(0xff000000);
    else
      return Color(0xffffffff);
  }

  setDCAFColor(String rawValue){

    if(rawValue=='--') return Colors.grey;


    if (rawValue == 'Normal')
      return Colors.white;
    else if (rawValue == 'Mild')
      return Colors.yellow;
    else if (rawValue == 'Moderate')
      return Colors.orange;
    else if (rawValue == 'Severe')
      return Colors.red;
  }

  static const String ChangeLocation = 'Change Station';
  static const String About = 'About';

  static const List<String> choices = <String>[
    ChangeLocation,
    About
  ];

  getRainfallData() async {
    var rdata = await Provider.of(context)
        .db
        .collection('saraiAlerts')
        .document('rainfallOutlook').get();
    setState(() {
      allRainfallData = rdata;
      rainfallData = fetchRainfallOutlookData('IPB, UP Los Baños, Laguna');
    });
  }

  getDroughtData() async {
    var ddata = await Provider.of(context)
        .db
        .collection('saraiAlerts')
        .document('droughtForecast').get();
    setState(() {
      allDroughtData = ddata;
      dcafData = fetchDCAFData('IPB, UP Los Baños, Laguna');
    });
  }

  getICMFData() async {
    var icmfData = await Provider.of(context)
        .db
        .collection('saraiAlerts')
        .document('icmfBulletin').get();
    setState(() {
      allICMFData = icmfData;
    });
  }

  @override
  void initState() {
    dropdownValue = 'IPB, UP Los Baños, Laguna';
    advisoriesData = fetchAdvisories('IPB, UP Los Baños, Laguna');
    futureWeatherData = fetchWeatherData('IPB, UP Los Baños, Laguna');
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      getRainfallData();
      getDroughtData();
      getICMFData();
    });

  }

  @override
  dispose() {
    super.dispose();
    subscription.cancel();
  }

  void choiceAction(String choice) async {
    if(choice == ChangeLocation){
      buildChangeLocation(context);
    }else if(choice == About){
      buildWeatherAbout(context);
    }
  }

  buildWeatherAbout(BuildContext context){
    return showDialog<String>(
      context: context,
      barrierDismissible: false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState){
              return AlertDialog(
                title: Text('Weather Forecast'),
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(20.0)),
                content: Container(
                    child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Expected amount of rainfall and temperature on your farm for today and for the next five days.', style: TextStyle(color:Colors.blueGrey),),
                            SizedBox(height:20),
                            Text('Inaasahang dami ng ulan at tindi ng init at lamig sa iyong taniman ngayon at sa susunod na limang na araw.', style: TextStyle(color:Colors.blueGrey,fontStyle: FontStyle.italic),),
                            SizedBox(height:20),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(text: "Source:", style: new TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: " SARAI AWS; WU"),
                                ],
                              ),
                            ),
                          ],
                        )
                    )
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Close',
                      style: TextStyle(color: Colors.grey),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            }
        );
      },
    );
  }

  buildDCAFAbout(BuildContext context){
    return showDialog<String>(
      context: context,
      barrierDismissible: false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState){
              return AlertDialog(
                title: Text('Drought and Crop Assessment'),
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(20.0)),
                content: Container(
                    child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Know which provinces are affected and will be affected by moisture stress. Indices are aggregated per province.', style: TextStyle(color:Colors.blueGrey),),
                            SizedBox(height:20),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(text: "Source:", style: new TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: " DCAF Project"),
                                ],
                              ),
                            ),
                          ],
                        )
                    )
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Close',
                      style: TextStyle(color: Colors.grey),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            }
        );
      },
    );
  }

  buildRainfallAbout(BuildContext context){
    return showDialog<String>(
      context: context,
      barrierDismissible: false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState){
              return AlertDialog(
                title: Text('Rainfall Outlook'),
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(20.0)),
                content: Container(
                    child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('5-month rainfall forecast of municipalities with arable and cultivated land based on land cover classification of DA-BAR.', style: TextStyle(color:Colors.blueGrey),),
                            SizedBox(height:20),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(text: "Source:", style: new TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: " SEAMS; NOAA-Climate Prediction Center"),
                                ],
                              ),
                            ),
                            SizedBox(height:20),
                            Text('Rainfall Outlook Legend', style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height:5),
                            Container(
                                child: Center(
                                    child:Row(
                                        children: <Widget>[
                                          Icon(Icons.lens, color:Color(0xffe1e1e1), size:16),
                                          Text("< 50 mm", style:TextStyle(fontSize: 13, color:Colors.blueGrey,fontWeight: FontWeight.w500))
                                        ]
                                    )
                                )
                            ),
                            Container(
                                child: Center(
                                    child:Row(
                                        children: <Widget>[
                                          Icon(Icons.lens, color:Color(0xffbee8ff), size:16),
                                          Text("51-100 mm", style:TextStyle(fontSize: 13, color:Colors.blueGrey,fontWeight: FontWeight.w500))
                                        ]
                                    )
                                )
                            ),
                            Container(
                                child: Center(
                                    child:Row(
                                        children: <Widget>[
                                          Icon(Icons.lens, color:Color(0xff00c5ff), size:16),
                                          Text("101-200 mm", style:TextStyle(fontSize: 13, color:Colors.blueGrey,fontWeight: FontWeight.w500))
                                        ]
                                    )
                                )
                            ),
                            Container(
                                child: Center(
                                    child:Row(
                                        children: <Widget>[
                                          Icon(Icons.lens, color:Color(0xff0070ff), size:16),
                                          Text("201-300 mm", style:TextStyle(fontSize: 13, color:Colors.blueGrey,fontWeight: FontWeight.w500))
                                        ]
                                    )
                                )
                            ),
                            Container(
                                child: Center(
                                    child:Row(
                                        children: <Widget>[
                                          Icon(Icons.lens, color:Color(0xff004da8), size:16),
                                          Text("301-400 mm", style:TextStyle(fontSize: 13, color:Colors.blueGrey,fontWeight: FontWeight.w500))
                                        ]
                                    )
                                )
                            ),
                            Container(
                                child: Center(
                                    child:Row(
                                        children: <Widget>[
                                          Icon(Icons.lens, color:Color(0xff002673), size:16),
                                          Text("401-500 mm", style:TextStyle(fontSize: 13, color:Colors.blueGrey,fontWeight: FontWeight.w500))
                                        ]
                                    )
                                )
                            ),
                            Container(
                                child: Center(
                                    child:Row(
                                        children: <Widget>[
                                          Icon(Icons.lens, color:Color(0xff000000), size:16),
                                          Text("> 501 mm", style:TextStyle(fontSize: 13, color:Colors.blueGrey,fontWeight: FontWeight.w500))
                                        ]
                                    )
                                )
                            ),
                          ],
                        )
                    )
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Close',
                      style: TextStyle(color: Colors.grey),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            }
        );
      },
    );
  }

  buildWifiDialog(BuildContext context) {

    return showDialog<String>(
      context: context,
      barrierDismissible: true, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState){
              return AlertDialog(
                title: Text('No Internet Connection'),
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(20.0)),
                content: Container(
                    child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Text('Check your connection! Unable to change your location.', style: TextStyle(color: Color(0xffa94442))),
                          ],
                        )
                    )
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Okay',
                      style: TextStyle(color: Colors.grey),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            }
        );
      },
    );
  }

  buildChangeLocation(BuildContext context) {
    return showDialog<String>(
      context: context,
      barrierDismissible: false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState){
              return AlertDialog(
                title: Text('Weather Station'),
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(20.0)),
                content: Container(
                    child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            DropdownButton<String>(
                              isExpanded: true,
                              value: dropdownValue,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(color: Colors.black),
                              underline: Container(
                                height: 1,
                                color: Colors.blue,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                });
                              },
                              items: <String>[
                                'BUCAF Guinobatan, Albay',
                                'CLSU Muñoz, Nueva Ecija',
                                'CMU Maramag, Bukidnon',
                                'CTU Barili, Cebu',
                                'DA-QAES Tiaong, Quezon',
                                'IPB, UP Los Baños, Laguna',
                                'ISU Cabagan, Isabela',
                                'ISU Echague, Isabela',
                                'MinSCAT Alcate, Victoria, Oriental Mindoro',
                                'MMSU Batac, Ilocos Norte',
                                'PCA San Ramon, Zamboanga del Sur',
                                'PhilRice Sta Cruz, Occidental Mindoro',
                                'SPAMAST Buhangin Campus, Malita, Davao Occidental',
                                'SPAMAST Kapoc ,Matanao, Davao del Sur',
                                'UPLB-CA La Carlota, Negros Occidental',
                                'USM Kabacan, Cotabato',
                                'USTP Claveria, Misamis Oriental',
                                'WPU Aborlan, Palawan',
                                'WVSU Lambunao, Iloilo City'
                              ]
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        )
                    )
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Cancel',
                      style: TextStyle(color: Colors.grey),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text('Submit'),
                    onPressed: () {
                      changeDropDown(dropdownValue);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            }
        );
      },
    );
  }

  Expanded buildDaysOfWeek(String day, int addDays){
    var now = DateTime.now();
    var currDay = DateTime(now.year, now.month, now.day + addDays);
//    if(isFirst){
//      return Expanded(
//        child: Container(
//          padding: const EdgeInsets.all(6.0),
//          decoration: BoxDecoration(
//            color: Colors.blueGrey,
//            border: Border.all(
//                width: 1,
//                color: Colors.blueGrey//                   <--- border width here
//            ),
//          ),
//          child: Column(
//            children: <Widget>[
//              Text(
//                DateFormat.MMMd().format(curr_day),
//                style: TextStyle(fontSize: 15.0, color: Colors.white),
//              ),
//              Text(
//                day,
//                textAlign: TextAlign.center,
//                style: TextStyle(fontSize: 15.0, color: Colors.white),
//              ),
//            ],
//          )
//
//        ),
//      );
//    }

    return Expanded(
      child: Container(
          padding: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(width: 1,
                  color: Colors.blueGrey),
              bottom: BorderSide(width: 1,
                  color: Colors.blueGrey),
            ),
          ),
          child: Column(
            children: <Widget>[
              Text(
                DateFormat.MMMd().format(currDay),
                style: TextStyle(fontSize: 15.0, color: Colors.blueGrey),
              ),
              Text(
                day,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15.0, color: Colors.blueGrey,fontWeight: FontWeight.bold),
              ),
            ],
          )
      ),
    );
  }

  FutureBuilder buildWeatherForecast(BuildContext context){
    return FutureBuilder<WeatherData>(
      future: futureWeatherData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Image.asset('assets/weather_underground/${(snapshot.data.iconCode[0] == null) ? snapshot.data.iconCode[1] : snapshot.data.iconCode[0]}.png',
                      height:80
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(snapshot.data.location, style: TextStyle(color: Colors.blueGrey, fontSize: 18),),
                          SizedBox(height:10),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blueGrey),
                              children: <TextSpan>[
                                TextSpan(text: snapshot.data.dayOfWeek[0], style: new TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: ", ${(snapshot.data.tempMax[0] == null) ? snapshot.data.tempMax[1] : snapshot.data.tempMax[0]}°C"),
                              ],
                            ),
                          ),
                          Text('${(snapshot.data.precipitationChance[0] == null) ? snapshot.data.precipitationChance[1] : snapshot.data.precipitationChance[0]}% chance of rain', style: TextStyle(color: Colors.blueGrey, fontSize: 14),),
                          Text('Rainfall : ${(double.parse(snapshot.data.qpf[0].toString()) == 0) ? '<1' : snapshot.data.qpf[0]} mm', style: TextStyle(color: Colors.blueGrey, fontSize: 14),)
                        ],
                      )
                  ),
                ],
              ),
              SizedBox(height:20),
              Row(
                children: <Widget>[
                  buildDaysOfWeek(snapshot.data.dayOfWeek[1].substring(0,3),1),
                  buildDaysOfWeek(snapshot.data.dayOfWeek[2].substring(0,3),2),
                  buildDaysOfWeek(snapshot.data.dayOfWeek[3].substring(0,3),3),
                  buildDaysOfWeek(snapshot.data.dayOfWeek[4].substring(0,3),4),
                ],
              ),
              SizedBox(height:5),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      '${snapshot.data.tempMax[2]}°',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0, color: Colors.blueGrey),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${snapshot.data.tempMax[4]}°',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0, color: Colors.blueGrey),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${snapshot.data.tempMax[6]}°',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0, color: Colors.blueGrey),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${snapshot.data.tempMax[8]}°',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0, color: Colors.blueGrey),
                    ),
                  ),

                ],
              ),
              SizedBox(height:5),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Image.asset('assets/weather_underground/${snapshot.data.iconCode[2]}.png',
                        height:40
                    ),
                  ),
                  Expanded(
                    child: Image.asset('assets/weather_underground/${snapshot.data.iconCode[4]}.png',
                        height:40
                    ),
                  ),
                  Expanded(
                    child: Image.asset('assets/weather_underground/${snapshot.data.iconCode[6]}.png',
                        height:40
                    ),
                  ),
                  Expanded(
                    child: Image.asset('assets/weather_underground/${snapshot.data.iconCode[8]}.png',
                        height:40
                    ),
                  ),
                ],
              ),
              SizedBox(height:5),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('assets/icons/raindrop.png',height:14),
                        SizedBox(width:2),
                        Text(
                          '${snapshot.data.precipitationChance[2]}%',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14.0, color: Colors.blueGrey),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('assets/icons/raindrop.png',height:14),
                        SizedBox(width:2),
                        Text(
                          '${snapshot.data.precipitationChance[4]}%',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14.0, color: Colors.blueGrey),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('assets/icons/raindrop.png',height:14),
                        SizedBox(width:2),
                        Text(
                          '${snapshot.data.precipitationChance[6]}%',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14.0, color: Colors.blueGrey),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('assets/icons/raindrop.png',height:14),
                        SizedBox(width:2),
                        Text(
                          '${snapshot.data.precipitationChance[8]}%',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14.0, color: Colors.blueGrey),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
              SizedBox(height:5),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      '${(double.parse(snapshot.data.qpf[1].toString()) == 0) ? '<1' : snapshot.data.qpf[1]} mm',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12.0, color: Colors.blueGrey),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${(double.parse(snapshot.data.qpf[2].toString()) == 0) ? '<1' : snapshot.data.qpf[2]} mm',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12.0, color: Colors.blueGrey),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${(double.parse(snapshot.data.qpf[3].toString()) == 0) ? '<1' : snapshot.data.qpf[3]} mm',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12.0, color: Colors.blueGrey),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${(double.parse(snapshot.data.qpf[4].toString()) == 0) ? '<1' : snapshot.data.qpf[4]} mm',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12.0, color: Colors.blueGrey),
                    ),
                  ),
                ],
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text("No weather data available. Try connecting to the internet to get weather data.");
        }

        // By default, show a loading spinner.
        return Center(
            child: CircularProgressIndicator()
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Weather Forecast', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                                  FutureBuilder<String>(
                                      future: getDate(),
                                      builder: (context, snapshot) {
                                        return Text('Updated ${snapshot.data}', style: TextStyle(color: Colors.blueGrey, fontSize: 14),);
                                      })
                                ],
                              ),
                              Expanded(
                                child: PopupMenuButton<String>(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child:Icon(
                                      Icons.more_vert,
                                      color: Colors.blueGrey,
                                      size: 22.0,
                                    ),
                                  ),
                                  onSelected: choiceAction,
                                  itemBuilder: (BuildContext context){
                                    return choices.map((String choice){
                                      return PopupMenuItem<String>(
                                        value: choice,
                                        child: Text(choice),
                                      );
                                    }).toList();
                                  },
                                ),
                              ),

                            ],
                          )

                      ),

                      Divider(
                          height: 0,
                          color: Colors.blueGrey
                      ),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        child: buildWeatherForecast(context),
                      ),

                    ],
                  ),
                ),





                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  child: (rainfallData==null) ? Center(
                      child: CircularProgressIndicator()
                  ) :
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Rainfall Outlook', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                                  Text(rainfallData[0], style: TextStyle(color: Colors.blueGrey, fontSize: 14),)
                                ],
                              ),
                              Expanded(
                                child: InkWell(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                      Icons.help_outline,
                                      color: Colors.blueGrey,
                                      size: 22.0,
                                    ),
                                  ),
                                  onTap: (){
                                    buildRainfallAbout(context);
                                  },
                                ),
                              ),

                            ],
                          )

                      ),

                      Divider(
                          height: 0,
                          color: Colors.blueGrey
                      ),
                      Container(
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 20.0),
                                        decoration: BoxDecoration(
                                          color: setColor(rainfallData[1]),
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              allRainfallData['months'][0],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16.0, color: Colors.white),
                                            ),
                                            SizedBox(height:10),
                                            Text(
                                              rainfallData[1],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "mm",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16.0, color: Colors.white),
                                            ),
                                          ],
                                        )

                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 20.0),
                                        decoration: BoxDecoration(
                                          color:setColor(rainfallData[2]),
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              allRainfallData['months'][1],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16.0, color: Colors.white),
                                            ),
                                            SizedBox(height:10),
                                            Text(
                                              rainfallData[2],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "mm",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16.0, color: Colors.white),
                                            ),
                                          ],
                                        )

                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 20.0),
                                        decoration: BoxDecoration(
                                          color: setColor(rainfallData[3]),
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              allRainfallData['months'][2],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16.0, color: Colors.white),
                                            ),
                                            SizedBox(height:10),
                                            Text(
                                              rainfallData[3],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "mm",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16.0, color: Colors.white),
                                            ),
                                          ],
                                        )

                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 20.0),
                                        decoration: BoxDecoration(
                                          color: setColor(rainfallData[4]),
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              allRainfallData['months'][3],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16.0, color: Colors.white),
                                            ),
                                            SizedBox(height:10),
                                            Text(
                                              rainfallData[4],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "mm",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16.0, color: Colors.white),
                                            ),
                                          ],
                                        )

                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 20.0),
                                        decoration: BoxDecoration(
                                          color: setColor(rainfallData[5]),
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              allRainfallData['months'][4],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16.0, color: Colors.white),
                                            ),
                                            SizedBox(height:10),
                                            Text(
                                              rainfallData[5],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "mm",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16.0, color: Colors.white),
                                            ),
                                          ],
                                        )

                                    ),
                                  ),

                                ],
                              ),
                              Container(
                                  padding:const EdgeInsets.fromLTRB(8, 7, 8, 0),
                                  child: Center(
                                      child:Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Container(
                                                child: Center(
                                                    child:Row(
                                                        children: <Widget>[
                                                          Icon(Icons.lens, color:Color(0xffe1e1e1), size:16),
                                                          Text("< 50", style:TextStyle(fontSize: 13, color:Colors.black87,fontWeight: FontWeight.w500))
                                                        ]
                                                    )
                                                )
                                            ),
                                            Container(
                                                child: Center(
                                                    child:Row(
                                                        children: <Widget>[
                                                          Icon(Icons.lens, color:Color(0xffbee8ff), size:16),
                                                          Text("51-100", style:TextStyle(fontSize: 13, color:Colors.black87,fontWeight: FontWeight.w500))
                                                        ]
                                                    )
                                                )
                                            ),
                                            Container(
                                                child: Center(
                                                    child:Row(
                                                        children: <Widget>[
                                                          Icon(Icons.lens, color:Color(0xff00c5ff), size:16),
                                                          Text("101-200", style:TextStyle(fontSize: 13, color:Colors.black87,fontWeight: FontWeight.w500))
                                                        ]
                                                    )
                                                )
                                            ),
                                            Container(
                                                child: Center(
                                                    child:Row(
                                                        children: <Widget>[
                                                          Icon(Icons.lens, color:Color(0xff0070ff), size:16),
                                                          Text("201-300", style:TextStyle(fontSize: 13, color:Colors.black87,fontWeight: FontWeight.w500))
                                                        ]
                                                    )
                                                )
                                            ),
                                          ]
                                      )
                                  )
                              ),
                              Container(
                                  padding:const EdgeInsets.fromLTRB(8, 3, 8, 11),
                                  child: Center(
                                      child:Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Container(
                                                child: Center(
                                                    child:Row(
                                                        children: <Widget>[
                                                          Icon(Icons.lens, color:Color(0xff004da8), size:16),
                                                          Text("301-400", style:TextStyle(fontSize: 13, color:Colors.black87,fontWeight: FontWeight.w500))
                                                        ]
                                                    )
                                                )
                                            ),
                                            Container(
                                                child: Center(
                                                    child:Row(
                                                        children: <Widget>[
                                                          Icon(Icons.lens, color:Color(0xff002673), size:16),
                                                          Text("401-500", style:TextStyle(fontSize: 13, color:Colors.black87,fontWeight: FontWeight.w500))
                                                        ]
                                                    )
                                                )
                                            ),
                                            Container(
                                                child: Center(
                                                    child:Row(
                                                        children: <Widget>[
                                                          Icon(Icons.lens, color:Color(0xff000000), size:16),
                                                          Text("> 501", style:TextStyle(fontSize: 13, color:Colors.black87,fontWeight: FontWeight.w500))
                                                        ]
                                                    )
                                                )
                                            ),
                                          ]
                                      )
                                  )
                              ),
                            ],
                          )
                      ),

                    ],
                  ),
                ),

                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  child: (dcafData==null) ? Center(
                      child: CircularProgressIndicator()
                  ) : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Drought and Crop Assessment', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                                  Text(dcafData[0], style: TextStyle(color: Colors.blueGrey, fontSize: 14),)
                                ],
                              ),
                              Expanded(
                                child: InkWell(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                      Icons.help_outline,
                                      color: Colors.blueGrey,
                                      size: 22.0,
                                    ),
                                  ),
                                  onTap: (){
                                    buildDCAFAbout(context);
                                  },
                                ),
                              ),

                            ],
                          )

                      ),

                      Divider(
                          height: 0,
                          color: Colors.blueGrey
                      ),
                      Container(
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                        padding: const EdgeInsets.all(20.0),
                                        decoration: BoxDecoration(
                                          color: setDCAFColor(dcafData[1]),
                                          border: Border.all(
                                              width: 0,
                                              color: Colors.grey//                   <--- border width here
                                          ),
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              allDroughtData['months'][0],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16.0, color: Colors.blueGrey),
                                            ),
                                            SizedBox(height:10),
                                            Text(
                                              dcafData[1],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 20.0, color: Colors.blueGrey, fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )

                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                        padding: const EdgeInsets.all(20.0),
                                        decoration: BoxDecoration(
                                          color:setDCAFColor(dcafData[2]),
                                          border: Border.all(
                                              width: 0,
                                              color: Colors.grey//                   <--- border width here
                                          ),
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              allDroughtData['months'][1],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16.0, color: Colors.blueGrey),
                                            ),
                                            SizedBox(height:10),
                                            Text(
                                              dcafData[2],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 20.0, color: Colors.blueGrey, fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )

                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                        padding: const EdgeInsets.all(20.0),
                                        decoration: BoxDecoration(
                                          color: setDCAFColor(dcafData[3]),
                                          border: Border.all(
                                              width: 0,
                                              color: Colors.grey//                   <--- border width here
                                          ),
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              allDroughtData['months'][2],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16.0, color: Colors.blueGrey),
                                            ),
                                            SizedBox(height:10),
                                            Text(
                                              dcafData[3],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 20.0, color: Colors.blueGrey, fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )

                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                        padding: const EdgeInsets.all(20.0),
                                        decoration: BoxDecoration(
                                          color: setDCAFColor(dcafData[4]),
                                          border: Border.all(
                                              width: 0,
                                              color: Colors.grey//                   <--- border width here
                                          ),
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              allDroughtData['months'][3],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16.0, color: Colors.blueGrey),
                                            ),
                                            SizedBox(height:10),
                                            Text(
                                              dcafData[4],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 20.0, color: Colors.blueGrey, fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )

                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                        padding: const EdgeInsets.all(20.0),
                                        decoration: BoxDecoration(
                                          color:setDCAFColor(dcafData[5]),
                                          border: Border.all(
                                              width: 0,
                                              color: Colors.grey//                   <--- border width here
                                          ),
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              allDroughtData['months'][4],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16.0, color: Colors.blueGrey),
                                            ),
                                            SizedBox(height:10),
                                            Text(
                                              dcafData[5],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 20.0, color: Colors.blueGrey, fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )

                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 20.0),
                                        decoration: BoxDecoration(
                                          color: setDCAFColor(dcafData[6]),
                                          border: Border.all(
                                              width: 0,
                                              color: Colors.grey//                   <--- border width here
                                          ),
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              allDroughtData['months'][5],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16.0, color: Colors.blueGrey),
                                            ),
                                            SizedBox(height:10),
                                            Text(
                                              dcafData[6],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 20.0, color: Colors.blueGrey, fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )

                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                      ),

                    ],
                  ),
                ),
//
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Advisories', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
//                              Icon(
//                                Icons.help_outline,
//                                color: Colors.blueGrey,
//                                size: 22.0,
//                              ),
                            ],
                          )

                      ),

                      Divider(
                          height: 0,
                          color: Colors.blueGrey
                      ),
                      (allICMFData==null) ? Center(
                          child: CircularProgressIndicator()
                      ) : Container(
                          child: Column(
                            children: <Widget>[
//                              Visibility(
//                                visible: (advisoriesData[0] == "" && advisoriesData[1] == "") ? false : true,
//                                child: ExpansionTile(
//                                  initiallyExpanded: true,
//                                  title: RichText(
//                                    text: TextSpan(
//                                      style: TextStyle(
//                                          fontSize: 14,
//                                          color: Colors.blueGrey),
//                                      children: <TextSpan>[
//                                        TextSpan(text: "SARAi Cropping Advisories for "),
//                                        TextSpan(text: dropdownValue, style: new TextStyle(fontWeight: FontWeight.bold,color:Colors.black)),
//                                        TextSpan(text: " (June to October 2020) as of May 2020"),
//                                      ],
//                                    ),
//                                  ),
//                                  children: <Widget>[
//                                    Padding(
//                                      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0,),
//                                      child: Column(
//                                        children: <Widget>[
//                                          Visibility(
//                                              visible: (advisoriesData[0]=="") ? false : true,
//                                              child: Column(
//                                                crossAxisAlignment: CrossAxisAlignment.start,
//                                                children: <Widget>[
//                                                  Text('RAINFED RICE', style: TextStyle(fontWeight: FontWeight.bold)),
//                                                  Text(advisoriesData[0],style: TextStyle(color: Colors.blueGrey)),
//                                                  SizedBox(height:16),
//                                                ],
//                                              )
//                                          ),
//                                          Visibility(
//                                              visible: (advisoriesData[1]=="") ? false : true,
//                                              child: Column(
//                                                crossAxisAlignment: CrossAxisAlignment.start,
//                                                children: <Widget>[
//                                                  Text('CORN', style: TextStyle(fontWeight: FontWeight.bold)),
//                                                  Text(advisoriesData[1],style: TextStyle(color: Colors.blueGrey))
//                                                ],
//                                              )
//                                          ),
//
//                                        ],
//                                      ),
//                                    )
//
//                                  ],
//                                ),
//                              ),
                              ExpansionTile(
                                title: Text(
                                  "National & Regional Bulletin",
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 14.0,
                                  ),
                                ),
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                                    child: Column(
                                      children: <Widget>[
//                                        Text("We expect favorable growing condition for corn, and generally for other rainfed crops, this current wet season. The amount of rainfall is enough to sustain the crop till harvest. Corn needs about 500mm rainfall/season (FAO). And because ~June 21 – Sept 21 is summer season, the daylength is longest in the year hence photosynthesis favored leading to better biomass production. Unfortunately, as pointed out in the last advisory, we might have problem with drying at harvest time for a grain crop like corn. Lowland rice might face similar problem because dams have to be filled up for about a month before irrigation water is made available. This delay has repercussion in terms of the crop’s growth stage and arrival of strong typhoons during the ‘ber’ months. Post-harvest is the problem during wet season crop.", style: TextStyle(fontSize:16),),
//                                        SizedBox(height:10),
                                        Table(
                                          columnWidths: {
                                            0: IntrinsicColumnWidth(),
                                            1: IntrinsicColumnWidth(),
                                          },
                                          border: TableBorder.all(color: Colors.grey),
                                          children: [
                                            TableRow(children: [
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Text('CAR', style: TextStyle(fontSize:16),),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Text(allICMFData['CAR'], style: TextStyle(fontSize:16),),
                                              ),
                                            ]),
                                            TableRow(children: [
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Text('I', style: TextStyle(fontSize:16),),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Text(allICMFData['I'], style: TextStyle(fontSize:16),),
                                              ),
                                            ]),
                                            TableRow(children: [
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Text('II', style: TextStyle(fontSize:16),),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Text(allICMFData['II'], style: TextStyle(fontSize:16),),
                                              ),
                                            ]),
                                            TableRow(children: [
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Text('III', style: TextStyle(fontSize:16),),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Text(allICMFData['III'], style: TextStyle(fontSize:16),),
                                              ),
                                            ]),
                                            TableRow(children: [
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Text('IV-A', style: TextStyle(fontSize:16),),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Text(allICMFData['IV-A'], style: TextStyle(fontSize:16),),
                                              ),
                                            ]),
                                            TableRow(children: [
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Text('IV-B', style: TextStyle(fontSize:16),),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Text(allICMFData['IV-B'], style: TextStyle(fontSize:16),),
                                              ),
                                            ]),
                                            TableRow(children: [
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Text('V', style: TextStyle(fontSize:16),),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Text(allICMFData['V'], style: TextStyle(fontSize:16),),
                                              ),
                                            ]),
                                            TableRow(children: [
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Text('VI', style: TextStyle(fontSize:16),),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Text(allICMFData['VI'], style: TextStyle(fontSize:16),),
                                              ),
                                            ]),
                                            TableRow(children: [
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Text('VII', style: TextStyle(fontSize:16),),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Text(allICMFData['VII'], style: TextStyle(fontSize:16),),
                                              ),
                                            ]),
                                            TableRow(children: [
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Text('VIII', style: TextStyle(fontSize:16),),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Text(allICMFData['VIII'], style: TextStyle(fontSize:16),),
                                              ),
                                            ]),
                                            TableRow(children: [
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Text('IX', style: TextStyle(fontSize:16),),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Text(allICMFData['IX'], style: TextStyle(fontSize:16),),
                                              ),
                                            ]),
                                            TableRow(children: [
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Text('X', style: TextStyle(fontSize:16),),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Text(allICMFData['X'], style: TextStyle(fontSize:16),),
                                              ),
                                            ]),
                                            TableRow(children: [
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Text('XI', style: TextStyle(fontSize:16),),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Text(allICMFData['XI'], style: TextStyle(fontSize:16),),
                                              ),
                                            ]),
                                            TableRow(children: [
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Text('XII', style: TextStyle(fontSize:16),),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Text(allICMFData['XII'], style: TextStyle(fontSize:16),),
                                              ),
                                            ]),
                                            TableRow(children: [
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Text('XIII', style: TextStyle(fontSize:16),),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Text(allICMFData['XIII'], style: TextStyle(fontSize:16),),
                                              ),
                                            ]),
                                            TableRow(children: [
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Text('XIV', style: TextStyle(fontSize:16),),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Text(allICMFData['XIV'], style: TextStyle(fontSize:16),),
                                              ),
                                            ]),
                                          ],
                                        ),
                                        SizedBox(height:10),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              ExpansionTile(
                                title: Text(
                                  "Rainfall Threshold for Planting Rice and Corn",
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 14.0,
                                  ),
                                ),
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0,),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Column(
                                              children: <Widget>[
                                                RichText(
                                                    text: TextSpan(
                                                        style: TextStyle(
                                                            color: Colors.blueGrey, fontSize: 16),
                                                        children: <TextSpan>[
                                                          TextSpan(text:"200 mm",style: TextStyle(fontWeight: FontWeight.bold)),
                                                          TextSpan(text:" cumulative rainfall for "),
                                                          TextSpan(text:"Rice",style: TextStyle(fontWeight: FontWeight.bold)),
                                                          TextSpan(text:" in "),
                                                          TextSpan(text:"30 days",style: TextStyle(fontWeight: FontWeight.bold)),
                                                        ]
                                                    )
                                                ),
                                                SizedBox(height:10),
                                                RichText(
                                                    text: TextSpan(
                                                        style: TextStyle(
                                                            color: Colors.blueGrey, fontSize: 16),
                                                        children: <TextSpan>[
                                                          TextSpan(text:"100 mm",style: TextStyle(fontWeight: FontWeight.bold)),
                                                          TextSpan(text:" cumulative rainfall for "),
                                                          TextSpan(text:"Rice",style: TextStyle(fontWeight: FontWeight.bold)),
                                                          TextSpan(text:" in "),
                                                          TextSpan(text:"20 days",style: TextStyle(fontWeight: FontWeight.bold)),
                                                        ]
                                                    )
                                                ),
                                              ]
                                          )
                                      )
                                  ),
                                ],
                              ),
//                              ExpansionTile(
//                                title: Text(
//                                  "iCMF Corn Bulletin for April-August 2020 Based on March 2020 condition",
//                                  style: TextStyle(
//                                    color: Colors.blueGrey,
//                                    fontSize: 14.0,
//                                  ),
//                                ),
//                                children: <Widget>[
//                                  Padding(
//                                      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0,),
//                                      child: Column(
//                                          crossAxisAlignment: CrossAxisAlignment.start,
//                                          children: <Widget>[
//                                            Text("Dr. Artemio Salazar, April 2020",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
//                                            SizedBox(height:10),
//                                            Text("This forecast gives us a glimpse of possible corn production this coming entire wet season i.e. from planting to harvest. Roughly, about 60% of our annual production comes from wet season harvest. We expect a good crop as rains will generally fall in May and there is sustained rainfall for all the subsequent growth stages.",style: TextStyle(color: Colors.blueGrey)),
//                                            SizedBox(height:10),
//                                            RichText(
//                                              text: TextSpan(
//                                                style: TextStyle(
//                                                    color: Colors.blueGrey),
//                                                children: <TextSpan>[
//                                                  TextSpan(text: "We could note from the SARAI rainfall data that Mindanao can plant earlier than Luzon and Visayas. Also, Mindanao is not much affected by typhoon this time of the year, thus it has a wider planting window. It might also have "),
//                                                  TextSpan(text: "post-harvest problems because harvesting in July and August could be very wet", style: new TextStyle(fontWeight: FontWeight.bold)),
//                                                  TextSpan(text: " so it advised that owners/operators of mechanical to condition their facilities as they will most likely have a big need for them. Luzon, and Visayas, will plant a month later i.e. May. However, CAR, Bicol and Eastern Visayas may be able to plant earlier. All the corn planting regions might have good harvest but again, drying at harvest time would be a concern."),
//                                                ],
//                                              ),
//                                            ),
//                                            SizedBox(height:10),
//                                            Text("The same could also be said for other upland crops like upland rice. For lowland rice, it would take at least a month before water from irrigation dams could flow. With such amount of rainfall expected usually this season, farmers in sloping areas using herbicide resistant varieties should adopt appropriate soil conservation practices to avoid or minimize the worrisome soil erosion. Brown colored creeks and rivers and galleys in sloping areas are manifestations of the deterioration of our uplands: the last frontier in our crop production and from where future generations will be fed from.",style: TextStyle(color: Colors.blueGrey)),
//                                          ]
//                                      )
//                                  ),
//                                ],
//                              ),
                            ],
                          )
                      ),

                    ],
                  ),
                ),
              ],
            )
        ),
//        Container(
//            color: Colors.black54,
//            height: 140,
//            child: Container(
//                padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0),
//                child: Column(
//                    children: <Widget>[
//                      Container(
//                          alignment: Alignment.centerLeft,
//                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
//                          child: Text("Connect With Us", style: TextStyle(
//                              fontSize: 23,
//                              color: Colors.white,
//                              fontWeight:FontWeight.bold))
//                      ),
//                      Container(
//                          padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10.0),
//                          child: Column(
//                              children: <Widget>[
//                                Container(
//                                    child: Row(
//                                        children: <Widget>[
//                                          Icon(Icons.phone, color:Colors.white, size:18),
//                                          Text("  +63 (049) 536 2302,+63 (049) 536 2836",style: TextStyle(
//                                              color: Colors.white,
//                                              fontSize: 12,
//                                              fontWeight:FontWeight.w300
//                                          )
//                                          )
//                                        ]
//                                    )
//                                ),
//                                Container(
//                                    padding: EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 0.0),
//                                    child: Row(
//                                        children: <Widget>[
//                                          Icon(Icons.markunread, color:Colors.white, size:18),
//                                          Text("  project.sarai.uplb@gmail.com",style: TextStyle(
//                                              color: Colors.white,
//                                              fontSize: 12,
//                                              fontWeight:FontWeight.w300
//                                          )
//                                          )
//                                        ]
//                                    )
//                                ),
//                                Container(
//                                    padding: EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 0.0),
//                                    child: Row(
//                                        children: <Widget>[
//                                          Icon(Icons.place, color:Colors.white, size:18),
//                                          Text("  SESAM UPLB, College, Laguna Philippines 4031",style: TextStyle(
//                                              color: Colors.white,
//                                              fontSize: 12,
//                                              fontWeight:FontWeight.w300
//                                          )
//                                          )
//                                        ]
//                                    )
//                                ),
//
//                              ]
//                          )
//                      )
//
//                    ]
//                )
//            )
//
//        )
      ],
    );
  }
}
