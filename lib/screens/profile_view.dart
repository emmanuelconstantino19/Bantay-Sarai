import 'package:flutter/material.dart';
import 'package:bantay_sarai/widgets/provider_widget.dart';
import 'package:intl/intl.dart';
import 'package:bantay_sarai/models/User.dart';
import 'package:bantay_sarai/widgets/custome_list_tile.dart';
import 'package:bantay_sarai/widgets/small_button.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  FUser user = FUser("","","","","","","","");
  final TextEditingController _fnameControl = new TextEditingController();
  final TextEditingController _lnameControl = new TextEditingController();
  final TextEditingController _mnameControl = new TextEditingController();
  final TextEditingController _mshipControl = new TextEditingController();
  final TextEditingController _bdayControl = new TextEditingController();
  final TextEditingController _placeControl = new TextEditingController();
  final TextEditingController _sexControl = new TextEditingController();
  final TextEditingController _isPWDControl = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String loc = '', noOfFarms = '', noOfCrops = '';
  String sex, isPWD;
  DateTime _dateOfBirth;

  void showToast(message, Color color) {
    print(message);
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Column(
            children: <Widget>[
              FutureBuilder(
                future: Provider
                    .of(context)
                    .auth
                    .getCurrentUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return displayUserInformation(context, snapshot);
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              )
            ],
          ),
        ),
      )
    );
  }

  Widget displayUserInformation(context, snapshot) {
    final authData = snapshot.data;
    print(authData);
    return Column(
      children: <Widget>[
        FutureBuilder(
            future: _getProfileData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                _fnameControl.text = user.firstName;
                _lnameControl.text = user.lastName;
                _mnameControl.text = user.middleName;
                _bdayControl.text = user.birthDate;
                _placeControl.text = user.placeOfBirth;
                sex = (user.sex=="Male" || user.sex=="Female") ? user.sex : null;
                isPWD = (user.isPwd=="Yes" || user.isPwd=="No") ? user.isPwd : null;
//                _isPWDControl.text = user.isPwd;
                _mshipControl.text = user.membership;

                return SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0,vertical:20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Profile",
                          style: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
//                            Container(
//                              height: 120.0,
//                              width: 120.0,
//                              decoration: BoxDecoration(
//                                borderRadius: BorderRadius.circular(60.0),
//                                boxShadow: [
//                                  BoxShadow(
//                                      blurRadius: 3.0,
//                                      offset: Offset(0, 4.0),
//                                      color: Colors.black38),
//                                ],
//                                image: DecorationImage(
//                                  image: AssetImage(
//                                    "assets/images/tomato1.png",
//                                  ),
//                                  fit: BoxFit.cover,
//                                ),
//
//                              ),
//                            ),
//                            SizedBox(
//                              width: 20.0,
//                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  _fnameControl.text + " " + _lnameControl.text,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  authData.phoneNumber,
                                  style: TextStyle(color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                InkWell(
                                  child: SmallButton(btnText: "Edit"),
                                  onTap: () {
                                    _userEditBottomSheet(context);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          "Account Details",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Card(
                          elevation: 3.0,
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Text('Place of birth: ' + _placeControl.text, style: TextStyle(fontSize: 14),),
                                ),
                                Divider(
                                  height: 10.0,
                                  color: Colors.grey,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text('Birthday: ' + _bdayControl.text, style: TextStyle(fontSize: 14),),
                                ),
                                Divider(
                                  height: 10.0,
                                  color: Colors.grey,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text('Sex: ${(sex==null) ? "":sex}', style: TextStyle(fontSize: 14),),
                                ),
                                Divider(
                                  height: 10.0,
                                  color: Colors.grey,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text('Membership: ' + _mshipControl.text, style: TextStyle(fontSize: 14),),
                                ),
                                Divider(
                                  height: 10.0,
                                  color: Colors.grey,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text('PWD: ${(isPWD==null) ? "":isPWD}', style: TextStyle(fontSize: 14),),
                                ),
                                Divider(
                                  height: 10.0,
                                  color: Colors.grey,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text('Number of farms: ' + noOfFarms, style: TextStyle(fontSize: 14),),
                                ),
                                Divider(
                                  height: 10.0,
                                  color: Colors.grey,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text('Crops: ' + noOfCrops, style: TextStyle(fontSize: 14),),
                                ),
                                Divider(
                                  height: 10.0,
                                  color: Colors.grey,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text('Farm Location: ' + loc, style: TextStyle(fontSize: 14),),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }else{
                return Center(child: CircularProgressIndicator());
              }

            }
        ),


        //showSignOut(context, user.isAnonymous),
      ],
    );
  }

  _getProfileData() async {
    List<String> cropList = [];
    final uid = await Provider.of(context).auth.getCurrentUID();
    await Provider.of(context)
        .db
        .collection('userData')
        .document(uid)
        .get().then((result) {
      user.firstName = result.data['firstName'];
      user.lastName = result.data['lastName'];
      user.middleName = result.data['middleName'];
      user.birthDate = result.data['birthDate'];
      user.placeOfBirth = result.data['placeOfBirth'];
      user.sex = result.data['sex'];
      user.isPwd = result.data['isPwd'];
      user.membership = result.data['membership'];
    });

    await Provider.of(context)
        .db
        .collection('userData')
        .document(uid)
        .collection('farms').getDocuments().then((result) {
      result.documents.forEach((f) => cropList.add(f['cropsPlanted']));
      noOfCrops = cropList.toSet().toList().join(", ");
      noOfFarms = result.documents.length.toString();
      loc = result.documents[0]['location'];
    });
  }

//  Future<Null> _selectDate(BuildContext context, updateState) async {
//    DateTime _datePicker = await showDatePicker(
//      context: context,
//      initialDate: DateTime.now().subtract(Duration(days:3650)),
//      firstDate: DateTime(1950),
//      lastDate: DateTime.now().subtract(Duration(days:3650)),
//      initialDatePickerMode: DatePickerMode.year,
//    );
//
//    if (_datePicker != null && _datePicker != _dateOfBirth) {
//      updateState(() {
//        _dateOfBirth = _datePicker;
//        print(_dateOfBirth.toString());
//      });
//    }
//  }

  void _userEditBottomSheet(BuildContext context) {
    showDialog<String>(
      context: context,
      barrierDismissible: false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, updateState){
            return AlertDialog(
              title: Text('Update Profile'),
              content: Container(
                  child: SingleChildScrollView(
                      child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                validator: (val) => val.isEmpty ? 'field required' : null,
                                autofocus: true,
                                decoration: new InputDecoration(
                                    labelText: 'First Name'),
                                controller: _fnameControl,
                              ),
                              TextFormField(
                                validator: (val) => val.isEmpty ? 'field required' : null,
                                autofocus: true,
                                decoration: new InputDecoration(
                                    labelText: 'Last Name'),
                                controller: _lnameControl,
                              ),
                              TextFormField(
                                validator: (val) => val.isEmpty ? 'field required' : null,
                                autofocus: true,
                                decoration: new InputDecoration(
                                    labelText: 'Middle Name'),
                                controller: _mnameControl,
                              ),
//                              TextFormField(
//                                validator: (val) => val.isEmpty ? 'field required' : null,
//                                autofocus: true,
//                                decoration: new InputDecoration(
//                                    labelText: 'Date of birth'),
//                                controller: _bdayControl,
//                              ),
//                              TextFormField(
//                                validator: (val) => val.isEmpty ? 'field required' : null,
//                                decoration: InputDecoration(
//                                    labelText: 'Birthday',
//                                    hintText: _dateOfBirth == null ? "" : DateFormat('MMMM dd, yyyy').format(_dateOfBirth)),
//                                onTap: (){
//                                  setState(() {
//                                    _selectDate(context, updateState);
//                                  });
//                                },
//                              ),
                              Card(
                                clipBehavior: Clip.antiAlias,
                                child: ListTile(
//                            leading: Icon(Icons.arrow_drop_down_circle),
                                  title: const Text('Birthday'),
                                  subtitle: _dateOfBirth == null ? Row(
                                    children: [
                                      Icon(
                                          Icons.error,
                                          color: Colors.red,
                                          size:15
                                      ),
                                    ],
                                  ) : Text(
                                      DateFormat('MMMM dd, yyyy').format(_dateOfBirth)
                                  ),
                                  trailing: ElevatedButton.icon(
                                    label: Text('Set Date'),
                                    icon: Icon(Icons.date_range),
                                    onPressed: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now().subtract(Duration(days:3650)),
                                        firstDate: DateTime(1940),
                                        lastDate:  DateTime.now().subtract(Duration(days:3650)),
                                        initialDatePickerMode: DatePickerMode.year,
                                      ).then((date) {
                                        updateState((){
                                          _dateOfBirth = date;
                                        });
                                      });
                                    },
                                  ),
                                ),
                              ),
                              TextFormField(
                                validator: (val) => val.isEmpty ? 'field required' : null,
                                autofocus: true,
                                decoration: new InputDecoration(
                                    labelText: 'Place of birth'),
                                controller: _placeControl,
                              ),
//                              TextFormField(
//                                validator: (val) => val.isEmpty ? 'field required' : null,
//                                autofocus: true,
//                                decoration: new InputDecoration(
//                                    labelText: 'Sex'),
//                                controller: _sexControl,
//                              ),
                              DropdownButtonFormField<String>(
                                validator: (value) => value == null ? 'field required' : null,
                                value: sex,
                                decoration: new InputDecoration(
//                                border: OutlineInputBorder(),
//                                fillColor: Colors.white,
//                                filled: true,
                                    labelText: 'Sex'),
                                onChanged: (String newValue) {
                                  updateState(() {
                                    sex = newValue;
                                  });
                                },
                                items: <String>[
                                  'Male',
                                  'Female'
                                ]
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                              DropdownButtonFormField<String>(
                                validator: (value) => value == null ? 'field required' : null,
                                value: isPWD,
                                decoration: new InputDecoration(
//                                border: OutlineInputBorder(),
//                                fillColor: Colors.white,
//                                filled: true,
                                    labelText: 'Person with Disability'),
                                onChanged: (String newValue) {
                                  updateState(() {
                                    isPWD = newValue;
                                  });
                                },
                                items: <String>[
                                  'Yes',
                                  'No'
                                ]
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
//                              TextFormField(
//                                validator: (val) => val.isEmpty ? 'field required' : null,
//                                autofocus: true,
//                                decoration: new InputDecoration(
//                                    labelText: 'Person with Disability [Y/N]'),
//                                controller: _isPWDControl,
//                              ),
                              TextFormField(
                                validator: (val) => val.isEmpty ? 'field required' : null,
                                autofocus: true,
                                decoration: new InputDecoration(
                                    labelText: 'Membership'),
                                controller: _mshipControl,
                              ),
                            ],
                          )
                      )
                  )
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Cancel',
                    style: TextStyle(color: Colors.grey),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                RaisedButton(
                  child: Text('Save'),
                  color: Colors.green,
                  textColor: Colors.white,
                  onPressed: () async {
                    if(_formKey.currentState.validate() && _dateOfBirth!=null){
                      user.firstName = _fnameControl.text;
                      user.lastName = _lnameControl.text;
                      user.middleName = _mnameControl.text;
//                      user.birthDate = _bdayControl.text;
                      user.birthDate = DateFormat('MMMM dd, yyyy').format(_dateOfBirth);
                      user.placeOfBirth = _placeControl.text;
//                      user.sex = _sexControl.text;
                      user.sex = sex;
//                      user.isPwd = _isPWDControl.text;
                      user.isPwd = isPWD;
                      user.membership = _mshipControl.text;
                      setState(() {
                        _fnameControl.text = user.firstName;
                        _lnameControl.text = user.lastName;
                        _mnameControl.text = user.middleName;
//                        _bdayControl.text = user.birthDate;
                        _placeControl.text = user.placeOfBirth;
//                        _sexControl.text = user.sex;
                        sex = user.sex;
//                        _isPWDControl.text = user.isPwd;
                        isPWD = user.isPwd;
                        _mshipControl.text = user.membership;

                      });
                      final uid =
                      await Provider.of(context).auth.getCurrentUID();
                      await Provider.of(context)
                          .db
                          .collection('userData')
                          .document(uid)
                          .setData(user.toJson());
                      Navigator.of(context).pop();
                    }else{
                      showToast('Please complete the form.', Colors.red);
                    }
                  },
                )
              ],
            );
          }
        );
      },
    );
  }
}


//class ProfileView extends StatefulWidget {
//  @override
//  _ProfileViewState createState() => _ProfileViewState();
//}
//
//class _ProfileViewState extends State<ProfileView> {
//  FUser user = FUser("","","","","","","","");
//  final TextEditingController _fnameControl = new TextEditingController();
//  final TextEditingController _lnameControl = new TextEditingController();
//  final TextEditingController _mnameControl = new TextEditingController();
//  final TextEditingController _mshipControl = new TextEditingController();
//  final TextEditingController _bdayControl = new TextEditingController();
//  final TextEditingController _placeControl = new TextEditingController();
//  final TextEditingController _sexControl = new TextEditingController();
//  final TextEditingController _isPWDControl = new TextEditingController();
//
//  @override
//  Widget build(BuildContext context) {
//    return SingleChildScrollView(
//      child: Container(
//        width: MediaQuery
//            .of(context)
//            .size
//            .width,
//        child: Column(
//          children: <Widget>[
//            FutureBuilder(
//              future: Provider
//                  .of(context)
//                  .auth
//                  .getCurrentUser(),
//              builder: (context, snapshot) {
//                if (snapshot.connectionState == ConnectionState.done) {
//                  return displayUserInformation(context, snapshot);
//                } else {
//                  return CircularProgressIndicator();
//                }
//              },
//            )
//          ],
//        ),
//      ),
//    );
//  }
//
//  Widget displayUserInformation(context, snapshot) {
//    final authData = snapshot.data;
//    print(authData);
//
//    return Column(
//      children: <Widget>[
//        FutureBuilder(
//            future: _getProfileData(),
//            builder: (context, snapshot) {
//              if (snapshot.connectionState == ConnectionState.done) {
//                _fnameControl.text = user.firstName;
//                _lnameControl.text = user.lastName;
//                _mnameControl.text = user.middleName;
//                _bdayControl.text = user.birthDate;
//                _placeControl.text = user.placeOfBirth;
//                _sexControl.text = user.sex;
//                _isPWDControl.text = user.isPwd;
//                _mshipControl.text = user.membership;
//
//                return Container(
//                  child: Column(
//                    children: <Widget>[
//                      Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: Text(
//                          "first name: ${_fnameControl.text}",
//                          style: TextStyle(fontSize: 20),
//                        ),
//                      ),
//                      Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: Text(
//                          "last name: ${_lnameControl.text}",
//                          style: TextStyle(fontSize: 20),
//                        ),
//                      ),
//                      Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: Text(
//                          "middle name: ${_mnameControl.text}",
//                          style: TextStyle(fontSize: 20),
//                        ),
//                      ),
//                      Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: Text(
//                          "birthday: ${_bdayControl.text}",
//                          style: TextStyle(fontSize: 20),
//                        ),
//                      ),
//                      Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: Text(
//                          "place of birth: ${_placeControl.text}",
//                          style: TextStyle(fontSize: 20),
//                        ),
//                      ),
//                      Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: Text(
//                          "sex: ${_sexControl.text}",
//                          style: TextStyle(fontSize: 20),
//                        ),
//                      ),
//                      Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: Text(
//                          "Person with Disability: ${_isPWDControl.text}",
//                          style: TextStyle(fontSize: 20),
//                        ),
//                      ),
//                      Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: Text(
//                          "membership: ${_mshipControl.text}",
//                          style: TextStyle(fontSize: 20),
//                        ),
//                      ),
//                      Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: Text("Contact number: ${authData.phoneNumber ?? 'Anonymous'}", style: TextStyle(fontSize: 20),),
//                      ),
//
//                      Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: Text("Created: ${DateFormat('MM/dd/yyyy').format(
//                            authData.metadata.creationTime)}", style: TextStyle(fontSize: 20),),
//                      ),
//                      RaisedButton(
//                        child: Text("Edit User"),
//                        onPressed: () {
//                          _userEditBottomSheet(context);
//                        },
//                      )
//                    ],
//                  ),
//                );
//              }else{
//                return Center(child: CircularProgressIndicator());
//              }
//
//            }
//        ),
//
//
//        //showSignOut(context, user.isAnonymous),
//      ],
//    );
//  }
//
//  _getProfileData() async {
//    final uid = await Provider.of(context).auth.getCurrentUID();
//    await Provider.of(context)
//        .db
//        .collection('userData')
//        .document(uid)
//        .get().then((result) {
//      user.firstName = result.data['firstName'];
//      user.lastName = result.data['lastName'];
//      user.middleName = result.data['middleName'];
//      user.birthDate = result.data['birthDate'];
//      user.placeOfBirth = result.data['placeOfBirth'];
//      user.sex = result.data['sex'];
//      user.isPwd = result.data['isPwd'];
//      user.membership = result.data['membership'];
//    });
//  }
//
//  void _userEditBottomSheet(BuildContext context) {
//    showDialog<String>(
//      context: context,
//      barrierDismissible: false, // dialog is dismissible with a tap on the barrier
//      builder: (BuildContext context) {
//        return AlertDialog(
//          title: Text('Update Profile'),
//          content: Container(
//              child: SingleChildScrollView(
//                  child: Column(
//                    children: <Widget>[
//                      TextField(
//                        controller: _fnameControl,
//                        autofocus: true,
//                        decoration: new InputDecoration(
//                            labelText: 'First Name'),
//                      ),
//                      TextField(
//                        controller: _lnameControl,
//                        autofocus: true,
//                        decoration: new InputDecoration(
//                            labelText: 'Last Name'),
//                      ),
//                      TextField(
//                        controller: _mnameControl,
//                        autofocus: true,
//                        decoration: new InputDecoration(
//                            labelText: 'Middle Name'),
//                      ),
//                      TextField(
//                        controller: _bdayControl,
//                        autofocus: true,
//                        decoration: new InputDecoration(
//                            labelText: 'Date of birth'),
//                      ),
//                      TextField(
//                        controller: _placeControl,
//                        autofocus: true,
//                        decoration: new InputDecoration(
//                            labelText: 'Place of birth'),
//                      ),
//                      TextField(
//                        controller: _sexControl,
//                        autofocus: true,
//                        decoration: new InputDecoration(
//                            labelText: 'Sex'),
//                      ),
//                      TextField(
//                        controller: _isPWDControl,
//                        autofocus: true,
//                        decoration: new InputDecoration(
//                            labelText: 'Person with Disability [Y/N]'),
//                      ),
//                      TextField(
//                        controller: _mshipControl,
//                        autofocus: true,
//                        decoration: new InputDecoration(
//                            labelText: 'Membership'),
//                      ),
//                    ],
//                  )
//              )
//          ),
//          actions: <Widget>[
//            FlatButton(
//              child: Text('Cancel',
//                style: TextStyle(color: Colors.grey),
//              ),
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//            ),
//            RaisedButton(
//              child: Text('Save'),
//              color: Colors.green,
//              textColor: Colors.white,
//              onPressed: () async {
//                user.firstName = _fnameControl.text;
//                user.lastName = _lnameControl.text;
//                user.middleName = _mnameControl.text;
//                user.birthDate = _bdayControl.text;
//                user.placeOfBirth = _placeControl.text;
//                user.sex = _sexControl.text;
//                user.isPwd = _isPWDControl.text;
//                user.membership = _mshipControl.text;
//                setState(() {
//                  _fnameControl.text = user.firstName;
//                  _lnameControl.text = user.lastName;
//                  _mnameControl.text = user.middleName;
//                  _bdayControl.text = user.birthDate;
//                  _placeControl.text = user.placeOfBirth;
//                  _sexControl.text = user.sex;
//                  _isPWDControl.text = user.isPwd;
//                  _mshipControl.text = user.membership;
//
//                });
//                final uid =
//                await Provider.of(context).auth.getCurrentUID();
//                await Provider.of(context)
//                    .db
//                    .collection('userData')
//                    .document(uid)
//                    .setData(user.toJson());
//                Navigator.of(context).pop();
//              },
//            )
//          ],
//        );
//      },
//    );
//  }
//}
//
