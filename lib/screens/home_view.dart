
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bantay_sarai/widgets/provider_widget.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: getUsersTripsStreamSnapshots(context),
          builder: (context, snapshot) {
            if(!snapshot.hasData) return Center(child: CircularProgressIndicator());
            return new ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) =>
                    buildTripCard(context, snapshot.data.documents[index]));
          }
      ),
    );
  }

  Stream<QuerySnapshot> getUsersTripsStreamSnapshots(BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* FirebaseFirestore.instance.collection('userData').doc(uid).collection('farms').snapshots();
  }

  Widget buildTripCard(BuildContext context, DocumentSnapshot farm) {
    return new Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Text(farm['farmName'], style: new TextStyle(fontSize: 30.0),),
                  Spacer(),
                ]),
              ),
              Text(farm['farmName']),
              Text(farm['cropsPlanted']),
              Text(farm['annualIncome']),
              Text(farm['location']),
              Text(farm['farmSize']),
              Text(farm['farmType']),
              Text(farm['organicPractitioner']),
              Text(farm['farmOwnership']),
            ],
          ),
        ),
      ),
    );
  }
}
