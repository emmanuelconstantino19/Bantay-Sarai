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
}