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
  List<double> coordinates;


  Farm(
      this.farmName,
      this.cropsPlanted,
      this.annualIncome,
      this.location,
      this.farmSize,
      this.farmType,
      this.organicPractitioner,
      this.farmOwnership,
      this.coordinates,
      );

  Map<String, dynamic> toJson() => {
    'farmName': farmName,
    'cropsPlanted': cropsPlanted,
    'annualIncome': annualIncome,
    'location': location,
    'farmSize': farmSize,
    'farmType': farmType,
    'organicPractitioner': organicPractitioner,
    'farmOwnership': farmOwnership,
    'coordinates': coordinates,
  };

  Farm.fromSnapshot(DocumentSnapshot snapshot) :
        farmName = snapshot['farmName'],
        cropsPlanted = snapshot['cropsPlanted'],
        annualIncome = snapshot['annualIncome'],
        location = snapshot['location'],
        farmSize = snapshot['farmSize'],
        farmType = snapshot['farmType'],
        organicPractitioner = snapshot['organicPractitioner'],
        farmOwnership = snapshot['farmOwnership'],
        coordinates = snapshot['coordinates'];
}

class FarmRecord {
  String farmName;
  String cropsPlanted;
  String annualIncome;
  String location;
  String farmSize;
  String farmType;
  String organicPractitioner;
  String farmOwnership;
  DateTime plantedDate;
  DateTime harvestingDate;


  FarmRecord(
      this.farmName,
      this.cropsPlanted,
      this.annualIncome,
      this.location,
      this.farmSize,
      this.farmType,
      this.organicPractitioner,
      this.farmOwnership,
      this.plantedDate,
      this.harvestingDate
      );

  Map<String, dynamic> toJson() => {
    'farmName': farmName,
    'cropsPlanted': cropsPlanted,
    'annualIncome': annualIncome,
    'location': location,
    'farmSize': farmSize,
    'farmType': farmType,
    'organicPractitioner': organicPractitioner,
    'farmOwnership': farmOwnership,
    'plantedDate': plantedDate,
    'harvestingDate': harvestingDate,
  };
}