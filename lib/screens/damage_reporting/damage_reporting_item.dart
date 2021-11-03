import 'package:flutter/material.dart';
import 'dart:collection';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class ImageDetails extends StatefulWidget {
  final String imageUrl, heroTag;
  ImageDetails({Key key, @required this.imageUrl, this.heroTag}) : super(key: key);

  @override
  _ImageDetailsState createState() => _ImageDetailsState();
}

class _ImageDetailsState extends State<ImageDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: widget.heroTag,
            child: Image.network(
              widget.imageUrl,
            ),
          ),
        ),
      ),
    );
  }
}


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
        LatLng(widget.details['coordinate2'][0], widget.details['coordinate2'][1]),
        LatLng(widget.details['coordinate3'][0], widget.details['coordinate3'][1]),
        LatLng(widget.details['coordinate4'][0], widget.details['coordinate4'][1])
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
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              mapType: MapType.hybrid,
              markers: _markers,
              polygons: _polygons,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          SizedBox(
            height:150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.details['urls'].length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return ImageDetails(imageUrl: widget.details['urls'][index], heroTag: 'imageHero' + index.toString(),);
                    }));
                  },
                  child: Hero(
                    tag: 'imageHero' + index.toString(),
                    child: Image.network(widget.details['urls'][index],),
                  ),
                );
              },
            ),
          ),
          DataTable(
//                  columnSpacing: 15,
            horizontalMargin: 0,
            headingRowHeight: 0,
            columns: [
              DataColumn(label: Text('Fields')),
              DataColumn(label: Text('Values')),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text("Selected Crops", style: TextStyle(fontWeight: FontWeight.bold),)),
                DataCell(Text(widget.details['crops'].join(','))),
              ]),
              DataRow(cells: [
                DataCell(Text("Cause of loss", style: TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Text(widget.details['causeOfLoss'])),
              ]),
              DataRow(cells: [
                DataCell(Text("Date of loss", style: TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Text(DateFormat('MMMM dd, yyyy').format(widget.details['dateOfLoss'].toDate()))),
              ]),
              DataRow(cells: [
                DataCell(Text("Extent of Loss / Damage", style: TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Text(widget.details['extentOfLoss'])),
              ]),
              DataRow(cells: [
                DataCell(Text("Estimated date of harvest", style: TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Text(DateFormat('MMMM dd, yyyy').format(widget.details['estimatedDOH'].toDate()))),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
