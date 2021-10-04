import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:humankind/models/users.dart';

late FirebaseFirestore firestore;
late CollectionReference usersRef;
late Stream<DocumentSnapshot> usersStreamRef;

void initDb() {
  firestore = FirebaseFirestore.instance;
  usersRef = FirebaseFirestore.instance.collection('users');
}

Future<void> addUser(UsersModel users) {
  return usersRef
      .doc('ABC123')
      .set(users.toJson())
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}

Future<void> initStream(Function callback) async {
  StreamSubscription<DocumentSnapshot<Object?>> ref =
      usersRef.doc('ABC123').snapshots().listen((event) {
    DocumentSnapshot docSnapshot = event;
    UsersModel users = UsersModel.fromJson(docSnapshot.data());
    callback(users);
  });
}
