import 'package:flutter/material.dart';
import 'dart:collection';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DamageReportingItem extends StatefulWidget {
  final details;
  DamageReportingItem({Key key, @required this.details}) : super(key: key);

  @override
  _DamageReportingItemState createState() => _DamageReportingItemState();
}

class _DamageReportingItemState extends State<DamageReportingItem> {
  Completer<GoogleMapController> _controller = Completer();

  static CameraPosition _kGooglePlex;

  Set<Marker> _markers = HashSet<Marker>();
  Set<Polygon> _polygons = HashSet<Polygon>();

  @override
  void initState() {
    super.initState();
    _kGooglePlex = CameraPosition(
      target: LatLng(widget.details['coordinate1'][0], widget.details['coordinate1'][1]),
      zoom: 14.4746,
    );
    _markers.add(Marker(markerId: MarkerId('1'), position: LatLng(widget.details['coordinate1'][0], widget.details['coordinate1'][1])));
    _markers.add(Marker(markerId: MarkerId('1'), position: LatLng(widget.details['coordinate2'][0], widget.details['coordinate2'][1])));
    _markers.add(Marker(markerId: MarkerId('1'), position: LatLng(widget.details['coordinate3'][0], widget.details['coordinate3'][1])));
    _markers.add(Marker(markerId: MarkerId('1'), position: LatLng(widget.details['coordinate4'][0], widget.details['coordinate4'][1])));
    _polygons.add(Polygon(
      polygonId: PolygonId('1'),
      points: [LatLng(widget.details['coordinate1'][0], widget.details['coordinate1'][1]),
        LatLng(14.172270998586377, 121.25192865729332),
        LatLng(14.164724984965636, 121.25152699649334),
        LatLng(14.165503556113446, 121.24118071049452)
      ],
      strokeWidth: 2,
      strokeColor: Colors.green,
      fillColor: Colors.green.withOpacity(0.15)
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Damage Reporting Details'),
        centerTitle: true,
        elevation: 0,
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        markers: _markers,
        polygons: _polygons,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
