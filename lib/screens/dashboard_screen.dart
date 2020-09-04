import 'package:flutter/material.dart';
import 'package:bantay_sarai/services/auth_service.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text('Signout'),
                    onPressed: () {
                      AuthService().signOut();
                    },
                  ),
                  RaisedButton(
                    child: Text('Add plantation'),
                    onPressed: () {
                      //AuthService().signOut();
                    },
                  ),
                  RaisedButton(
                    child: Text('Edit profile'),
                    onPressed: () {
                      //AuthService().signOut();
                    },
                  )
                ],
            )
        )
    );
  }
}