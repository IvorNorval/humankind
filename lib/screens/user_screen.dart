import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:humankind/models/user.dart';
import 'package:humankind/models/users.dart';

import 'add_project_screen.dart';

class UserScreen extends StatefulWidget {
  final FirebaseAuth auth;
  final UsersModel users;
  final int index;
  const UserScreen(
      {Key? key, required this.auth, required this.users, required this.index})
      : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late UserModel user;
  @override
  void initState() {
    if (widget.index > -1) {
      user = widget.users.users[widget.index];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff6b705c),
      ),
      body: Center(
        child: Column(
          children: [
            Text(user.name),
            Text(user.email),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddProjectScreen(
                        users: widget.users,
                        index: widget.index,
                      ),
                    ),
                  );
                },
                child: const Text('Add project')),
          ],
        ),
      ),
    );
  }
}
