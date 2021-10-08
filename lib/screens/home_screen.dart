import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:humankind/models/project_vector.dart';
import 'package:humankind/models/user.dart';
import 'package:humankind/models/users.dart';
import 'package:humankind/services/db_helper.dart';
import 'package:humankind/widgets/banner.dart';
import 'package:humankind/widgets/button1.dart';
import 'package:humankind/widgets/project_list.dart';

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
  bool showProfile = false;
  int userIndex = -1;
  UserModel userIn = UserModel(name: 'anonymous', email: '');
  List<ProjectVector> projects = [];

  Future<void> _authListener() async {
    lister = auth.authStateChanges().listen(
      (User? user) {
        setState(
          () {
            if (user != null) {
              showProfile = true;
              userIndex = users.users.lastIndexWhere(
                  (element) => element.email.trim() == auth.currentUser!.email);
              if (userIndex > -1) {
                userIn = users.users[userIndex];
              }
            } else {
              userIn = UserModel(name: 'anonymous', email: '');
              showProfile = false;
              userIndex = -1;
            }
          },
        );
      },
    );
  }

  void _usersCallback(UsersModel event) {
    setState(() {
      users = event;
      if (auth.currentUser != null) {
        userIndex = users.users.lastIndexWhere(
            (element) => element.email.trim() == auth.currentUser!.email);
        if (userIndex > -1) {
          userIn = users.users[userIndex];
        }
      } else {
        userIn = UserModel(name: 'anonymous', email: '');
      }
      projects.clear();
      for (int u = 0; u < users.users.length; u++) {
        for (int p = 0; p < users.users[u].projects.length; p++) {
          ProjectVector pro = ProjectVector(
              project: users.users[u].projects[p],
              projectIndex: p,
              usersIndex: u);
          projects.add(pro);
        }
      }
    });
  }

  Future<void> _signOut() async {
    await auth.signOut();
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
    _signOut();
    cancelStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffafa060), //c2a878 afa060
        body: Center(
          child: Column(
            children: <Widget>[
              BannerWidget(
                auth: auth,
                users: users,
              ),
              if (showProfile)
                Button1(
                  label: 'Profile',
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserScreen(
                          auth: auth,
                          users: users,
                          index: userIndex,
                        ),
                      ),
                    );
                  },
                ),
              ProjectsWidget(
                projects: projects,
                users: users,
                loggedInUser: userIn,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
