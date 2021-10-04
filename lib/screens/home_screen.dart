import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:humankind/models/users.dart';
import 'package:humankind/services/db_helper.dart';
import 'package:humankind/widgets/banner.dart';

import 'user_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late StreamSubscription lister;
  UsersModel users = UsersModel();
  String userEmail = '';
  int n = 0;
  bool showProfile = false;

  Future<void> _authListener() async {
    lister = auth.authStateChanges().listen(
      (User? user) {
        setState(
          () {
            if (user != null) {
              showProfile = true;
            } else {
              showProfile = false;
            }
          },
        );
      },
    );
  }

  void _usersCallback(UsersModel event) {
    setState(() {
      users = event;
    });
  }

  @override
  void initState() {
    initDb();
    _authListener();
    initStream(_usersCallback);
    super.initState();
  }

  @override
  void dispose() {
    lister.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              BannerWidget(
                auth: auth,
                users: users,
              ),
              if (showProfile)
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserScreen(
                          auth: auth,
                          users: users,
                        ),
                      ),
                    );
                  },
                  child: const Text('Profile'),
                ),
              SingleChildScrollView(
                child: SizedBox(
                  height: 500,
                  child: ListView.builder(
                    itemCount: users.users.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(users.users[index].name),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
