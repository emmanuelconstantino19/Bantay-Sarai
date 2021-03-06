import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bantay_sarai/screens/dashboard_screen.dart';
import 'package:bantay_sarai/screens/login_screen.dart';
import 'package:bantay_sarai/screens/navigation_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<String> get onAuthStateChanged =>
      _firebaseAuth.onAuthStateChanged.map(
            (FirebaseUser user) => user?.uid,
      );

  // GET UID
  Future<String> getCurrentUID() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  // GET CURRENT USER
  Future getCurrentUser() async {
    return await _firebaseAuth.currentUser();
  }

  //Sign out
  Future signOut() async {
    await FirebaseAuth.instance.signOut();

  }


  Future createUserWithPhone(String phone, BuildContext context) async {
    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 0),
        verificationCompleted: (AuthCredential authCredential) {
          _firebaseAuth.signInWithCredential(authCredential).then((AuthResult result){
            Navigator.of(context).pushReplacementNamed('/home');
          }).catchError((e) {
            showToast('Verification Failed', Colors.red);
            return "error";
          });
        },
        verificationFailed: (AuthException exception) {
          showToast('Verification Failed', Colors.red);
          return "error";
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          final _codeController = TextEditingController();
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: Text("Enter Verification Code From Text Message"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[TextField(controller: _codeController)],
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("submit"),
                  textColor: Colors.white,
                  color: Colors.lightGreen[700],
                  onPressed: () {
                    var _credential = PhoneAuthProvider.getCredential(verificationId: verificationId,
                        smsCode: _codeController.text.trim());
                    _firebaseAuth.signInWithCredential(_credential).then((AuthResult result){
                      //Navigator.of(context).pushReplacementNamed('/home');
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
                    }).catchError((e) {
                      showToast('Incorrect verificiation code', Colors.red);
                      return "error";
                    });
                  },
                )
              ],
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
        });
  }

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


  //SignIn
  signIn(AuthCredential authCreds) {
    FirebaseAuth.instance.signInWithCredential(authCreds);
  }

  signInWithOTP(smsCode, verId) {
    AuthCredential authCreds = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);
    signIn(authCreds);
  }
}