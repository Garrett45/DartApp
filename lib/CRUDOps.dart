import 'package:firebase_database/firebase_database.dart';
import 'SignIn.dart';
import 'LoginPage.dart';

//name is grabbed from sign in info

final databaseReference = FirebaseDatabase.instance.reference();

void createRecord(int teamNumber, Map<String, dynamic> data) {
    databaseReference.child(teamNumber.toString()).child(name).set(data);
}

void getData(){
  databaseReference.once().then((DataSnapshot snapshot) {
    print('Data : ${snapshot.value}');
  });
}

void updateData(){
  databaseReference.child('1').update({
    'description': 'J2EE complete Reference'
  });
}

void deleteData(){
  databaseReference.child('1').remove();
}