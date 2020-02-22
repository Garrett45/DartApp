import 'package:flutter/material.dart';
import 'package:pulling_api_bluealliance/Form.dart';
import 'TeamListView.dart';
import 'CRUD.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'LoginPage.dart';

void main() => runApp(MyApp());

//this is where all of the displayed objects are put
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: FutureBuilder<FirebaseUser>(
            future: FirebaseAuth.instance.currentUser(),
        builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
          if (snapshot.hasData) {
            FirebaseUser user = snapshot.data; // this is your user instance
            /// is because there is user already logged
            return TeamListView();
          }

          /// other way there is no user logged.
          return LoginPage();
        }));
  }
}