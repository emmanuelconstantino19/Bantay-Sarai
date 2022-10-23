import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io';
// import 'package:fluttertoast/fluttertoast.dart';

import 'package:bantay_sarai/screens/damage_reporting/finalize_report.dart';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'package:uuid/uuid.dart';

class GetCoordinates extends StatefulWidget {
  final List<String> selectedCrops;
  final String causeOL, extentOL;
  final DateTime dateOL, estimatedDOH;
  final details;
  GetCoordinates({Key key, @required this.selectedCrops, this.causeOL, this.dateOL, this.extentOL, this.estimatedDOH, this.details}) : super(key: key);

  @override
  _GetCoordinatesState createState() => _GetCoordinatesState();
}

class _GetCoordinatesState extends State<GetCoordinates> {
  List<File> _image = [null,null,null,null];
  List<Position> _coordinates = [null,null,null,null];

  @override
  void initState() {
    super.initState();

    if(widget.details!=null) {
      _coordinates[0] = Position(latitude: widget.details['coordinate1'][0], longitude: widget.details['coordinate1'][1]);
      _coordinates[1] = Position(latitude: widget.details['coordinate2'][0], longitude: widget.details['coordinate2'][1]);
      _coordinates[2] = Position(latitude: widget.details['coordinate3'][0], longitude: widget.details['coordinate3'][1]);
      _coordinates[3] = Position(latitude: widget.details['coordinate4'][0], longitude: widget.details['coordinate4'][1]);

      for(var i = 0 ; i < widget.details['urls'].length; i++){
        urlToFile(widget.details['urls'][i]).then((result) {
          print("result: $result");
          setState(() {
            if(i<4) {
              _image[i] = result;
            } else {
              _image.add(result);
            }
          });
        });
      }
    }
  }

  urlToFile(String imageUrl) async {
    // generate random number.
    var uuid = Uuid();
// get temporary directory of device.
    Directory tempDir = await getTemporaryDirectory();
// get temporary path from temporary directory.
    String tempPath = tempDir.path;
// create a new file in temporary path with random file name.
    File file = new File('$tempPath'+ uuid.v1().toString() +'.png');
// call http.get method and pass imageUrl into it to get response.
    http.Response response = await http.get(Uri.parse(imageUrl));
// write bodyBytes received in response to file.
    await file.writeAsBytes(response.bodyBytes);
// now return the file which is created with random name in
// temporary directory and image bytes from response is written to // that file.
    return file;
  }

  Future getImage(index) async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 20);
    Position coordinates;
    if(image!=null){
      coordinates = await _determinePosition();
    }

    setState(() {
      if(image!=null){
        _coordinates[index] = coordinates;
        _image[index] = File(image.path);
      }
    });
  }

  Future takeAdditionalImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 20);
    setState(() {
      if(image!=null){
        _image.add(File(image.path));
      }
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void showToast(message, Color color) {
    print(message);
    // Fluttertoast.showToast(
    //     msg: message,
    //     toastLength: Toast.LENGTH_LONG,
    //     gravity: ToastGravity.BOTTOM,
    //     backgroundColor: color,
    //     textColor: Colors.white,
    //     fontSize: 16.0);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Images and Coordinates'),
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/10, vertical: 20),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          _image[0] == null
                              ? Image.asset('assets/images/placeholder.jpg',height: 100)
                              : Image.file(_image[0], height:100),
                          ListTile(
//                                leading: Icon(Icons.mobile_friendly),
                            title: const Text('Image 1'),
                            subtitle: Text(
                              _coordinates[0] == null ? 'No coordinates yet' : '[' + _coordinates[0].latitude.toStringAsFixed(3) + ', ' + _coordinates[0].longitude.toStringAsFixed(3) + ']',
                              style: TextStyle(color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                          TextButton.icon(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                            ),
                            onPressed: () async {
                              await getImage(0);
                            },
                            label: const Text('ADD IMAGE'),
                            icon: Icon(Icons.add_a_photo),
                          ),
//                      Image.asset('assets/card-sample-image-2.jpg'),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          _image[1] == null
                              ? Image.asset('assets/images/placeholder.jpg',height: 100,)
                              : Image.file(_image[1], height:100),
                          ListTile(
//                                leading: Icon(Icons.mobile_friendly),
                            title: const Text('Image 2'),
                            subtitle: Text(
                              _coordinates[1] == null ? 'No coordinates yet' : '[' + _coordinates[1].latitude.toStringAsFixed(3) + ', ' + _coordinates[1].longitude.toStringAsFixed(3) + ']',
                              style: TextStyle(color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                          TextButton.icon(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                            ),
                            onPressed: () async {
                              await getImage(1);
                            },
                            label: const Text('ADD IMAGE'),
                            icon: Icon(Icons.add_a_photo),
                          ),
//                      Image.asset('assets/card-sample-image-2.jpg'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          _image[3] == null
                              ? Image.asset('assets/images/placeholder.jpg',height: 100,)
                              : Image.file(_image[3], height:100),
                          ListTile(
//                                leading: Icon(Icons.mobile_friendly),
                            title: const Text('Image 4'),
                            subtitle: Text(
                              _coordinates[3] == null ? 'No coordinates yet' : '[' + _coordinates[3].latitude.toStringAsFixed(3) + ', ' + _coordinates[3].longitude.toStringAsFixed(3) + ']',
                              style: TextStyle(color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                          TextButton.icon(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                            ),
                            onPressed: () async {
                              await getImage(3);
                            },
                            label: const Text('ADD IMAGE'),
                            icon: Icon(Icons.add_a_photo),
                          ),
//                      Image.asset('assets/card-sample-image-2.jpg'),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          _image[2] == null
                              ? Image.asset('assets/images/placeholder.jpg',height: 100,)
                              : Image.file(_image[2], height:100),
                          ListTile(
//                                leading: Icon(Icons.mobile_friendly),
                            title: const Text('Image 3'),
                            subtitle: Text(
                              _coordinates[2] == null ? 'No coordinates yet' : '[' + _coordinates[2].latitude.toStringAsFixed(3) + ', ' + _coordinates[2].longitude.toStringAsFixed(3) + ']',
                              style: TextStyle(color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                          TextButton.icon(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                            ),
                            onPressed: () async {
                              await getImage(2);
                            },
                            label: const Text('ADD IMAGE'),
                            icon: Icon(Icons.add_a_photo),
                          ),
//                      Image.asset('assets/card-sample-image-2.jpg'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Visibility(
                child: SizedBox(
                  height:200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _image.length,
                    itemBuilder: (context, index) {
                      return index > 3 ?

                      Stack(
                        children: <Widget>[
                          Image.file(_image[index]),
                          Positioned(
                            top: 5,
                            right: 5,
                            child: GestureDetector(
                              onTap: (){
                                print('delete image from List');
                                setState((){
                                  print('set new state of images');
                                });
                                _image.removeAt(index);
                              },
                              child: Container(
                                color: Colors.red,
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                          :
                      Container();
                    },
                  ),
                ),
                visible: _image.length > 4,
              ),
              SizedBox(height:20),
              Row(
                children: [
                  SizedBox(width:5),
                  Expanded(
                    child: OutlinedButton(
                    onPressed: () async {
                      await takeAdditionalImage();
                    },
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Take additional photos'),
                    ), style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    ),),
                  ),
                  SizedBox(width:5),
                ],
              ),
              SizedBox(height:20),
              Row(
                children: [
                  SizedBox(width:5),
                  Expanded(child: ElevatedButton(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Proceed'),
                    ),
                    onPressed: () {
                      if(_image.where((element) => element == null).length==0){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FinalizeReport(selectedCrops: widget.selectedCrops, causeOL: widget.causeOL,dateOL: widget.dateOL,extentOL: widget.extentOL,estimatedDOH: widget.estimatedDOH, coordinates: _coordinates, images: _image, details: widget.details)),
                        );
                      }
                      else{
                        showToast('Please make sure all images are taken', Colors.red);
                      }
                    },
                  ),),
                  SizedBox(width:5),
                ],
              ),
            ],
          ),
        )
    );
  }
}
