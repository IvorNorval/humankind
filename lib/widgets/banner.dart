import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:humankind/models/user.dart';
import 'package:humankind/models/users.dart';
import 'package:humankind/screens/register_screen.dart';
import 'package:humankind/screens/sign_in_screen.dart';

class BannerWidget extends StatefulWidget {
  final FirebaseAuth auth;
  final UsersModel users;
  const BannerWidget({
    Key? key,
    required this.auth,
    required this.users,
  }) : super(key: key);

  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  late StreamSubscription lister;
  String _signInS = 'Sign In';
  String _registerS = 'Register';
  int userIndex = -1;
  late UserModel userIn;

  @override
  void initState() {
    _authListener();
    super.initState();
  }

  @override
  void dispose() {
    _signOut();
    lister.cancel();
    super.dispose();
  }

  Future<void> _signOut() async {
    await widget.auth.signOut();
  }

  Future<void> _authListener() async {
    lister = widget.auth.authStateChanges().listen(
      (User? user) {
        setState(
          () {
            if (user == null) {
              _registerS = 'Register';
              _signInS = 'Sign In';
            } else {
              _registerS = 'Sign Out';
              userIndex = widget.users.users.lastIndexWhere((element) =>
                  element.email.trim() == widget.auth.currentUser!.email);
              if (userIndex > -1) {
                userIn = widget.users.users[userIndex];
                _signInS = userIn.name;
              } else {
                _signInS = 'no name';
              }
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.auth.currentUser != null) {
      userIndex = widget.users.users.lastIndexWhere(
          (element) => element.email.trim() == widget.auth.currentUser!.email);
      if (userIndex > -1) {
        userIn = widget.users.users[userIndex];
        _signInS = userIn.name;
      }
    } else {
      _signInS = 'Sign In';
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/crowded-street-yellow.jpg"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
          const Center(
            child: Text(
              'Humankind crowdfunding',
              style: TextStyle(
                fontSize: 24,
                color: Color(0xffc3f73a),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 10,
            child: TextButton(
              onPressed: () {
                if (_signInS == 'Sign In') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignInScreen(
                        auth: widget.auth,
                      ),
                    ),
                  );
                }
              },
              child: Text(
                _signInS,
                style: const TextStyle(
                  fontSize: 20,
                  color: Color(0xffdbf4ad),
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: 10,
            child: TextButton(
              onPressed: () {
                if (_registerS == 'Register') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(
                        auth: widget.auth,
                        users: widget.users,
                      ),
                    ),
                  );
                } else {
                  _signOut();
                }
              },
              child: Text(
                _registerS,
                style: const TextStyle(
                  fontSize: 20,
                  color: Color(0xffdbf4ad),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
