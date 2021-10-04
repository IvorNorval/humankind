import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:humankind/models/users.dart';

class UserScreen extends StatefulWidget {
  final FirebaseAuth auth;
  final UsersModel users;
  const UserScreen({Key? key, required this.auth, required this.users})
      : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
