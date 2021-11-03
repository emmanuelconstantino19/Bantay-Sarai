import 'package:flutter/material.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:bantay_sarai/screens/navigation_view.dart';
import 'package:bantay_sarai/services/auth_service.dart';
import 'package:bantay_sarai/widgets/provider_widget.dart';
import 'package:bantay_sarai/screens/login_screen.dart';
import 'package:bantay_sarai/screens/first_screen.dart';
import 'package:bantay_sarai/screens/new_user_profile.dart';
import 'package:bantay_sarai/screens/farmer_login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bantay_sarai/models/User.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      auth: AuthService(),
      db: Firestore.instance,
      child: MaterialApp(
        title: "Bantay Sarai",
        theme: ThemeData(
          primarySwatch: Colors.green,
          primaryColor: Color(0xFF369d34),
        ),
        home: HomeController(),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => HomeController(),
          '/farmerLogIn': (BuildContext context) => FarmerLoginScreen(),
          '/newUserProfile': (BuildContext context) => NewUserProfile()
        },
      ),
    );
  }
}

class HomeController extends StatefulWidget {
  @override
  _HomeControllerState createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {
  FUser user = FUser("","","","","","","","");

  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder<String>(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          if(signedIn){
            return StreamBuilder(
              stream: _getProfileData(context,snapshot.data),
              builder: (context, snapshot) {
                print(snapshot.connectionState);
                if(snapshot.connectionState == ConnectionState.done) {
                  if (user.firstName == null || user.firstName == '') {
                    return NewUserProfile();
                  }
                  return Home();
                }else{
                  return Container(
                    color:Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height:20),
                        Material(
                          color:Colors.white,
                          child: Text("Please wait", style: TextStyle(color:Colors.black,fontSize: 20),),
                        )

                      ],
                    ),
                  );

                }
              },
            );
          }else{
            return FirstScreen();
          }
          //return signedIn ? Home() : FirstScreen();
        }
        return CircularProgressIndicator();
      },
    );
  }

  _getProfileData(BuildContext context, String uid) async* {
    await Provider.of(context)
        .db
        .collection('userData')
        .document(uid)
        .get().then((result) {
          user.firstName = result.data['firstName'];
          user.lastName = result.data['lastName'];
    });
  }
}