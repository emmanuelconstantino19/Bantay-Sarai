import 'package:cloud_firestore/cloud_firestore.dart';
class Farm {
  String farmName;
  String cropsPlanted;
  String annualIncome;
  String location;
  String farmSize;
  String farmType;
  String organicPractitioner;
  String farmOwnership;


  Farm(
      this.farmName,
      this.cropsPlanted,
      this.annualIncome,
      this.location,
      this.farmSize,
      this.farmType,
      this.organicPractitioner,
      this.farmOwnership,
      );

  Map<String, dynamic> toJson() => {
    'farmName': farmName,
    'cropsPlanted': cropsPlanted,
    'annualIncome': annualIncome,
    'location': location,
    'farmSize': farmSize,
    'farmType': farmType,
    'organicPractitioner': organicPractitioner,
    'farmOwnership': farmOwnership
  };

  Farm.fromSnapshot(DocumentSnapshot snapshot) :
        farmName = snapshot.data['farmName'],
        cropsPlanted = snapshot.data['cropsPlanted'],
        annualIncome = snapshot.data['annualIncome'],
        location = snapshot.data['location'],
        farmSize = snapshot.data['farmSize'],
        farmType = snapshot.data['farmType'],
        organicPractitioner = snapshot.data['organicPractitioner'],
        farmOwnership = snapshot.data['farmOwnership'];

}