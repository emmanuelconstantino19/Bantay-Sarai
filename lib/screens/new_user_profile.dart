import 'package:flutter/material.dart';
import 'package:bantay_sarai/widgets/provider_widget.dart';
import 'package:bantay_sarai/models/User.dart';
import 'package:bantay_sarai/main.dart';

class NewUserProfile extends StatefulWidget {
  @override
  _NewUserProfileState createState() => _NewUserProfileState();
}

class _NewUserProfileState extends State<NewUserProfile> {
  User user = User("","","","","","","","");
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
        appBar: AppBar(
          title: Text("BAGONG FARMER PROFILE"),
          elevation: 1,
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (val) => val.isEmpty ? 'field required' : null,
                      autofocus: true,
                      decoration: new InputDecoration(
                          labelText: 'Apelyido'),
                      controller: _lnameControl,
                    ),
                    TextFormField(
                      validator: (val) => val.isEmpty ? 'field required' : null,
                      autofocus: true,
                      decoration: new InputDecoration(
                          labelText: 'Pangalan'),
                      controller: _fnameControl,
                    ),
                    TextFormField(
                      validator: (val) => val.isEmpty ? 'field required' : null,
                      autofocus: true,
                      decoration: new InputDecoration(
                          labelText: 'Panggitnang Apelyido'),
                      controller: _mnameControl,
                    ),
                    TextFormField(
                      validator: (val) => val.isEmpty ? 'field required' : null,
                      autofocus: true,
                      decoration: new InputDecoration(
                          labelText: 'Araw ng Kapanganakan'),
                      controller: _bdayControl,
                    ),
                    TextFormField(
                      validator: (val) => val.isEmpty ? 'field required' : null,
                      autofocus: true,
                      decoration: new InputDecoration(
                          labelText: 'Lugar ng Kapanganakan'),
                      controller: _placeControl,
                    ),
                    TextFormField(
                      validator: (val) => val.isEmpty ? 'field required' : null,
                      autofocus: true,
                      decoration: new InputDecoration(
                          labelText: 'Kasarian'),
                      controller: _sexControl,
                    ),
                    TextFormField(
                      validator: (val) => val.isEmpty ? 'field required' : null,
                      autofocus: true,
                      decoration: new InputDecoration(
                          labelText: 'Person with Disability (PWD) [Y/N]'),
                      controller: _isPWDControl,
                    ),
                    TextFormField(
                      validator: (val) => val.isEmpty ? 'field required' : null,
                      autofocus: true,
                      decoration: new InputDecoration(
                          labelText: 'Asosasyong Pangmagsasaka, Samahan o Kooperatiba [membership]'),
                      controller: _mshipControl,
                    ),
                    SizedBox(height:20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: InkWell(
                            child: Container(
                              height: 60,
                              //margin: EdgeInsets.symmetric(horizontal: 50),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black,
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(1.0, 1.0),
                                      blurRadius: 5.0,
                                    ),
                                  ]
                              ),
                              child: Center(
                                child: Text("i-submit", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                              ),
                            ),
                            onTap: () async {
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
                                    .document(uid)
                                    .setData(user.toJson());
                                Navigator.pushReplacement(
                                    context, MaterialPageRoute(builder: (BuildContext context) => HomeController()));
                              }
                            },
                          ),
                        ),

                      ],
                    ),

                  ],
                )
            )
        )
    );
  }
}
