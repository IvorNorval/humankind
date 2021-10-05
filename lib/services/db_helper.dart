import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:humankind/models/users.dart';

late FirebaseFirestore firestore;
late CollectionReference usersRef;
late Stream<DocumentSnapshot> usersStreamRef;
late StreamSubscription streamRef;

void initDb() {
  firestore = FirebaseFirestore.instance;
  usersRef = firestore.collection('users');
}

Future<void> updateUser(UsersModel users) {
  return usersRef
      .doc('ABC123')
      .set(users.toJson())
      .catchError((error) => print("Failed to add user: $error"));
}

Future<void> initStream(Function callback) async {
  streamRef = usersRef.doc('ABC123').snapshots().listen((event) {
    DocumentSnapshot docSnapshot = event;
    UsersModel users = UsersModel.fromJson(docSnapshot.data());
    callback(users);
  });
}

void cancelStream() {
  streamRef.cancel();
}
