class User {
  String lastName;
  String firstName;
  String middleName;
  String birthDate;
  String placeOfBirth;
  String sex;
  String isPwd;
  String membership;

  User(this.lastName,this.firstName,this.middleName,this.birthDate,this.placeOfBirth,this.sex,this.isPwd,this.membership);

  Map<String, dynamic> toJson() => {
    'lastName': lastName,
    'firstName': firstName,
    'middleName': middleName,
    'birthDate': birthDate,
    'placeOfBirth': placeOfBirth,
    'sex': sex,
    'isPwd': isPwd,
    'membership': membership,
  };
}