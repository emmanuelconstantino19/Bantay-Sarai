import 'package:flutter/material.dart';
import 'package:bantay_sarai/widgets/provider_widget.dart';
import 'package:intl/intl.dart';
import 'package:bantay_sarai/models/User.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  User user = User("","","","","","","","");
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
    var date = new DateTime.fromMillisecondsSinceEpoch(authData.metadata.creationTimestamp);

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
                            date)}", style: TextStyle(fontSize: 20),),
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
                    .document(uid)
                    .setData(user.toJson());
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}

