import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class HomeScreen extends StatefulWidget {
  final FirebaseAuth auth;
  const HomeScreen({Key? key, required this.auth}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late StreamSubscription lister;

  String _signInS = 'Sign In';
  String _registerS = 'Register';

  @override
  void initState() {
    _authListener();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
              _emailController.text = '';
              _passwordController.text = '';
            } else {
              _registerS = 'Sign Out';
              String name = '';
              if (user.email != null) {
                name = user.email!.split('@').first;
              }
              _signInS = name;
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/images/crowded-street-yellow.jpg"),
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
                          color: Color(0xfffefae0),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      left: 10,
                      child: TextButton(
                        onPressed: () {
                          if (_signInS == 'Sign In') {
                            Navigator.pushNamed(context, 'signIn');
                          }
                        },
                        child: Text(
                          _signInS,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Color(0xfffefae0),
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
                            Navigator.pushNamed(context, 'register');
                          } else {
                            _signOut();
                          }
                        },
                        child: Text(
                          _registerS,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Color(0xfffefae0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
