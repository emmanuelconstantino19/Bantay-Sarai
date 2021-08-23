import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bantay_sarai/screens/dashboard_screen.dart';
import 'package:bantay_sarai/screens/login_screen.dart';
import 'package:bantay_sarai/screens/navigation_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //Stream<String> get onAuthStateChanged =>
//      _firebaseAuth.authStateChanges.map(
//            (user) => user?.uid,
//      );

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
    print(phone);
    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 0),
        verificationCompleted: (AuthCredential authCredential) async {
          print("COMPLETED");
          await _firebaseAuth.signInWithCredential(authCredential).then((result){
            Navigator.of(context).pushReplacementNamed('/home');
          }).catchError((e) {
            showToast('Verification Failed', Colors.red);
            return "error";
          });
        },
        verificationFailed: (exception) {
          print("ERROR");
          showToast('Verification Failed', Colors.red);
          return "error";
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          print("CODE");
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
                MaterialButton(
//                  minWidth: double.infinity,
//                  height: 50,
                  onPressed: () async {
                    var _credential = PhoneAuthProvider.getCredential(verificationId: verificationId,
                        smsCode: _codeController.text.trim());
                    await _firebaseAuth.signInWithCredential(_credential).then((result){
                      //Navigator.of(context).pushReplacementNamed('/home');
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
                    }).catchError((e) {
                      showToast('Incorrect verificiation code', Colors.red);
                      return "error";
                    });
                  },
                  color: Color(0xFF369d34),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: Text(
                    "Submit",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18
                    ),
                  ),
                ),
//                FlatButton(
//                  child: Text("submit"),
//                  textColor: Colors.white,
//                  color: Colors.lightGreen[700],
//                  onPressed: () async {
//                    var _credential = PhoneAuthProvider.credential(verificationId: verificationId,
//                        smsCode: _codeController.text.trim());
//                    await _firebaseAuth.signInWithCredential(_credential).then((result){
//                      //Navigator.of(context).pushReplacementNamed('/home');
//                      Navigator.of(context)
//                          .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
//                    }).catchError((e) {
//                      showToast('Incorrect verificiation code', Colors.red);
//                      return "error";
//                    });
//                  },
//                )
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