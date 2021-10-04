import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:humankind/models/user.dart';
import 'package:humankind/models/users.dart';
import 'package:humankind/services/db_helper.dart';
import 'package:humankind/widgets/banner.dart';

class HomeScreen extends StatefulWidget {
  final FirebaseAuth auth;
  const HomeScreen({Key? key, required this.auth}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UsersModel users = UsersModel();
  int n = 0;

  @override
  void initState() {
    initDb();
    initStream(_usersCallback);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _usersCallback(UsersModel event) {
    setState(() {
      users = event;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              BannerWidget(
                auth: widget.auth,
              ),
              TextButton(
                onPressed: () {
                  String name = 'user$n';
                  String email = 'name.${n++}@gmail.com';
                  UserModel user = UserModel(name: name, email: email);
                  users.users.add(user);
                  addUser(users);
                },
                child: const Text('add user'),
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
