import 'package:cloud_firestore/cloud_firestore.dart';
class Record {
  DateTime landPreparationDate;
  DateTime seedlingPreparationDate;
  DateTime plantedDate;
  DateTime targetDateOfHarvest;
  String targetMarket;
  String expectedQtyOfHarvest;
  DateTime harvestDate;
  String qtyOfHarvest;
  String qtyOfHarvestSold;
  String grossIncome;
  String netIncome;
  String harvestingProcedure;


  Record(
      this.landPreparationDate,
      this.seedlingPreparationDate,
      this.plantedDate,
      this.targetDateOfHarvest,
      this.targetMarket,
      this.expectedQtyOfHarvest,
      this.harvestDate,
      this.qtyOfHarvest,
      this.qtyOfHarvestSold,
      this.grossIncome,
      this.netIncome,
      this.harvestingProcedure
      );

  Map<String, dynamic> toJson() => {
    'landPreparationDate': landPreparationDate,
    'seedlingPreparationDate': seedlingPreparationDate,
    'plantedDate': plantedDate,
    'targetDateOfHarvest': targetDateOfHarvest,
    'targetMarket': targetMarket,
    'expectedQtyOfHarvest': expectedQtyOfHarvest,
    'harvestDate': harvestDate,
    'qtyOfHarvest': qtyOfHarvest,
    'qtyOfHarvestSold': qtyOfHarvestSold,
    'grossIncome': grossIncome,
    'netIncome': netIncome,
    'harvestingProcedure': harvestingProcedure,
  };
}