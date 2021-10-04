import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:humankind/models/users.dart';

late FirebaseFirestore firestore;
late CollectionReference usersRef;
late StreamSubscription streamSub;

void initDb() {
  firestore = FirebaseFirestore.instance;
  usersRef = FirebaseFirestore.instance.collection('users');
}

Future<void> addUser(UsersModel users) {
  return usersRef
      .add(users.toJson())
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}

void initStream(Function streamCallback) {
  streamSub = usersRef.snapshots().listen((event) => streamCallback(event));
}

void dbClose() {
  streamSub.cancel();
}
