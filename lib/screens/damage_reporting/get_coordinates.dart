import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:bantay_sarai/screens/damage_reporting/finalize_report.dart';

class GetCoordinates extends StatefulWidget {
  final List<String> selectedCrops;
  final String causeOL, extentOL;
  final DateTime dateOL, estimatedDOH;
  GetCoordinates({Key key, @required this.selectedCrops, this.causeOL, this.dateOL, this.extentOL, this.estimatedDOH}) : super(key: key);

  @override
  _GetCoordinatesState createState() => _GetCoordinatesState();
}

class _GetCoordinatesState extends State<GetCoordinates> {
  List<File> _image = [null,null,null,null];
  List<Position> _coordinates = [null,null,null,null];

  Future getImage(index) async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    Position coordinates = await _determinePosition();

    setState(() {
      _coordinates[index] = coordinates;
      _image[index] = image;
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
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Images and Coordinates'),
          centerTitle: true,
          elevation: 0,
        ),
        body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Get 1st image'),
                    ),
                    onPressed: () async {
                      getImage(0);
                    },
                  ),
                _image[0] == null
                  ? Text('No image selected.')
                  : Image.file(_image[0]),
                _coordinates[0] == null
                    ? Text('No coordinates yet.')
                    : Text('[' + _coordinates[0].longitude.toString() + ',' + _coordinates[0].latitude.toString() + ']'),
                  ElevatedButton(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Get 2nd image'),
                    ),
                    onPressed: () {
                      getImage(1);
                    },
                  ),
                  _image[1] == null
                      ? Text('No image selected.')
                      : Image.file(_image[1]),
                  _coordinates[1] == null
                      ? Text('No coordinates yet.')
                      : Text('[' + _coordinates[1].longitude.toString() + ',' + _coordinates[1].latitude.toString() + ']'),
                  ElevatedButton(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Get 3rd image'),
                    ),
                    onPressed: () {
                      getImage(2);
                    },
                  ),
                  _image[2] == null
                      ? Text('No image selected.')
                      : Image.file(_image[2]),
                  _coordinates[2] == null
                      ? Text('No coordinates yet.')
                      : Text('[' + _coordinates[2].longitude.toString() + ',' + _coordinates[2].latitude.toString() + ']'),
                  ElevatedButton(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Get 4th image'),
                    ),
                    onPressed: () {
                      getImage(3);
                    },
                  ),
                  _image[3] == null
                      ? Text('No image selected.')
                      : Image.file(_image[3]),
                  _coordinates[3] == null
                      ? Text('No coordinates yet.')
                      : Text('[' + _coordinates[3].longitude.toString() + ',' + _coordinates[3].latitude.toString() + ']'),
                  ElevatedButton(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Proceed'),
                    ),
                    onPressed: () {
                      if(_image.where((element) => element == null).length==0){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FinalizeReport(selectedCrops: widget.selectedCrops, causeOL: widget.causeOL,dateOL: widget.dateOL,extentOL: widget.extentOL,estimatedDOH: widget.estimatedDOH, coordinates: _coordinates, images: _image)),
                        );
                      }
                      else{
                        showToast('Please make sure all images are taken', Colors.red);
                      }
                    },
                  ),
                ],
              ),
            )
        )
    );
  }
}
