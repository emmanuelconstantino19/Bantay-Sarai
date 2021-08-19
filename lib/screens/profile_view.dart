import 'package:flutter/material.dart';
import 'package:bantay_sarai/widgets/provider_widget.dart';
import 'package:intl/intl.dart';
import 'package:bantay_sarai/models/User.dart';
import 'package:bantay_sarai/widgets/custome_list_tile.dart';
import 'package:bantay_sarai/widgets/small_button.dart';

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
                _sexControl.text = user.sex;
                _isPWDControl.text = user.isPwd;
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
                                  child: Text('Sex: ' + _sexControl.text, style: TextStyle(fontSize: 14),),
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
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text('PWD: ' + _isPWDControl.text, style: TextStyle(fontSize: 14),),
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
    final uid = await Provider.of(context).auth.getCurrentUID();
    await Provider.of(context)
        .db
        .collection('userData')
        .doc(uid)
        .get().then((result) {
      user.firstName = result['firstName'];
      user.lastName = result['lastName'];
      user.middleName = result['middleName'];
      user.birthDate = result['birthDate'];
      user.placeOfBirth = result['placeOfBirth'];
      user.sex = result['sex'];
      user.isPwd = result['isPwd'];
      user.membership = result['membership'];
    });
  }

  void _userEditBottomSheet(BuildContext context) {
    showDialog<String>(
      context: context,
      barrierDismissible: false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
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
                          TextFormField(
                            validator: (val) => val.isEmpty ? 'field required' : null,
                            autofocus: true,
                            decoration: new InputDecoration(
                                labelText: 'Date of birth'),
                            controller: _bdayControl,
                          ),
                          TextFormField(
                            validator: (val) => val.isEmpty ? 'field required' : null,
                            autofocus: true,
                            decoration: new InputDecoration(
                                labelText: 'Place of birth'),
                            controller: _placeControl,
                          ),
                          TextFormField(
                            validator: (val) => val.isEmpty ? 'field required' : null,
                            autofocus: true,
                            decoration: new InputDecoration(
                                labelText: 'Sex'),
                            controller: _sexControl,
                          ),
                          TextFormField(
                            validator: (val) => val.isEmpty ? 'field required' : null,
                            autofocus: true,
                            decoration: new InputDecoration(
                                labelText: 'Person with Disability [Y/N]'),
                            controller: _isPWDControl,
                          ),
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
                if(_formKey.currentState.validate()){
                  user.firstName = _fnameControl.text;
                  user.lastName = _lnameControl.text;
                  user.middleName = _mnameControl.text;
                  user.birthDate = _bdayControl.text;
                  user.placeOfBirth = _placeControl.text;
                  user.sex = _sexControl.text;
                  user.isPwd = _isPWDControl.text;
                  user.membership = _mshipControl.text;
                  setState(() {
                    _fnameControl.text = user.firstName;
                    _lnameControl.text = user.lastName;
                    _mnameControl.text = user.middleName;
                    _bdayControl.text = user.birthDate;
                    _placeControl.text = user.placeOfBirth;
                    _sexControl.text = user.sex;
                    _isPWDControl.text = user.isPwd;
                    _mshipControl.text = user.membership;

                  });
                  final uid =
                  await Provider.of(context).auth.getCurrentUID();
                  await Provider.of(context)
                      .db
                      .collection('userData')
                      .doc(uid)
                      .set(user.toJson());
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        );
      },
    );
  }
}


class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  FUser user = FUser("","","","","","","","");
  final TextEditingController _fnameControl = new TextEditingController();
  final TextEditingController _lnameControl = new TextEditingController();
  final TextEditingController _mnameControl = new TextEditingController();
  final TextEditingController _mshipControl = new TextEditingController();
  final TextEditingController _bdayControl = new TextEditingController();
  final TextEditingController _placeControl = new TextEditingController();
  final TextEditingController _sexControl = new TextEditingController();
  final TextEditingController _isPWDControl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
    );
  }

  Widget displayUserInformation(context, snapshot) {
    final authData = snapshot.data;

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
                _sexControl.text = user.sex;
                _isPWDControl.text = user.isPwd;
                _mshipControl.text = user.membership;

                return Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "first name: ${_fnameControl.text}",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "last name: ${_lnameControl.text}",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "middle name: ${_mnameControl.text}",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "birthday: ${_bdayControl.text}",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "place of birth: ${_placeControl.text}",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "sex: ${_sexControl.text}",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Person with Disability: ${_isPWDControl.text}",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "membership: ${_mshipControl.text}",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Contact number: ${authData.phoneNumber ?? 'Anonymous'}", style: TextStyle(fontSize: 20),),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Created: ${DateFormat('MM/dd/yyyy').format(
                            authData.metadata.creationTime)}", style: TextStyle(fontSize: 20),),
                      ),
                      RaisedButton(
                        child: Text("Edit User"),
                        onPressed: () {
                          _userEditBottomSheet(context);
                        },
                      )
                    ],
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
    final uid = await Provider.of(context).auth.getCurrentUID();
    await Provider.of(context)
        .db
        .collection('userData')
        .doc(uid)
        .get().then((result) {
      user.firstName = result['firstName'];
      user.lastName = result['lastName'];
      user.middleName = result['middleName'];
      user.birthDate = result['birthDate'];
      user.placeOfBirth = result['placeOfBirth'];
      user.sex = result['sex'];
      user.isPwd = result['isPwd'];
      user.membership = result['membership'];
    });
  }

  void _userEditBottomSheet(BuildContext context) {
    showDialog<String>(
      context: context,
      barrierDismissible: false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Profile'),
          content: Container(
              child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: _fnameControl,
                        autofocus: true,
                        decoration: new InputDecoration(
                            labelText: 'First Name'),
                      ),
                      TextField(
                        controller: _lnameControl,
                        autofocus: true,
                        decoration: new InputDecoration(
                            labelText: 'Last Name'),
                      ),
                      TextField(
                        controller: _mnameControl,
                        autofocus: true,
                        decoration: new InputDecoration(
                            labelText: 'Middle Name'),
                      ),
                      TextField(
                        controller: _bdayControl,
                        autofocus: true,
                        decoration: new InputDecoration(
                            labelText: 'Date of birth'),
                      ),
                      TextField(
                        controller: _placeControl,
                        autofocus: true,
                        decoration: new InputDecoration(
                            labelText: 'Place of birth'),
                      ),
                      TextField(
                        controller: _sexControl,
                        autofocus: true,
                        decoration: new InputDecoration(
                            labelText: 'Sex'),
                      ),
                      TextField(
                        controller: _isPWDControl,
                        autofocus: true,
                        decoration: new InputDecoration(
                            labelText: 'Person with Disability [Y/N]'),
                      ),
                      TextField(
                        controller: _mshipControl,
                        autofocus: true,
                        decoration: new InputDecoration(
                            labelText: 'Membership'),
                      ),
                    ],
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
                user.firstName = _fnameControl.text;
                user.lastName = _lnameControl.text;
                user.middleName = _mnameControl.text;
                user.birthDate = _bdayControl.text;
                user.placeOfBirth = _placeControl.text;
                user.sex = _sexControl.text;
                user.isPwd = _isPWDControl.text;
                user.membership = _mshipControl.text;
                setState(() {
                  _fnameControl.text = user.firstName;
                  _lnameControl.text = user.lastName;
                  _mnameControl.text = user.middleName;
                  _bdayControl.text = user.birthDate;
                  _placeControl.text = user.placeOfBirth;
                  _sexControl.text = user.sex;
                  _isPWDControl.text = user.isPwd;
                  _mshipControl.text = user.membership;

                });
                final uid =
                await Provider.of(context).auth.getCurrentUID();
                await Provider.of(context)
                    .db
                    .collection('userData')
                    .doc(uid)
                    .set(user.toJson());
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}

