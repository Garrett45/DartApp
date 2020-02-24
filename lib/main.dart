import 'package:flutter/material.dart';
import 'TeamListView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'LoginPage.dart';
import 'SignIn.dart';

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
            name = user.displayName;
            email = user.email;
            imageUrl = user.photoUrl;
            /// is because there is user already logged
            return TeamListView();
          }

          /// other way there is no user logged.
          return LoginPage();
        }));
  }
}